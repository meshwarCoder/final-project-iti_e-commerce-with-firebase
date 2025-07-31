import 'package:e_commerce/Features/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/Features/auth/widgets/custom_textfield.dart';
import 'package:e_commerce/Features/home/cubit/home_cubit.dart';
import 'package:e_commerce/core/services/firebase_sevices.dart';
import 'package:e_commerce/core/utils/snackbar.dart';
import 'package:e_commerce/core/utils/vlidation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_commerce/core/widgets/custom_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                showSnackbar(context: context, message: state.message);
                Navigator.pushReplacementNamed(context, 'HomeView');
              } else if (state is AuthError) {
                if (state.error.contains('Email is not verified')) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: const Color(0xFF2B3840),
                      title: const Text(
                        'Email Verification',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: const Text(
                        'Please verify your email address before logging in.',
                        style: TextStyle(color: Colors.white70),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            try {
                              await FirebaseServices.sendEmailVerification();
                              Navigator.pop(context);
                              showSnackbar(
                                context: context,
                                message:
                                    'Verification email sent! Check your inbox.',
                              );
                            } on Exception catch (e) {
                              showSnackbar(
                                context: context,
                                message: e.toString().substring(33),
                              );
                            }
                          },
                          child: const Text(
                            'Send Verification',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  showSnackbar(context: context, message: state.error);
                }
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  AbsorbPointer(
                    absorbing: state is AuthLoading,
                    child: Opacity(
                      opacity: state is AuthLoading ? 0.5 : 1,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 60,
                                  child: SvgPicture.asset(
                                    'assets/images/Rectangle 12.svg',
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  child: SvgPicture.asset(
                                    'assets/images/Rectangle 11.svg',
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SvgPicture.asset('assets/images/LOGO.svg'),
                              Text(
                                'shopping with LOGO',
                                style: GoogleFonts.roboto(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 30),

                          Text(
                            'Welcome Back!',
                            style: GoogleFonts.roboto(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 12),

                          Text(
                            'Log in to existing LOGO account',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 24),

                          CustomTextfield(
                            validation: (value) =>
                                Validation.validateEmail(value),
                            hintText: 'Enter your email',
                            iconData: Icons.person,
                            controller: emailController,
                          ),
                          SizedBox(height: 20),

                          CustomTextfield(
                            obscureText: obscureText,
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                obscureText = !obscureText;
                                setState(() {});
                              },
                            ),
                            hintText: 'Enter your Password',
                            iconData: Icons.lock,
                            validation: (value) {
                              return Validation.validatePassword(value);
                            },
                            controller: passwordController,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  if (emailController.text.isNotEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: const Color(
                                          0xFF2B3840,
                                        ),
                                        title: const Text(
                                          'Reset Password',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        content: const Text(
                                          'Are you sure you want to reset your password?',
                                          style: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              try {
                                                await FirebaseServices.resetPassword(
                                                  emailController.text,
                                                );
                                                Navigator.pop(context);
                                                showSnackbar(
                                                  context: context,
                                                  message:
                                                      'Reset password email sent! Check your inbox.',
                                                );
                                              } catch (e) {
                                                Navigator.pop(context);
                                                if (e.toString().contains(
                                                  'too-many-requests',
                                                )) {
                                                  showSnackbar(
                                                    context: context,
                                                    message:
                                                        'Too many requests. Please wait a few minutes and try again.',
                                                  );
                                                } else {
                                                  showSnackbar(
                                                    context: context,
                                                    message:
                                                        'Error sending reset password email: $e',
                                                  );
                                                }
                                              }
                                            },
                                            child: const Text(
                                              'Send Reset Password',
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    showSnackbar(
                                      context: context,
                                      message:
                                          'Please enter your email address before sending reset password email.',
                                    );
                                  }
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.roboto(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue,
                                    color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 25),

                          CustomButton(
                            name: 'LOGIN',
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await context.read<AuthCubit>().loginUser(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                              context.read<HomeCubit>().getHomeData();
                            },
                          ),
                          SizedBox(height: 30),

                          Text(
                            'Or Sign up using',
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(40, 40, 40, 1),
                            ),
                          ),
                          SizedBox(height: 16),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: SvgPicture.asset(
                                  'assets/icons/facebook.svg',
                                ),
                                onPressed: () {},
                              ),
                              SizedBox(width: 24),
                              IconButton(
                                icon: SvgPicture.asset(
                                  'assets/icons/google.svg',
                                ),
                                onPressed: () {
                                  FirebaseServices.disconnectWithGoogle();
                                  context.read<AuthCubit>().loginWithGoogle();
                                  context.read<HomeCubit>().getHomeData();
                                },
                              ),
                              SizedBox(width: 24),
                              IconButton(
                                icon: SvgPicture.asset(
                                  'assets/icons/apple.svg',
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Don\'t have an account? ',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Sign up',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                        context,
                                        'SignupView',
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  if (state is AuthLoading)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                        child: const Center(
                          child: CircularProgressIndicator(color: Colors.blue),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

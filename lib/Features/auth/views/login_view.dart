import 'package:e_commerce/Features/auth/widgets/button.dart';
import 'package:e_commerce/Features/auth/widgets/custom_textfield.dart';
import 'package:e_commerce/core/services/firebase_sevices.dart';
import 'package:e_commerce/core/utils/snackbar.dart';
import 'package:e_commerce/core/utils/vlidation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                      left: 60,
                      child: SvgPicture.asset('assets/images/Rectangle 12.svg'),
                    ),
                    Positioned(
                      left: 0,
                      child: SvgPicture.asset('assets/images/Rectangle 11.svg'),
                    ),
                  ],
                ),
              ),

              SvgPicture.asset('assets/images/LOGO.svg'),
              SizedBox(height: 40),

              Text(
                'Welcome Back!',
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 15),

              Text(
                'Log in to existing LOGO account',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 40),

              CustomTextfield(
                validation: (value) => Validation.validateEmail(value),
                hintText: 'Enter your email',
                iconData: Icons.person,
                controller: emailController,
              ),
              SizedBox(height: 24),

              CustomTextfield(
                hintText: 'Enter your Password',
                iconData: Icons.lock,
                validation: (value) {
                  return Validation.validatePassword(value);
                },
                controller: passwordController,
              ),
              SizedBox(height: 9),

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
                            backgroundColor: const Color(0xFF2B3840),
                            title: const Text(
                              'Reset Password',
                              style: TextStyle(color: Colors.white),
                            ),
                            content: const Text(
                              'Are you sure you want to reset your password?',
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
                                  style: TextStyle(color: Colors.blue),
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
              SizedBox(height: 30),

              CustomButton(
                name: 'LOGIN',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      await FirebaseServices.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      if (await FirebaseServices.isEmailVerified()) {
                        showSnackbar(
                          context: context,
                          message: 'Login successful!',
                        );
                        Navigator.pushReplacementNamed(context, 'HomeView');
                      } else {
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
                                            'Error sending verification email: $e',
                                      );
                                    }
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
                      }
                    } catch (e) {
                      showSnackbar(
                        context: context,
                        message: 'Error logging in: $e',
                      );
                    }
                  }
                },
              ),
              SizedBox(height: 35),

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
                    icon: SvgPicture.asset('assets/icons/facebook.svg'),
                    onPressed: () {},
                  ),
                  SizedBox(width: 24),
                  IconButton(
                    icon: SvgPicture.asset('assets/icons/google.svg'),
                    onPressed: () {
                      FirebaseServices.signInWithGoogle();
                      showSnackbar(
                        context: context,
                        message: 'Login successful!',
                      );
                      Navigator.pushReplacementNamed(context, 'HomeView');
                    },
                  ),
                  SizedBox(width: 24),
                  IconButton(
                    icon: SvgPicture.asset('assets/icons/apple.svg'),
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
                          Navigator.pushNamed(context, 'SignupView');
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:e_commerce/Features/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/Features/auth/widgets/custom_textfield.dart';
import 'package:e_commerce/core/utils/snackbar.dart';
import 'package:e_commerce/core/utils/vlidation.dart';
import 'package:e_commerce/core/widgets/Custom_appbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_commerce/core/widgets/custom_button.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController adminPasswordController = TextEditingController();
  String? selectedGender;
  bool? isAdmin;
  bool obscureTextpass = true;
  bool obscureTextconfirmPass = true;
  bool obscureTextAdminPass = true;
  bool autoValidate = false;

  final String requiredAdminPassword = "admin123";

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    adminPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Sign Up", actions: []),
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          autovalidateMode: autoValidate
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          key: formKey,
          child: SingleChildScrollView(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  showSnackbar(context: context, message: state.message);
                  Navigator.pop(context);
                } else if (state is AuthError) {
                  showSnackbar(context: context, message: state.error);
                }
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    Opacity(
                      opacity: state is AuthLoading ? 0.5 : 1,
                      child: AbsorbPointer(
                        absorbing: state is AuthLoading,
                        child: Column(
                          children: [
                            Text(
                              'Let’s Get Started!',
                              style: GoogleFonts.roboto(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 7),

                            Text(
                              'Create an account to shop with LOGO',
                              style: GoogleFonts.roboto(
                                color: Color.fromRGBO(81, 81, 81, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 25),
                            CustomTextfield(
                              hintText: 'Full Name',
                              iconData: Icons.person,
                              controller: fullNameController,
                              validation: (value) =>
                                  Validation.validateName(value),
                            ),
                            SizedBox(height: 18),
                            CustomTextfield(
                              hintText: 'Email',
                              iconData: Icons.email,
                              controller: emailController,
                              validation: (value) =>
                                  Validation.validateEmail(value),
                            ),
                            SizedBox(height: 18),
                            CustomTextfield(
                              hintText: 'Phone Number',
                              iconData: Icons.phone,
                              controller: phoneNumberController,
                              validation: (value) =>
                                  Validation.validatePhone(value),
                            ),
                            SizedBox(height: 18),
                            CustomTextfield(
                              hintText: 'Address',
                              iconData: Icons.location_on,
                              controller: addressController,
                              validation: (value) =>
                                  Validation.validateAddress(value),
                            ),
                            SizedBox(height: 18),
                            CustomTextfield(
                              obscureText: obscureTextpass,
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscureTextpass
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  obscureTextpass = !obscureTextpass;
                                  setState(() {});
                                },
                              ),
                              iconData: Icons.lock,
                              controller: passwordController,
                              validation: (value) =>
                                  Validation.validatePassword(value),
                            ),
                            SizedBox(height: 18),
                            CustomTextfield(
                              obscureText: obscureTextconfirmPass,
                              hintText: 'Confirm Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscureTextconfirmPass
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  obscureTextconfirmPass =
                                      !obscureTextconfirmPass;
                                  setState(() {});
                                },
                              ),
                              iconData: Icons.lock,
                              controller: confirmPasswordController,
                              validation: (value) =>
                                  Validation.validateConfirmPassword(
                                    value,
                                    passwordController.text,
                                  ),
                            ),
                            SizedBox(height: 18),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(242, 242, 242, 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile<String>(
                                        title: const Text(
                                          'Male',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                              81,
                                              81,
                                              81,
                                              1,
                                            ),
                                            fontSize: 16,
                                          ),
                                        ),
                                        value: 'male',
                                        groupValue: selectedGender,
                                        fillColor: WidgetStateProperty.all(
                                          Color.fromRGBO(81, 81, 81, 1),
                                        ),

                                        onChanged: (value) {
                                          setState(() {
                                            selectedGender = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile<String>(
                                        fillColor: WidgetStateProperty.all(
                                          Color.fromRGBO(81, 81, 81, 1),
                                        ),
                                        title: const Text(
                                          'Female',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                              81,
                                              81,
                                              81,
                                              1,
                                            ),
                                            fontSize: 16,
                                          ),
                                        ),
                                        value: 'Female',
                                        groupValue: selectedGender,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedGender = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 18),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(242, 242, 242, 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile<bool>(
                                        title: const Text(
                                          'Admin',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                              81,
                                              81,
                                              81,
                                              1,
                                            ),
                                            fontSize: 16,
                                          ),
                                        ),
                                        value: true,
                                        groupValue: isAdmin,
                                        fillColor: WidgetStateProperty.all(
                                          Color.fromRGBO(81, 81, 81, 1),
                                        ),

                                        onChanged: (value) {
                                          setState(() {
                                            isAdmin = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile<bool>(
                                        fillColor: WidgetStateProperty.all(
                                          Color.fromRGBO(81, 81, 81, 1),
                                        ),
                                        title: const Text(
                                          'User',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                              81,
                                              81,
                                              81,
                                              1,
                                            ),
                                            fontSize: 16,
                                          ),
                                        ),
                                        value: false,
                                        groupValue: isAdmin,
                                        onChanged: (value) {
                                          setState(() {
                                            isAdmin = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            if (isAdmin == true) ...[
                              SizedBox(height: 18),
                              CustomTextfield(
                                obscureText: obscureTextAdminPass,
                                hintText: 'Admin Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscureTextAdminPass
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    obscureTextAdminPass =
                                        !obscureTextAdminPass;
                                    setState(() {});
                                  },
                                ),
                                iconData: Icons.admin_panel_settings,
                                controller: adminPasswordController,
                                validation: (value) {
                                  if (isAdmin == true) {
                                    if (value == null || value.isEmpty) {
                                      return 'Admin password is required';
                                    }
                                    if (value != requiredAdminPassword) {
                                      return 'Invalid admin password';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ],

                            SizedBox(height: 30),
                            CustomButton(
                              name: 'CREATE',
                              onPressed: () {
                                setState(() {
                                  autoValidate = true;
                                });
                                if (formKey.currentState!.validate() &&
                                    selectedGender != null &&
                                    isAdmin != null) {
                                  context.read<AuthCubit>().registerUser(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    fullName: fullNameController.text,
                                    phoneNumber: phoneNumberController.text,
                                    address: addressController.text,
                                    gender: selectedGender!,
                                    isAdmin: isAdmin!,
                                    createdAt: DateTime.now(),
                                  );
                                } else {
                                  showSnackbar(
                                    context: context,
                                    message:
                                        'Please fill in all fields correctly',
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 30),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Already have an account? ',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Login here',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pop(context);
                                      },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                    if (state is AuthLoading)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.3),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

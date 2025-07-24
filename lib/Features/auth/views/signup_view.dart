import 'package:e_commerce/Features/auth/models/user_model.dart';
import 'package:e_commerce/Features/auth/widgets/button.dart';
import 'package:e_commerce/Features/auth/widgets/custom_textfield.dart';
import 'package:e_commerce/core/services/firebase_sevices.dart';
import 'package:e_commerce/core/utils/snackbar.dart';
import 'package:e_commerce/core/utils/vlidation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  String? selectedGender;
  bool? isAdmin;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100),
                Text(
                  'Let’s Get Started!',
                  style: GoogleFonts.roboto(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 9),

                Text(
                  'Create an account on MNZL to get all features',
                  style: GoogleFonts.roboto(
                    color: Color.fromRGBO(81, 81, 81, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 34),
                CustomTextfield(
                  hintText: 'Full Name',
                  iconData: Icons.person,
                  controller: fullNameController,
                  validation: (value) => Validation.validateName(value),
                ),
                SizedBox(height: 25),
                CustomTextfield(
                  hintText: 'Email',
                  iconData: Icons.email,
                  controller: emailController,
                  validation: (value) => Validation.validateEmail(value),
                ),
                SizedBox(height: 25),
                CustomTextfield(
                  hintText: 'Phone Number',
                  iconData: Icons.phone,
                  controller: phoneNumberController,
                  validation: (value) => Validation.validatePhone(value),
                ),
                SizedBox(height: 25),
                CustomTextfield(
                  hintText: 'Address',
                  iconData: Icons.location_on,
                  controller: addressController,
                  validation: (value) => Validation.validateAddress(value),
                ),
                SizedBox(height: 25),
                CustomTextfield(
                  hintText: 'Password',
                  iconData: Icons.lock,
                  controller: passwordController,
                  validation: (value) => Validation.validatePassword(value),
                ),
                SizedBox(height: 25),
                CustomTextfield(
                  hintText: 'Confirm Password',
                  iconData: Icons.lock,
                  controller: confirmPasswordController,
                  validation: (value) => Validation.validateConfirmPassword(
                    value,
                    passwordController.text,
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
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
                                color: Color.fromRGBO(81, 81, 81, 1),
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
                                color: Color.fromRGBO(81, 81, 81, 1),
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
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
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
                                color: Color.fromRGBO(81, 81, 81, 1),
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
                                color: Color.fromRGBO(81, 81, 81, 1),
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
                SizedBox(height: 30),
                CustomButton(
                  name: 'CREATE',
                  onPressed: () async {
                    if (formKey.currentState!.validate() &&
                        selectedGender != null &&
                        isAdmin != null) {
                      try {
                        await FirebaseServices.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        UserModel user = UserModel(
                          uid: FirebaseServices.getCurrentUser()!.uid,
                          fullName: fullNameController.text,
                          email: emailController.text,
                          phoneNumber: phoneNumberController.text,
                          address: addressController.text,
                          password: passwordController.text,
                          gender: selectedGender!,
                          isAdmin: isAdmin!,
                        );
                        await FirebaseServices.createUserInFirestore(user);
                        await FirebaseServices.sendEmailVerification();
                        showSnackbar(
                          context: context,
                          message:
                              'Account created successfully! Please check your email for verification.',
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        showSnackbar(
                          context: context,
                          message: 'Error creating account: $e',
                        );
                      }
                    } else {
                      showSnackbar(
                        context: context,
                        message: 'Please fill in all fields correctly',
                      );
                    }
                  },
                ),
                SizedBox(height: 45),
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
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

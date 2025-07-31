import 'package:e_commerce/Features/auth/models/user_model.dart';
import 'package:e_commerce/Features/profile/views/firebase/editprofile_services.dart';
import 'package:e_commerce/core/constant/colors.dart';
import 'package:e_commerce/core/utils/vlidation.dart';
import 'package:e_commerce/core/widgets/Custom_appbar.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileView> {
  bool isEditing = false;
  bool obscureText = true;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Stream<UserModel> users =
        FirebaseEditProfileServices.getCurrentUserStream();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomAppBar(
        title: 'Profile',
        actions: [
          IconButton(
            onPressed: () async {
              if (isEditing) {
                await FirebaseEditProfileServices.updateUserData(
                  fullName: fullNameController.text,
                  phoneNumber: phoneNumberController.text,
                  address: addressController.text,
                  password: passwordController.text,
                );
              }
              setState(() {
                isEditing = !isEditing;
              });
            },
            icon: Icon(
              isEditing ? Icons.save : Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: StreamBuilder<UserModel>(
        stream: users,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = snapshot.data!;
          fullNameController.text = user.fullName;
          phoneNumberController.text = user.phoneNumber;
          addressController.text = user.address;
          passwordController.text = user.password;

          return SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [KColors.secondaryColor, KColors.primaryColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Text(
                          user.fullName[0],
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user.email,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildFloatingField(
                        label: 'Full Name',
                        controller: fullNameController,
                        icon: Icons.person,
                        readOnly: !isEditing,
                        validator: Validation.validateName,
                      ),
                      const SizedBox(height: 15),
                      _buildFloatingField(
                        label: 'Phone Number',
                        controller: phoneNumberController,
                        icon: Icons.phone,
                        readOnly: !isEditing,
                        validator: Validation.validatePhone,
                      ),
                      const SizedBox(height: 15),
                      _buildFloatingField(
                        label: 'Address',
                        controller: addressController,
                        icon: Icons.location_on,
                        readOnly: !isEditing,
                        validator: Validation.validateAddress,
                      ),
                      const SizedBox(height: 15),
                      _buildFloatingField(
                        label: 'Password',
                        controller: passwordController,
                        icon: Icons.lock,
                        readOnly: !isEditing,
                        validator: Validation.validatePassword,
                        obscure: obscureText,
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloatingField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required bool readOnly,
    required String? Function(String?) validator,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: KColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

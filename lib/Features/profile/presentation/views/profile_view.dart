import 'package:e_commerce/Features/profile/presentation/cubits/get%20profile%20data%20cubit/get_profile_data_cubit_cubit.dart';
import 'package:e_commerce/Features/profile/presentation/cubits/update%20profile%20data%20cubit/update_profile_cubit.dart';
import 'package:e_commerce/Features/profile/presentation/cubits/update%20profile%20data%20cubit/update_profile_state.dart';
import 'package:e_commerce/Features/profile/presentation/widgets/text_field.dart';
import 'package:e_commerce/core/constant/colors.dart';
import 'package:e_commerce/core/utils/vlidation.dart';
import 'package:e_commerce/core/widgets/Custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileView> {
  final formKey = GlobalKey<FormState>();
  bool isEditing = false;
  bool obscureText = true;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String email = '';

  //اول ما يدخل الصفحة يحصل على بياناته من firestore
  @override
  void initState() {
    super.initState();
    context.read<GetProfileDataCubitCubit>().getProfileData();
  }

  // ازالة البيانات عند انتهاء الصفحة
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
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomAppBar(
        title: 'Profile',
        actions: [
          IconButton(
            onPressed: () async {
              if (isEditing) {
                if (formKey.currentState!.validate()) {
                  context.read<ProfileCubit>().updateProfile(
                    fullName: fullNameController.text,
                    phoneNumber: phoneNumberController.text,
                    address: addressController.text,
                    password: passwordController.text,
                  );
                }
              }
              context.read<GetProfileDataCubitCubit>().getProfileData();

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
      body: SingleChildScrollView(
        child: BlocConsumer<GetProfileDataCubitCubit, GetProfileDataCubitState>(
          listener: (context, state) {
            if (state is ProfileSuccessUpdate) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Updated successfully')));
            }
            if (state is ProfileLoadedData) {
              fullNameController.text = state.user.fullName;
              phoneNumberController.text = state.user.phoneNumber;
              addressController.text = state.user.address;
              passwordController.text = state.user.password;
              email = state.user.email;
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Opacity(
                  opacity: state is ProfileLoadingData ? 0.5 : 1,
                  child: Column(
                    children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              KColors.secondaryColor,
                              KColors.primaryColor,
                            ],
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
                                state is ProfileLoadedData
                                    ? state.user.fullName[0]
                                    : '',
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              state is ProfileLoadedData
                                  ? state.user.fullName
                                  : fullNameController.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              state is ProfileLoadedData
                                  ? state.user.email
                                  : email,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // الفورم
                      Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              showDataInTextField(
                                label: 'Full Name',
                                controller: fullNameController,
                                icon: Icons.person,
                                readOnly: !isEditing,
                                validator: Validation.validateName,
                              ),
                              const SizedBox(height: 15),
                              showDataInTextField(
                                label: 'Phone Number',
                                controller: phoneNumberController,
                                icon: Icons.phone,
                                readOnly: !isEditing,
                                validator: Validation.validatePhone,
                              ),
                              const SizedBox(height: 15),
                              showDataInTextField(
                                label: 'Address',
                                controller: addressController,
                                icon: Icons.location_on,
                                readOnly: !isEditing,
                                validator: Validation.validateAddress,
                              ),
                              const SizedBox(height: 15),
                              showDataInTextField(
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
                      ),
                    ],
                  ),
                ),
                if (state is ProfileLoadingData)
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2.1,
                    right: MediaQuery.of(context).size.width / 2,
                    child: const CircularProgressIndicator(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

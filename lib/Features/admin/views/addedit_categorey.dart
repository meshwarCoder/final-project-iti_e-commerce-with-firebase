import 'package:flutter/material.dart';
import 'package:e_commerce/Features/home/models/category_model.dart';
import 'package:e_commerce/Features/admin/firebase/admin_services.dart';
import 'package:e_commerce/core/constant/colors.dart';
import 'package:e_commerce/Features/auth/widgets/custom_textfield.dart';

class AddEditCategoryView extends StatefulWidget {
  const AddEditCategoryView({super.key, this.category});
  final CategoryModel? category;

  @override
  State<AddEditCategoryView> createState() => _AddEditCategoryViewState();
}

class _AddEditCategoryViewState extends State<AddEditCategoryView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      _nameController.text = widget.category!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.category == null ? "Add Category" : "Update Category",
        ),
        backgroundColor: KColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextfield(
                iconData: Icons.category,
                controller: _nameController,
                validation: (value) =>
                    value!.isEmpty ? "Please enter category name" : null,
                hintText: 'Category Name',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: KColors.primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final category = CategoryModel(
                      id: '',
                      name: _nameController.text,
                    );

                    await AdminServices.addCategory(category);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  widget.category == null ? "Add Category" : "Update Category",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

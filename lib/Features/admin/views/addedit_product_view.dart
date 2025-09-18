import 'package:e_commerce/Features/auth/widgets/custom_textfield.dart';
import 'package:e_commerce/Features/home/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/Features/home/models/product_model.dart';
import 'package:e_commerce/Features/admin/firebase/admin_services.dart';
import 'package:e_commerce/core/constant/colors.dart';

class AddEditProductView extends StatefulWidget {
  const AddEditProductView({super.key, this.product});
  final ProductModel? product;

  @override
  State<AddEditProductView> createState() => _AddEditProductViewState();
}

class _AddEditProductViewState extends State<AddEditProductView> {
  final _formKey = GlobalKey<FormState>();

  String? selectedCategoryId;
  List<CategoryModel> categories = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadCategories();

    // لو في منتج (تعديل) → نملأ الحقول
    if (widget.product != null) {
      _titleController.text = widget.product!.title;
      _descriptionController.text = widget.product!.description;
      _priceController.text = widget.product!.price.toString();
      _imageUrlController.text = widget.product!.imageUrl;
      selectedCategoryId = widget.product!.categoryId;
    }
  }

  Future<void> loadCategories() async {
    categories = await AdminServices.getCategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.product == null ? "Add Product" : "Update Product"),
        backgroundColor: KColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextfield(
                  iconData: Icons.title,
                  controller: _titleController,
                  validation: (value) =>
                      value!.isEmpty ? "Please enter product title" : null,
                  hintText: 'Title',
                ),
                SizedBox(height: 16),
                CustomTextfield(
                  iconData: Icons.description,
                  controller: _descriptionController,
                  validation: (value) =>
                      value!.isEmpty ? "Please enter description" : null,
                  hintText: 'Description',
                ),
                SizedBox(height: 16),
                CustomTextfield(
                  iconData: Icons.currency_pound,
                  controller: _priceController,
                  validation: (value) =>
                      value!.isEmpty ? "Please enter price" : null,
                  hintText: 'Price',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                CustomTextfield(
                  iconData: Icons.image,
                  controller: _imageUrlController,
                  validation: (value) =>
                      value!.isEmpty ? "Please enter image URL" : null,
                  hintText: 'Image URL',
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  validator: (value) =>
                      value == null ? "Please select a category" : null,
                  initialValue: selectedCategoryId,
                  decoration: InputDecoration(labelText: 'Select Category'),
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category.id,
                      child: Text(category.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategoryId = value;
                    });
                  },
                ),

                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: KColors.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.product == null) {
                        // إضافة منتج جديد
                        final product = ProductModel(
                          id: "",
                          title: _titleController.text,
                          description: _descriptionController.text,
                          price: num.parse(_priceController.text),
                          imageUrl: _imageUrlController.text,
                          categoryId: selectedCategoryId!,
                          isAvailable: true,
                        );
                        await AdminServices.addProduct(product);
                      } else {
                        await AdminServices.updateProduct(widget.product!.id, {
                          'title': _titleController.text,
                          'description': _descriptionController.text,
                          'price': num.parse(_priceController.text),
                          'imageUrl': _imageUrlController.text,
                          'categoryId': selectedCategoryId,
                        });
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    widget.product == null ? "Add Product" : "Update Product",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

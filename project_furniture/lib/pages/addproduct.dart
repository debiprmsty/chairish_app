import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_furniture/models/product.dart';
import 'package:project_furniture/pages/products.dart';
import 'package:project_furniture/services/api.dart';
import 'package:project_furniture/services/databasehelper.dart';
import 'package:project_furniture/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ProductAdd extends StatefulWidget {
  final Product? product;
  const ProductAdd({Key? key, this.product}) : super(key: key);

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final _formKey = GlobalKey<FormState>();
  final ProductController _productController = ProductController();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final imageController = TextEditingController();
  final priceController = TextEditingController();

   late File? _getImage;

 Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      _getImage = File(pickedFile!.path);
    });

    imageController.text = _getImage!.path;
  }


  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      titleController.text = widget.product!.title;
      descController.text = widget.product!.desc;
      imageController.text = widget.product!.image;
      priceController.text = widget.product!.price.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: biruHitam,
        title: Text(
          'Create Data',
          style: headLandBold.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product name.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: descController,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product description.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: imageController,
                        decoration: InputDecoration(labelText: 'Image URL'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter product image URL.';
                          }
                          return null;
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context){
                            return Container(
                                height: 150.0,
                                child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.camera_alt),
                                    title: Text('Camera'),
                                    onTap: () {
                                    _pickImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.photo_library),
                                  title: Text('Gallery'),
                                  onTap: () {
                                    _pickImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.add_a_photo),
                    tooltip: 'Add Image',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  decoration: InputDecoration(
                      labelText: 'Price',
                      prefixText: '\Rp ',
                      ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product price.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                FilledButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        String title = titleController.text;
                        String desc = descController.text;
                        String image = imageController.text;
                        var price = priceController.text;
                        print(title);
                        
                        var data = {
                          'title' : title,
                          'desc' : desc,
                          'image' : image,
                          'price' : price 
                        };


                        await _productController.createProduct(title, desc, price, image);
                    
                  }

                 

                }, child: Text('Submit'))
              ],
            ),
          )
        )
      ),
    );
  }
}








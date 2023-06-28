// ignore_for_file: unnecessary_import

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_furniture/pages/updateProduct.dart';
import 'package:project_furniture/services/api.dart';
import 'package:project_furniture/services/databasehelper.dart';
import 'package:project_furniture/models/product.dart';
import 'package:project_furniture/pages/addproduct.dart';
import 'package:project_furniture/theme.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';




class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<List<Product>> _productListFuture;
  Key myKey = UniqueKey();

  bool _isLoading = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final ProductController _productController = ProductController();
  List<Product> _products = [];

  Future<void> fetchProducts() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final products = await _productController.getProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
      super.initState();
      fetchProducts();
  }
 

  






  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: biruHitam,
        title: Text('Kelola Product', style: headLandBold.copyWith(color: Colors.white),),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: _isLoading ? Center(child: CircularProgressIndicator(),) : 
        ListView.builder(
          itemCount: _products.length,
          itemBuilder: (BuildContext context, int index) {
            final product = _products[index];
            
           String originalString = product.image;
           String image = originalString.replaceFirst("/storage/photos/", "");

            return Container(
              width: width,
              height: 65,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0,2), // changes position of shadow
                    ),
                  ],
              ),
              child: ListTile(
                  leading: Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: 80,
                  height: 160,
                  child: Image.network("https://apichairish.000webhostapp.com/api/products/images/$image", fit: BoxFit.cover),
                ),
                title: Container(
                  margin: const EdgeInsets.only(top: 6),
                  child: Text(product.title, style: headLandBold.copyWith(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis,)
                ),
                trailing: Container(
                  width: 100,
                  child: Wrap(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return UpdateProduct(productId: product.id);
                        }));
                      }, icon: Icon(Icons.edit, color: biruLangit,)),
                      IconButton(
                        onPressed: (){
                               _productController.deleteProduct(product.id).then((value) {
                                setState(() {
                                  fetchProducts();
                                });
                               });
                        }
                              , icon: Icon(Icons.delete, color: Colors.pink,))
                    ],
                  )
                ),
                onTap: () {
                  // do something when the item is tapped
                },
              ),
            );
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: biruHitam,
        onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const ProductAdd();
        }));
      }, 
      child: Icon(Icons.add,),
      ),
    );
  }
}







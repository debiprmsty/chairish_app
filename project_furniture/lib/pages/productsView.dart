import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_furniture/models/product.dart';
import 'package:project_furniture/services/api.dart';
import 'package:project_furniture/pages/productDetail.dart';
import 'package:project_furniture/services/databasehelper.dart';
import 'package:project_furniture/theme.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
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
    final products = await _productController.getProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
  }

  @override
  void initState() {
      super.initState();
      fetchProducts();
  }

  

  
  @override
  Widget build(BuildContext context) {
     double paddingTop = MediaQuery.of(context).padding.top + 10;
     double paddingBottom = MediaQuery.of(context).padding.bottom + 50;
     double width = MediaQuery.of(context).size.width;
     double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: paddingTop),
          child: Padding(
            padding: const EdgeInsets.only(left: 13, right: 13),
            child: Column(
              children: [
                Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 6),
                  child: Text('Find your best\nfurniture', style: headLandBold.copyWith(fontSize: 23),),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search ...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    focusColor: Colors.black,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: height * 0.5 + 150,
                  child: _isLoading ? Center(child: CircularProgressIndicator(),) :
                  GridView.builder(
                        
                    physics: ScrollPhysics(),
                    itemCount:_products.length,
                    
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0, // ubah nilai crossAxisSpacing menjadi lebih besar
                      mainAxisSpacing: 0,
                      childAspectRatio: (3/5),
                    ),
                    itemBuilder: (BuildContext context, int index) {
  
                       final product = _products[index];
            
                      String originalString = product.image;
                      String image = originalString.replaceFirst("/storage/photos/", "");
  
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return ProductDetailPage(productId: product.id,);
                          }));
                        },
                        child: Container(
                        width: 196,
                                  
                        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                        
                        child: Card(
                          elevation: 7,
                          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(8) ,child: Image.network("https://apichairish.000webhostapp.com/api/products/images/$image", fit: BoxFit.cover , height: 160, width: width,)),
                                  const SizedBox(
                                  height: 8,
                                  ),
                                  Text(product.title, style: headLandBold.copyWith(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis, softWrap: true,),
                                  const SizedBox(
                                  height: 5,
                                  ),
                                  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Category", style: headLand.copyWith(fontSize:8, color: Colors.grey),),
                                    Text("Rp. ${product.price}", style: headLand.copyWith(fontSize:8, color: Colors.amber),)
                                  ],
                                  
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                Row(
                                  children: [
                                    Image.asset('asset/images/6.jpg', height:12, width: 12,),
                                    const SizedBox(width: 5,),
                                    Text("4/5", style: headLand.copyWith(fontSize: 8),)
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                                          ),
                      );
                  
                    }
                  )
                ),
                const SizedBox(
                  height: 8,
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}



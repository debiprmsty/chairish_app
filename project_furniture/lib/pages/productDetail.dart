import 'package:flutter/material.dart';
import 'package:project_furniture/models/product.dart';
import 'package:project_furniture/services/api.dart';
import 'package:project_furniture/theme.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;
  const ProductDetailPage({super.key,required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ProductController _productController = ProductController();

  int quantity = 0;


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var dataId = widget.productId;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Detail", style: headLandBold,),
        centerTitle: true,
        actions: [Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Icon(Icons.dialpad_outlined),
        )],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: FutureBuilder<Product>(
            future: _productController.getProduct(dataId),
            builder: ((context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                 return Center(
                    child: CircularProgressIndicator(), // Indikator loading
                  );
              }else if(snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }else if(snapshot.hasData) {
                Product product = snapshot.data!;
                String originalString = product.image;
                String image = originalString.replaceFirst("/storage/photos/", "");
                return Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        height: 325,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0,2),
                            )
                          ]
                        ),
                        child: ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network("https://apichairish.000webhostapp.com/api/products/images/$image", fit: BoxFit.cover,))
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Text(product.title, style: headLandBold.copyWith(fontSize: 23)),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text("Category", style: headLand.copyWith(fontSize: 12, color: Colors.grey),),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Image.asset('asset/images/6.jpg', height: 18, width: 18,),
                          const SizedBox(width: 5,),
                          Text("4/5", style: headLand.copyWith(fontSize: 12),)
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text("Detail", style: headLandBold.copyWith(fontSize: 15),),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text(product.desc, style: headLand.copyWith(fontSize: 12, color: Colors.grey),),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(8),
                         alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            color: biruHitam
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             InkWell(
                              onTap: (){
                                setState(() {
                                  quantity++;
                                });
                              },
                               child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                 child: Center(child: Icon(Icons.add, color: Colors.black,size: 17,)),
                               ),
                             ),
                             Container(margin: const EdgeInsets.symmetric(horizontal: 8),child: Text("$quantity",style: headLandBold.copyWith(fontSize:13, color: Colors.white),)),
                             InkWell(
                              onTap: () {
                                setState(() {
                                  if(quantity != 0) {
                                    quantity--;
                                  }
                                });
                              },
                               child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                 child: Center(child: Icon(Icons.remove, color: Colors.black,size: 17,)),
                               ),
                             ),
                            ],
                          ),
                        ),
                      ),
                        
                        
                        
                
                    ],
                  ),
                );
              }else {
                return Text('Tidak ada data');
              }
            })
          ),
        ),
      ),
      floatingActionButton: Container(
        width: width - 70,
        height: 60,
        decoration: BoxDecoration(
          color: biruHitam,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Add To Chart',style: headLand.copyWith(fontSize:14, color: Colors.white),),
              const SizedBox(
                width: 12,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35/2),
                  color: Colors.white
                ),
                child: Center(child: Icon(Icons.shopping_cart_outlined, color: biruHitam,size: 18,))
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
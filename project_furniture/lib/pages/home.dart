import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_furniture/models/product.dart';
import 'package:project_furniture/models/category.dart';
import 'package:project_furniture/pages/aboutPage.dart';
import 'package:project_furniture/pages/login.dart';
import 'package:project_furniture/pages/productDetail.dart';
import 'package:project_furniture/pages/profile.dart';
import 'package:project_furniture/services/api.dart';
import 'package:project_furniture/services/authService.dart';
import 'package:project_furniture/services/categoryApi.dart';
import 'package:project_furniture/services/databasehelper.dart';
import 'package:project_furniture/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  bool isWishList1 = false;
  bool isWishList2 = false;
  bool isLoggedIn = false;

  bool _isLoading = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final ProductController _productController = ProductController();
  final CategoryController _categoryController = CategoryController();
  final AuthService _authService = AuthService();

  List<Product> _products = [];
  List<Category> _categories = [];
  String? token;

  Future<void> getToken() async {
    token = await _authService.getToken();

     if(token != null) {
        print('Token : $token');
     }else {
      print('Pengguna belum login');
     } 
  }

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

  Future<void> fetchCategories() async {
    setState(() {
      _isLoading = true;
    });
    final categories= await _categoryController.getCategories();
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
  }

  // Future<void> checkLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('token');

  //   if (token != null && token.isNotEmpty) {
  //     // User is logged in
  //     setState(() {
  //       isLoggedIn = true;
  //     });
  //   } else {
  //     // User is not logged in
  //     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
  //       return LoginPage();
  //     }));
  //   }
  // }


  @override
  void initState() {
      super.initState();
      fetchProducts();
      fetchCategories();
      getToken();
      // checkLoginStatus();
  }


  
  
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(token);
    return  Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        }, icon: const Icon(Icons.menu, color: Colors.black,)),
        elevation: 0,
        backgroundColor: Colors.white,
        actions:  [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return ProfilePage();
                }));
              },
              child: CircleAvatar(
                backgroundImage: AssetImage('asset/images/4.jpg', package: null),
              ),
            ),
          )
        ],
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(bottom: 20),
          width: width,
          child: Column(
            children: [
              // judul
              Container(
                width: width,
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 13),
                child: Text('Best Furniture\nin your home', style: headLandBold.copyWith(fontSize: 23),),
              ),
      
              // search & filter
              Container(
                width: width,
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 13),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
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
                      )
                    ),
                    const SizedBox(
                      width: 17,
                    ),
                    FilledButton(
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20))                        
                        ),
                        padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 12, horizontal: 9)),
                        backgroundColor: MaterialStatePropertyAll(Colors.grey[200])
                      ),
                      child: const Icon(Icons.sort_rounded, color: Colors.grey,),
                      onPressed: () {},
                      )
                  ],
                ),
              ),
              
              // judul rekomendasi
              const SizedBox(
                height: 15,
              ),
              Container(
                width: width,
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 13),
                child: const Text('Rekomendasi', style: headLandBold,),
              ),
              const SizedBox(
                height: 6,
              ),
              
              // Produk Rekomendasi
              Container(
                width: width,
                height: 80,
                margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 13),
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
                    padding: const EdgeInsets.only(top: 5),
                    width: 80,
                    height: 160,
                    child: Image.asset('asset/images/1.png', fit: BoxFit.cover),
                  ),
                  title: Container(
                    margin: const EdgeInsets.only(top: 6),
                    child: Text('Kursi Abu monitor', style: headLandBold.copyWith(fontSize: 12),)
                  ),
                  subtitle: Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Image.asset('asset/images/6.jpg', width: 20, height: 20,),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('4.5/5',style: headLandBold.copyWith(fontSize: 10),)
                      ],
                    ),
                  ),
                  trailing: Container(
                    margin: const EdgeInsets.only(top: 15),
                    width: 30,
                    child: FilledButton(
                      style: ButtonStyle(
                        padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 8,horizontal: 2)),
                        backgroundColor: const MaterialStatePropertyAll(biruHitam),
                        shape: MaterialStatePropertyAll(
                          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20))
                        )
                      ),
                      onPressed: () {}, 
                      child: const Icon(Icons.arrow_forward, color: Colors.white,)
                      ),
                  ),
                  onTap: () {
                    // do something when the item is tapped
                  },
                ),
              ),
      
              // Judul Kategori
              const SizedBox(
                height: 10,
              ),
              Container(
                width: width,
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 13),
                child: const Text('Categories', style: headLandBold,),
              ),
              const SizedBox(
                height: 10,
              ),
      
              // Kategori Button
              Container(
                width: width,
                height: 65,
                margin: const EdgeInsets.only(left: 13 ,right: 13),
                child: _isLoading ? Center(child: CircularProgressIndicator(),) : ListView.builder(
                  itemCount: _categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    final ctgs = _categories[index];
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: FilledButton(
                          style: ButtonStyle(
                            padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 21, horizontal: 9)),
                            shape: MaterialStatePropertyAll(
                              ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20))                        
                            ),
                            backgroundColor: MaterialStatePropertyAll(Colors.grey[200])
                          ),
                          onPressed: () {
                            
                          }, 
                          child: Text(ctgs.category_name, style: headLandBold,)
                        ),
                    );
                  }
                )
              ),
              const SizedBox(
                height: 35,
              ),
      
              // Judul Produk Populer
              Container(
                width: width,
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Top Chair', style: headLandBold,),
                    
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
      
              // Produk Populer
              Container(
                width: width,
                height: 280,
                margin: const EdgeInsets.only(left: 3),
                child: _isLoading ? Center(child: CircularProgressIndicator(),) : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _products.length,
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
                        height: 500,
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
                  },
                ) 
              ),
      
            ],
          ),
        ),
      ),
    );
  }
}




class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: biruLangit
              ),
              alignment: Alignment.center,
              height: 100,
              child: Text('MB Shop', style: headLandBold.copyWith(color: Colors.white, fontSize: 26),),
            )
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text('About', style: headLandBold.copyWith(color: Colors.grey),),
            onTap: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const AboutPage();
                }));
            },
          ),
          ListTile(
            leading: Icon(Icons.output),
            title: Text('Logout', style: headLandBold.copyWith(color: Colors.grey),),
            onTap: () {
              // TODO: Implement profile page.
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
               
            
            },
          ),
        ],
      ),
    );
  }
}



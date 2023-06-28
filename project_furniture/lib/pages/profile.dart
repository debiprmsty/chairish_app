import 'package:flutter/material.dart';
import 'package:project_furniture/pages/products.dart';
import 'package:project_furniture/theme.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: biruHitam,
        title: Text('Profile', style: headLandBold.copyWith(color: Colors.white),),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.25 + 75,
              width: width,
              decoration: const BoxDecoration(
                color: biruHitam,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)
                )
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('asset/images/5.jpg', package: null),
                      ),
                   const SizedBox(
                    height: 8,
                   ),
                   Text('Debi Pramesty', style: headLandBold.copyWith(fontSize: 18, color: Colors.white),),
                   const SizedBox(
                    height: 8,
                   ),
                   Text('TRPL | 21', style: headLand.copyWith(fontSize: 8, color: Colors.white),)
                  ],
                )
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    height: 56,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            blurRadius: 3,
                            offset: Offset(2, 2),
                            spreadRadius: 1
                          )
                      ]
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.person, color: biruHitam,),
                      title: Text('Profile', style: headLandBold.copyWith(fontSize: 12, color: biruHitam),),
                      trailing: const Icon(Icons.chevron_right_rounded, color: biruHitam, size: 22,),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return const ProductPage();
                      }));
                    },
                    child: Container(
                      height: 56,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              blurRadius: 3,
                              offset: Offset(2, 2),
                              spreadRadius: 1
                            )
                        ]
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.shopping_cart_rounded, color: biruHitam,),
                        title: Text('Kelola Produk', style: headLandBold.copyWith(fontSize: 12, color: biruHitam),),
                        trailing: const Icon(Icons.chevron_right_rounded, color: biruHitam, size: 22,),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
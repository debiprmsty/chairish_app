import 'package:flutter/material.dart';
import 'package:project_furniture/theme.dart';


class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  
  get height => null;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: biruHitam,
        title: Text('About', style: headLandBold.copyWith(color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.5 + 70,
              width: width,
              decoration: const BoxDecoration(
                color: biruHitam,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)
                )
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('asset/images/7.png', height: 150, width: 150,),
                    Text('Chairish Furniture App', style: headLandBold.copyWith(fontSize: 15, color: Colors.white),),
                    const SizedBox(
                      height: 8,
                    ),
                    Text('Version 1.0.0.', style: headLand.copyWith(fontSize: 12, color: Colors.white),),
                  ]
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Container(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     const SizedBox(
                      height: 8,
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
                              leading: const Icon(Icons.lock_person, color: biruHitam,),
                              title: Text('Kebijakan Privasi', style: headLandBold.copyWith(fontSize: 12, color: biruHitam),),
                              trailing: const Icon(Icons.chevron_right_rounded, color: biruHitam, size: 22,),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
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
                              leading: const Icon(Icons.help, color: biruHitam,),
                              title: Text('Help', style: headLandBold.copyWith(fontSize: 12, color: biruHitam),),
                              trailing: const Icon(Icons.chevron_right_rounded, color: biruHitam, size: 22,),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
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
                              leading: const Icon(Icons.settings, color: biruHitam,),
                              title: Text('Settings', style: headLandBold.copyWith(fontSize: 12, color: biruHitam),),
                              trailing: const Icon(Icons.chevron_right_rounded, color: biruHitam, size: 22,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          ]
        ),
      )
    );
  }
}
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_furniture/pages/login.dart';
import 'package:project_furniture/theme.dart';
import 'package:project_furniture/services/authApi.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;

  final AuthController _authController = AuthController();
    bool isValidEmail(String value) {
    // Implementasi validasi email sesuai format yang diinginkan
    // Misalnya menggunakan regular expression atau pustaka email_validator
    // Di sini hanya contoh sederhana untuk memeriksa email memiliki '@' dan '.'
    return value.contains('@') && value.contains('.');
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2), // Durasi snackbar ditampilkan
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            TextButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return const LoginPage();
              }));
            }, child: Text('Sign In', style: headLandBold,))
          ],
      ),
      
      body: SingleChildScrollView(
        child: Container(
          height: height,
          padding: const EdgeInsets.only(left: 8, right: 8,top: 90),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: width,
                  child: Center(
                    child: Text('Create your\n   account',style: headLandBold.copyWith(fontSize: 30),),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: nameController,
                    obscureText: false,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                      hintText: 'Username',
                      hintStyle: headLand.copyWith(color: Colors.white),
                      filled: true,
                      fillColor: biruHitam,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide.none
                      ),
                      isDense: true,
                      isCollapsed: true
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username tidak boleh kosong';
                      }
                      return null; // Return null if validation succeeds
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: emailController, 
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email tidak boleh kosong';
                      } else if (!isValidEmail(value)) {
                        return 'Email tidak valid';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                      hintText: 'Masukkan email',
                      hintStyle: headLand.copyWith(color: Colors.white),
                      filled: true,
                      fillColor: biruHitam,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide.none
                      ),
                      isDense: true,
                      isCollapsed: true
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField( 
                    obscureText: true,
                    controller: passwordController,
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password tidak boleh kosong';
                      } else if (value.length < 6) {
                        return 'Password minimal harus terdiri dari 8 karakter';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                      hintText: 'Masukkan password',
                      hintStyle: headLand.copyWith(color: Colors.white),
                      filled: true,
                      fillColor: biruHitam,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide.none
                      ),
                      isDense: true,
                      isCollapsed: true
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: FilledButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(biruLangit)
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        String name = nameController.text;
                        String email = emailController.text;
                        String password = passwordController.text;
                        
                        _authController.register(name, email, password).then((value) {
                            if(value['success'] == true) {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                              return const LoginPage();
                              }));
                            }
                          });


                      }
                    }, 
                    child: Text('Sign Up', style: headLandBold.copyWith(color: Colors.white),)
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


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_furniture/pages/home.dart';
import 'package:project_furniture/pages/index.dart';
import 'package:project_furniture/pages/register.dart';
import 'package:project_furniture/theme.dart';
import 'package:project_furniture/services/authApi.dart';
import 'package:project_furniture/services/authService.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;


  final AuthController _authController = AuthController();
  final AuthService _authService = AuthService();
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
      body: SingleChildScrollView(
        child: Container(
          height: height,
          padding: const EdgeInsets.only(left: 8, right: 8,top: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: width,
                  child: Center(
                    child: Text('Log in',style: headLandBold.copyWith(fontSize: 30),),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: width,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(75)),
                            color: biruHitam
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 135,
                          height: 135,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(75)),
                            image: DecorationImage(
                              image: AssetImage('asset/images/4.jpg', package: null),
                              fit: BoxFit.cover
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height:80),
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
                const SizedBox(
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
                  height: 30,
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
                        String email = emailController.text;
                        String password = passwordController.text;
                        
                        _authController.login(context,email, password).then((value) async {
                            if(value['success'] == true) {
                                final token = value['token'];
                                await _authService.setToken(token);
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return const MainPage();
                                }));
                                // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainPage()), (route) => false);
                            } else {
                               ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Gagal Login email atau password salah'),
                                ),
                              );
                            }
                             
                          });


                      }
                    }, 
                    child: Text('Log in', style: headLandBold.copyWith(color: Colors.white),)
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 300,
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'Belum punya akun ? ',
                        style: headLand.copyWith(color: biruLangit),
                        children: [
                          TextSpan(
                            text: 'Register',
                            style: headLand.copyWith(fontWeight: FontWeight.bold,color: biruLangit),
                            recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return const RegisterPage();
                              }));
                            },
                          )
                        ]
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
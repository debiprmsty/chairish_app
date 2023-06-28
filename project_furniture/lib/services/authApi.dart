import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_furniture/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:project_furniture/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthController {
  final String baseUrl = 'https://apichairish.000webhostapp.com/api/';


  Future login(BuildContext context,String email, String password) async {
    var url = Uri.parse(baseUrl + 'login');
      var response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );
       var rsp = json.decode(response.body);
      if (response.statusCode == 200) {
        // Permintaan berhasil, lakukan operasi setelah login sukses
       
       
        print(rsp);
        return rsp;
      } else {
        // Permintaan gagal, tampilkan pesan kesalahan atau lakukan penanganan yang sesuai
       
        print(rsp);
        return rsp;
      }
  }

  Future register(String name, String email, String password) async {
    var url = Uri.parse(baseUrl + 'register');
      var response = await http.post(
        url,
        body: {
          'name' : name,
          'email': email,
          'password': password,
        },
      );

      var rsp = json.decode(response.body);
      if (response.statusCode == 200) {
        // Permintaan berhasil, lakukan operasi setelah login sukse
        print(rsp);
        return rsp;
      } else {
        print(rsp);
        return rsp;
      }
  }

}
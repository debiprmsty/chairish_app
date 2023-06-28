import 'dart:convert';
import 'dart:io';
import 'package:project_furniture/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;


class CategoryController {
  final String baseUrl = 'https://apichairish.000webhostapp.com/api/categories';

  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch category');
    }
  }
}
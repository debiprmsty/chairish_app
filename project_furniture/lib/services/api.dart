import 'dart:convert';
import 'dart:io';
import 'package:project_furniture/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;


class ProductController {
  final String baseUrl = 'https://apichairish.000webhostapp.com/api/products';

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)["data"];
      return jsonData.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  Future<Product> getProduct(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);
      return Product.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch product');
    }
  }

  

  Future<void> createProduct(String title, String desc, String price, String imagePath) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
    request.fields['title'] = title;
    request.fields['desc'] = desc;
    request.fields['price'] = price;
    request.files.add(await http.MultipartFile.fromPath('file', imagePath));

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    print(responseData);
  }

  Future<void> updateProduct(
      String id, String title, String desc, String price, String imagePath) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/$id'), // Ganti URL sesuai dengan endpoint update yang sesuai
    );

    final dataId = await getProduct(int.parse(id));

    if (dataId != null) {
      request.fields['title'] = title;
      request.fields['desc'] = desc;
      request.fields['price'] = price;

      if (imagePath.isNotEmpty && imagePath != dataId.image) {
        var imageFile = File(imagePath);
        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();

        var multipartFile = http.MultipartFile(
          'file',
          stream,
          length,
          filename: path.basename(imageFile.path),
        );

        request.files.add(multipartFile);
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print(responseData);
        print('Product updated successfully');
      } else {
        print('Failed to update product. Status code: ${response.statusCode}');
      }
    } else {
      print('Product not found');
    }
  }



  Future<void> deleteProduct(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/delete/$id'));
    var res = json.decode(response.body);
    print(res);
    return res;
  }
}




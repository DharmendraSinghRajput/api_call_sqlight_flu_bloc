import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/prodect_model_response.dart';

class PostRepository {
  Future<List<ProductResponse>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products')).timeout(Duration(seconds: 10));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => ProductResponse.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }


}

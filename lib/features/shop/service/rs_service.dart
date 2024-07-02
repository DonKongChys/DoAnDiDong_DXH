import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RsService extends GetxController {
  static RsService get instance => Get.find();

  // goi api lay san pham recommended
 Future<List<dynamic>> fetchProductIds(String userId) async {

    final response = await http.get(
      Uri.parse('http://192.168.0.102:5000/recommend/$userId'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load payment data${response.statusCode}');
    }
  }
}


import 'dart:convert';
import 'package:dio/dio.dart';
import 'apiConstant.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      // baseUrl: "https://yourdomain.com/api",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
/// Login ------
  Future<Response>login(String email, String password) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        // '/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      return response;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? "Something went wrong";
    }
  }

/// Photos
  Future<List<dynamic>> fetchPhotos() async {
    try {
      // final response = await _dio.get(
      //   "/photos"
      final response = await Dio().get(
          ApiConstants.products
        // 'https://fakestoreapi.com/products',
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
/// Wines
  Future<List<dynamic>> wiNes ()async{
    try{
      final response = await Dio().get (
        ApiConstants.wines
      );
      if(response.statusCode == 200){
        return response.data;
      }else{
        throw Exception("Fail to load data");
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }
/// Users

  Future<List<dynamic>> fetchUsers() async {
    final response = await _dio.get(
        ApiConstants.users
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = response.data;

      return jsonData['users'] as List<dynamic>;
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }


//   Future<List<dynamic>> fetchUsers() async {
//     try {
//       final response = await _dio.get(
//           ApiConstants.users
//       );
//       if (response.statusCode == 200) {
//         return response.data as List<dynamic>;
//       } else {
//         throw Exception('Failed to load users');
//       }
//     } on DioException catch (e) {
//       throw Exception(
//         e.response?.data['message'] ?? e.message ?? 'Something went wrong',
//       );
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
/// Log_Out
  // Future<void>signOut()async{
  //   await SharedPrefService().init();
  //   await SharedPrefService().clearAll();
  //   await SharedPrefService().removeToken();
  // }
}

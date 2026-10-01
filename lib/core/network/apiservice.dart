
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'apiConstant.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(

      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<Response> login(String email, String password) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      debugPrint("Login Response: ${response.data}");

      return response;
    } on DioException catch (e) {
      debugPrint("Login Error: ${e.response?.data}");

      throw e.response?.data?['error'] ??
          e.response?.data?['message'] ??
          "Something went wrong";
    }
  }

  Future<List<dynamic>> fetchPhotos() async {
    try {
      final response = await Dio().get(
          ApiConstants.products
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

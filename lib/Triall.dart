// import 'package:danger_now/Service/apiservice.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class Triall extends GetxController {
//   final ApiService _apiService = ApiService();
//
//   var isLoading = true.obs;
//   var errorMessege = "".obs;
//   var todo = <String, dynamic>{}.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchTodoData();
//   }
//
//   Future<void> fetchTodoData() async {
//     try {
//       isLoading(true);
//       errorMessege("");
//
//       final daata = await _apiService.Rober();
//       todo.assignAll(daata);
//     } catch (e) {
//       errorMessege(e.toString().replaceAll("Exception: ", ""));
//     } finally {
//       isLoading(false);
//     }
//   }
// }
//
//
// /// UI PART
// class FullUI extends StatelessWidget {
//   const FullUI({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final Triall controller = Get.put(Triall());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("This is Good"),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         if (controller.errorMessege.value.isNotEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   controller.errorMessege.value,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () => controller.fetchTodoData(),
//                   child: const Text("Retry"),
//                 )
//               ],
//             ),
//           );
//         }
//
//         final decodedData = controller.todo;
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("User ID: ${decodedData['userId'] ?? 'N/A'}"),
//               Text("ID: ${decodedData['id'] ?? 'N/A'}"),
//               Text("Title: ${decodedData['title'] ?? 'N/A'}"),
//               Text("Completed: ${decodedData['completed'] == true ? "Yes" : "No"}"),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }6


/// Use this on api Screen

// Future<Map<String, dynamic>> Rober() async {
//   try {
//     final response = await _dio.get(
//       ApiConstants.Demo,
//     );
//
//     if (response.statusCode == 200) {
//       final dynamic decodedData = response.data;
//
//       // final dynamic decodedData = jsonDecode(response.data);
//       if (decodedData is Map<String, dynamic>) {
//         return decodedData;
//       }
//       throw Exception("Invalid data format received from server.");
//     } else {
//       throw Exception("Server error code: ${response.statusCode}");
//     }
//   } catch (e) {
//     throw Exception("Connection failed. Please check your network.");
//   }
// }
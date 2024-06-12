import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio = Dio();
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://2waydeal.online/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

//*----------------------------------------------

//   static Future<Response> postData({
//   required String url,
//   String? token,
//   Map<String, dynamic>? query,
//   required Map<String, dynamic> data,
//   File? image,
// }) async {
//   dio.options.headers = {
//     'Content_Type': 'application/json',
//     'Accept': 'application/json',
//   };

//   if (token != null && token.isNotEmpty) {
//     dio.options.headers['Authorization'] = 'Bearer $token';
//   }

//   FormData formData = FormData.fromMap(data);

//   if (image != null) {
//     String fileName = image.path.split('/').last;
//     formData.files.add(
//       MapEntry(
//         'file',
//         await MultipartFile.fromFile(image.path, filename: fileName),
//       ),
//     );
//   }

//   try {
//     final response = await dio.post(
//       url,
//       queryParameters: query,
//       data: formData,
//     );
//     return response;
//   } on DioException catch (e) {
//     if (e.response != null) {
//       // The server responded with an error code
//       if (e.response?.statusCode == 401) {
//         // Handle 401 Unauthorized status code
//         final errorData = e.response?.data;
//         debugPrint('Status code: ${e.response?.statusCode}');
//         debugPrint('Message: ${errorData['message']}');
//       } else if (e.response?.statusCode == 429) {
//         // Handle 429 Unauthorized status code
//         final errorData = e.response?.data;
//         debugPrint('Status code: ${e.response?.statusCode}');
//         debugPrint('Message: ${errorData['message']}');
//       } else if (e.response?.statusCode == 422) {
//         final errorData = e.response?.data;
//         debugPrint('Status code: ${e.response?.statusCode}');
//         debugPrint('Message: ${errorData['message']}');
//       } else {
//         // Handle other status codes
//         debugPrint('Unexpected status code: ${e.response?.statusCode}');
//         debugPrint('Response data: ${e.response?.data}');
//       }
//     } else {
//       // Something happened in setting up or sending the request that triggered an Error
//       debugPrint('Error sending request: ${e.message}');
//     }
//     rethrow; // Re-throw the exception after logging
//   } catch (e) {
//     // Handle any other type of error (e.g., parsing error, etc.)
//     debugPrint('Unexpected error: $e');
//     rethrow; // Re-throw the exception after logging
//   }
// }

  static Future<Response> postData({
    required String url,
    String? token,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    File? image,
  }) async {
    // dio.options.headers = {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    // };

    // if (token != null && token.isNotEmpty) {
    //   dio.options.headers['Authorization'] = 'Bearer $token';
    // }

    // // Initialize formData outside the if condition to ensure it gets initialized properly
    // FormData formData = FormData();

    // // Convert data map to formData fields
    // data.forEach((key, value) {
    //   formData.fields.add(MapEntry(key, value.toString()));
    // });

    // // Add image to formData if present
    // if (image != null) {
    //   String fileName = image.path.split('/').last;
    //   formData.files.add(
    //     MapEntry(
    //       'file',
    //       await MultipartFile.fromFile(image.path, filename: fileName),
    //     ),
    //   );
    // }

    // try {
    //   final response = await dio.post(
    //     url,
    //     queryParameters: query,
    //     data: formData,
    //   );
    //   return response;
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    FormData formData = FormData.fromMap(data);

    if (image != null) {
      String fileName = image.path.split('/').last;
      formData.files.add(
        MapEntry(
          'image',
          await MultipartFile.fromFile(image.path, filename: fileName),
        ),
      );
    }

    try {
      final response = await dio.post(
        url,
        queryParameters: query,
        data: formData,
      );
      return response;
    }on DioException catch (e) {
      if (e.response != null) {
        // The server responded with an error code
        if (e.response?.statusCode == 401) {
          // Handle 401 Unauthorized status code
          final errorData = e.response?.data;
          debugPrint('Status code: ${e.response?.statusCode}');
          debugPrint('Message: ${errorData['message']}');
        } else if (e.response?.statusCode == 429) {
          // Handle 429 Too Many Requests status code
          final errorData = e.response?.data;
          debugPrint('Status code: ${e.response?.statusCode}');
          debugPrint('Message: ${errorData['message']}');
        } else if (e.response?.statusCode == 422) {
          // Handle 422 Unprocessable Entity status code
          final errorData = e.response?.data;
          debugPrint('Status code: ${e.response?.statusCode}');
          debugPrint('Message: ${errorData['message']}');
        } else {
          // Handle other status codes
          debugPrint('Unexpected status code: ${e.response?.statusCode}');
          debugPrint('Response data: ${e.response?.data}');
        }
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint('Error sending request: ${e.message}');
      }
      rethrow; // Re-throw the exception after logging
    } catch (e) {
      // Handle any other type of error (e.g., parsing error, etc.)
      debugPrint('Unexpected error: $e');
      rethrow; // Re-throw the exception after logging
    }
  }

  //*-------------------------------------
  static Future<Response> postCertificates({
    required String url,
    String? token,
    required Map<String, dynamic> data,
    File? healthApprovalCertificate,
    File? commercialRestaurantLicenses,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    FormData formData = FormData.fromMap(data);

    if (healthApprovalCertificate != null) {
      String fileName = healthApprovalCertificate.path.split('/').last;
      formData.files.add(
        MapEntry(
          'health_approval_certificate',
          await MultipartFile.fromFile(healthApprovalCertificate.path,
              filename: fileName),
        ),
      );
    }

    if (commercialRestaurantLicenses != null) {
      String fileName = commercialRestaurantLicenses.path.split('/').last;
      formData.files.add(
        MapEntry(
          'commercial_resturant_license',
          await MultipartFile.fromFile(commercialRestaurantLicenses.path,
              filename: fileName),
        ),
      );
    }

    try {
      final response = await dio.post(
        url,
        data: formData,
        options: Options(
          contentType: 'application/json',
        ),
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        // The server responded with an error code
        if (e.response?.statusCode == 401) {
          // Handle 401 Unauthorized status code
          final errorData = e.response?.data;
          debugPrint('Status code: ${e.response?.statusCode}');
          debugPrint('Message: ${errorData['message']}');
        } else if (e.response?.statusCode == 429) {
          // Handle 429 Too Many Requests status code
          final errorData = e.response?.data;
          debugPrint('Status code: ${e.response?.statusCode}');
          debugPrint('Message: ${errorData['message']}');
        } else if (e.response?.statusCode == 422) {
          // Handle 422 Unprocessable Entity status code
          final errorData = e.response?.data;
          debugPrint('Status code: ${e.response?.statusCode}');
          debugPrint('Message: ${errorData['message']}');
        } else {
          // Handle other status codes
          debugPrint('Unexpected status code: ${e.response?.statusCode}');
          debugPrint('Response data: ${e.response?.data}');
        }
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        debugPrint('Error sending request: ${e.message}');
      }
      rethrow; // Re-throw the exception after logging
    } catch (e) {
      // Handle any other type of error (e.g., parsing error, etc.)
      debugPrint('Unexpected error: $e');
      rethrow; // Re-throw the exception after logging
    }
  }

  static Future<Response> getData({
    required String url,
    String? token,
    Map<String, dynamic>? query,
  }) {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    return dio.get(
      url,
      queryParameters: query,
    );
  }

  // static Future<Response> postData({
  //   required String url,
  //   String? token,
  //   Map<String, dynamic>? qurey,
  //   required Map<String, dynamic> data,
  // }) async {
  //   dio.options.headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': token,
  //   };

  //   if (token != null && token.isNotEmpty) {
  //     dio.options.headers['Authorization'] = 'Bearer $token';
  //   }

  //   return await dio.post(
  //     url,
  //     queryParameters: qurey,
  //     data: data,
  //   );
  // }

  static Future<Response> updateData({
    required String url,
    String lang = 'en',
    String? token,
    Map<String, dynamic>? qurey,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };

    return await dio.put(
      url,
      queryParameters: qurey,
      data: data,
    );
  }
}

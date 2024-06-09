import 'dart:io';

import 'package:dio/dio.dart';

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

//   var headers = {
//   'Accept': 'application/json',
//   'Content-Type': 'application/json',
//   'Authorization': ''
// };
// var data = json.encode({
//   "email": "amr@2waycustomer.com",
//   "password": "123456"
// });
// var dio = Dio();
// var response = await dio.request(
//   'http://2waydeal.online/api/auth/login/customer',
//   options: Options(
//     method: 'POST',
//     headers: headers,
//   ),
//   data: data,
// );
//*----------------------------------------------

  static Future<Response> postData({
    required String url,
    String? token,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    List<File?>? images,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    FormData formData = FormData.fromMap(data);

    if (images != null && images.isNotEmpty) {
      for (File? image in images) {
        if (image != null) {
          String fileName = image.path.split('/').last;
          formData.files.add(
            MapEntry(
              'files',
              await MultipartFile.fromFile(image.path, filename: fileName),
            ),
          );
        }
      }
    }

    try {
      final response = await dio.post(
        url,
        queryParameters: query,
        data: images != null && images.isNotEmpty ? formData : data,
        options: Options(
          contentType: images != null && images.isNotEmpty
              ? 'multipart/form-data'
              : 'application/json',
        ),
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        // The server responded with an error code
        if (e.response?.statusCode == 401) {
          // Handle 401 Unauthorized status code
          final errorData = e.response?.data;
          print('Status code: ${e.response?.statusCode}');
          print('Message: ${errorData['message']}');
        } else if (e.response?.statusCode == 429) {
          // Handle 429 Unauthorized status code
          final errorData = e.response?.data;
          print('Status code: ${e.response?.statusCode}');
          print('Message: ${errorData['message']}');
        } else if (e.response?.statusCode == 422) {
          final errorData = e.response?.data;
          print('Status code: ${e.response?.statusCode}');
          print('Message: ${errorData['message']}');
        } else {
          // Handle other status codes
          print('Unexpected status code: ${e.response?.statusCode}');
          print('Response data: ${e.response?.data}');
        }
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print('Error sending request: ${e.message}');
      }
      rethrow; // Re-throw the exception after logging
    } catch (e) {
      // Handle any other type of error (e.g., parsing error, etc.)
      print('Unexpected error: $e');
      rethrow; // Re-throw the exception after logging
    }
  }
  //*-------------------------------------

  // static Future<Response> postData({
  //   required String url,
  //   String? token,
  //   Map<String, dynamic>? query,
  //   required Map<String, dynamic> data,
  //   List<File>? images,
  // }) async {
  //   dio.options.headers = {
  //     'Content-Type': 'multipart/form-data',
  //     'Accept': 'application/json',
  //   };

  //   if (token != null && token.isNotEmpty) {
  //     dio.options.headers['Authorization'] = 'Bearer $token';
  //   }

  //   FormData formData = FormData.fromMap(data);

  //   if (images != null && images.isNotEmpty) {
  //     for (File image in images) {
  //       String fileName = image.path.split('/').last;
  //       formData.files.add(
  //         MapEntry(
  //           'files',
  //           await MultipartFile.fromFile(image.path, filename: fileName),
  //         ),
  //       );
  //     }
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
  //         print('Status code: ${e.response?.statusCode}');
  //         print('Message: ${errorData['message']}');
  //       } else {
  //         // Handle other status codes
  //         print('Unexpected status code: ${e.response?.statusCode}');
  //         print('Response data: ${e.response?.data}');
  //       }
  //     } else {
  //       // Something happened in setting up or sending the request that triggered an Error
  //       print('Error sending request: ${e.message}');
  //     }
  //   } catch (e) {
  //     // Handle any other type of error (e.g., parsing error, etc.)
  //     print('Unexpected error: $e');
  //   }
  // }

  // static Future<Response> postData({
  //   required String url,
  //   String? token,
  //   Map<String, dynamic>? query,
  //   required Map<String, dynamic> data,
  //   File? image,
  // }) async {
  //   dio.options.headers = {
  //     'Content-Type': 'application/json',
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
  //         'image',
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
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
// static Future<Response> postData({
//     required String url,
//     String? token,
//     Map<String, dynamic>? query,
//     required Map<String, dynamic> data,
//   }) async {
//     // Set default headers for the request
//     dio.options.headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     };

//     // If token is provided, include it in the headers with Bearer scheme
//     if (token != null && token.isNotEmpty) {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//     }

//     try {
//       // Sending the POST request
//       final response = await dio.post(
//         url,
//         queryParameters: query,
//         data: data,
//       );

//       // Returning the response
//       return response;
//     } on DioException catch (e) {
//       // Handling the error and returning the response for further handling
//       return e.response ?? Response(
//         requestOptions: RequestOptions(path: url),
//         statusCode: 500,
//         statusMessage: 'An error occurred',
//       );
//     }
//   }

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

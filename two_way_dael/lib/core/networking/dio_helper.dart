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

static Future<Response> postData({
    required String url,
    String? token,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    // Set default headers for the request
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // If token is provided, include it in the headers with Bearer scheme
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    try {
      // Sending the POST request
      final response = await dio.post(
        url,
        queryParameters: query,
        data: data,
      );

      // Returning the response
      return response;
    } on DioException catch (e) {
      // Handling the error and returning the response for further handling
      return e.response ?? Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 500,
        statusMessage: 'An error occurred',
      );
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
      'Authorization': token,
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

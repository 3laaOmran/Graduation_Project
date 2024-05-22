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



  static Future<Response> getData({
    required String url,
    String lang = 'en',
    String? token,
    Map<String, dynamic>? query,
  }) {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    String? token,
    Map<String, dynamic>? qurey,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token ?? '',
    };

    return await dio.post(
      url,
      queryParameters: qurey,
      data: data,
    );
  }

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

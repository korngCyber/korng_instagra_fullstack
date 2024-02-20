import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instagram_app/app/model/comment_res_model.dart';

import '../model/login_model.dart';
import '../model/post_res_model.dart';

// String baseUrl = 'http://192.168.100.6:8000/api/'; // my wifi ip server
String baseUrl = 'http://10.0.2.2:8000/api/'; // loop back ip

class ApiService {
  final box = GetStorage();
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    ),
  );

  Future<dynamic> registerUser({
    required String email,
    required String password,
    required String name,
    File? profileImage,
  }) async {
    try {
      var _formdata = FormData.fromMap(
        {
          "email": email,
          "password": password,
          "password_confirmation": password,
          "name": name,
          "profile_image": profileImage != null
              ? await MultipartFile.fromFile(
                  profileImage.path,
                )
              : null,
        },
      );
      final response = await dio.post(
        "/register",
        data: _formdata,
        options: Options(
          headers: {"Accept": "application/json"},
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
        // throw Exception("falied register");
      }
    } catch (e) {
      print("Error during registration: $e");
      rethrow;
    }
  }

  Future<LoginResModel> login({
    required String email,
    required String password,
  }) async {
    try {
      var _formdata = FormData.fromMap(
        {
          "email": email,
          "password": password,
        },
      );

      final response = await dio.post(
        "/login",
        data: _formdata,
        options: Options(
          headers: {
            "Accept": "application/json",
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        return LoginResModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      throw Exception("Failed to login : $e");
    }
  }

  Future<bool> createPost({
    required String caption,
    required File? photo,
  }) async {
    try {
      final token = box.read('token');
      final _formdata = FormData.fromMap({
        "caption": caption,
        "profile_image":
            photo != null ? await MultipartFile.fromFile(photo.path) : null,
      });
      final response = await dio.post(
        "/post",
        data: _formdata,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("something worng");
      }
    } catch (e) {
      throw Exception("Failed to login : $e");
    }
  }

  Future<PostResModel> getAllPost() async {
    try {
      final token = box.read('token');
      final response = await dio.get(
        "/post",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        return PostResModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("something worng");
      }
    } catch (e) {
      throw Exception("Failed error : $e");
    }
  }

  Future<bool> likeDislike({required int postId}) async {
    try {
      final token = box.read("token");
      if (token == null || token.isEmpty) {
        throw Exception("Authorization token is missing or invalid");
      }
      final response = await dio.post(
        "/tuggle_like/$postId",
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
          headers: {
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.contentTypeHeader: "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        throw Exception("Unauthorized: Check your authorization token");
      } else if (response.statusCode == 422) {
        throw Exception("Validation error: ${response.data}");
      } else {
        throw Exception("Unexpected error: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return false; // Return an appropriate value based on your use case
    }
  }

  // Future<CommentResModel> getAllComment({required int postId}) async {
  //   try {
  //     final token = box.read('token');
  //     final response = await dio.get(
  //       "/check-comment/$postId",
  //       options: Options(
  //         headers: {
  //           "Accept": "application/json",
  //           "Authorization": "Bearer $token"
  //         },
  //         followRedirects: false,
  //         validateStatus: (status) {
  //           return status! < 500;
  //         },
  //       ),
  //     );
  //     if (response.statusCode == 200) {
  //       print("Response data: ${response.data}");
  //       return CommentResModel.fromJson(response.data);
  //     } else if (response.statusCode == 401) {
  //       throw Exception("Unauthorized");
  //     } else {
  //       throw Exception("something wrong");
  //     }
  //   } catch (e) {
  //     throw Exception("Failed error : $e");
  //   }
  // }
  Future<CommentResModel> getComments({required int postId}) async {
    try {
      final token = box.read('token');
      final response = await dio.get(
        "/post/$postId/comments", // Adjust the API endpoint as needed
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      if (response.statusCode == 200) {
        return CommentResModel.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      throw Exception("Failed error: $e");
    }
  }

  Future<bool> postComment({
    required int postId,
    required String comment,
  }) async {
    try {
      final token = box.read("token");
      if (token == null || token.isEmpty) {
        throw Exception("Authorization token is missing or invalid");
      }
      final response = await Dio().post(
        "/post_comment/$postId",
        data: {"comment": comment},
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
          headers: {
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.contentTypeHeader: "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        throw Exception("Unauthorized: Check your authorization token");
      } else if (response.statusCode == 422) {
        throw Exception("Validation error: ${response.data}");
      } else {
        throw Exception("Unexpected error: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return false;
    }
  }
}

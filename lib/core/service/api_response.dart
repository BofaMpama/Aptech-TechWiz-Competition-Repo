import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;



class ApiResponse {
  final String message;
  final String? link;
  final String error;
  final bool isSuccessful;
  final List<dynamic>? data;
  final dynamic mydata;
  final dynamic event;
  final String? url;

  ApiResponse({
    required this.message,
    required this.isSuccessful,
    required this.error,
    required this.mydata,
    required this.event,
    this.data,
    this.link,
    this.url,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, bool isSuccess) {
    return ApiResponse(
      message: json['message'] ?? '',
      link: json['link'] ?? '',
      error: json['error'] ?? '',
      isSuccessful: json['success'] ?? isSuccess,
      data:
      (json['docs'] != null &&
          json["docs"] is List &&
          json['docs'].isNotEmpty)
          ? json['docs']
          : null,
      mydata: json['data'] ?? '',
      event: json['event'] ?? '',
      url: json['url'],
    );
  }
}

Future<ApiResponse> handleResponse(http.Response response) async {
  interceptResponse(response);
  try {
    var jsonData = jsonDecode(response.body);
    bool isWrapped =
        jsonData is Map<String, dynamic> &&
            (jsonData.containsKey('success') ||
                jsonData.containsKey('message') ||
                jsonData.containsKey('data') ||
                jsonData.containsKey('docs') ||
                jsonData.containsKey('link') ||
                jsonData.containsKey('url'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (isWrapped) {
        debugPrint("is wrapped true : $isWrapped");
        return ApiResponse.fromJson(jsonData, true);
      } else {
        debugPrint("is wrapped false : $isWrapped");
        return ApiResponse(
          message: 'OK',
          isSuccessful: true,
          error: '',
          mydata: jsonData,
          event: jsonData,
          data: jsonData is List ? jsonData : null,
          link: null,
          url: null,
        );
      }
    } else {
      String error = jsonData['error'] ?? '';
      if (error.contains('Invalid or expired session token')) {

      }
      debugPrint("reach here error ......... $jsonData");
      return ApiResponse.fromJson(jsonData, false);
    }
  } catch (e) {
    debugPrint("Failed: ${e.toString()} code is ${response.statusCode}"); // 403 and 401
    throw Exception('Exception: ${e.toString()}');
  }
}

void interceptResponse(http.Response response) {
  if (kDebugMode) {
    developer.log('Response - ${response.statusCode}');
    developer.log('URI: ${response.request?.url.toString()}');
    developer.log('Response body: ${response.body}');
  }
}

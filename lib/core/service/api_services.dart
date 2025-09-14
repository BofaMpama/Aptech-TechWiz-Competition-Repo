import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../data/datasource/local_database.dart';
import '../constants/constants.dart';
import 'api_response.dart';


class Request {
  Future<ApiResponse> post({
    required String url,
    bool formData = false,
    required Map<String, dynamic> body,
  }) async {
    try {
      debugPrint("url is : $url");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${getToken()}',
        'x-session-token': getSessionToken(),
      };

      final response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: timeOut));
      return await handleResponse(response);
    } on http.ClientException catch (e) {
      throw Exception('HTTP Client Exception: $e');
    } on TimeoutException catch (e) {
      throw Exception('Request timeout: $e');
    } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains('Exception: ')) {
        errorMessage = errorMessage.replaceFirst('Exception: ', '');
      }
      throw Exception(errorMessage);
    }
  }

  // Future<http.Response> customRequest({
  //   String? banner,
  //   String? watermark,
  //   String? name,
  //   String? date,
  //   String? time,
  //   String? description,
  //   String? broadcastSoftware,
  //   bool? haveBroadcastRoom,
  //   String? scheduledTestDate,
  //
  // }) async {
  //   debugPrint(
  //     "prices list is : ${prices?.first.amount} and currency is : ${prices?.first.currency}",
  //   );
  //   String sessionToken = getSessionToken();
  //   print('session Token : $sessionToken');
  //   try {
  //     if (banner == null ||
  //         banner.isEmpty) {
  //       throw Exception("File path is empty.");
  //     }
  //
  //     if (!isValidFileType(banner)) {
  //       throw Exception("Invalid file type. Allowed: JPG, PNG, MP4, PDF.");
  //     }
  //
  //   //  final mimeType = lookupMimeType(banner) ?? "image/jpeg";
  //
  //     final form = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(Endpoints.createEvent),
  //     );
  //     form.headers['Authorization'] = 'Bearer ${getToken()}';
  //     form.headers['x-session-token'] = sessionToken;
  //
  //     // Add banner file
  //     form.files.add(
  //       await http.MultipartFile.fromPath(
  //         'banner',
  //         banner,
  //         contentType: MediaType.parse(mimeType),
  //       ),
  //     );
  //
  //     // Add watermark file
  //     // if(watermark !=null)
  //     // form.files.add(
  //     //   await http.MultipartFile.fromPath(
  //     //     'watermark',
  //     //     watermark,
  //     //     contentType: MediaType.parse(mimeType),
  //     //   ),
  //     // );
  //
  //     // Add simple fields
  //     form.fields['name'] = name ?? '';
  //     form.fields['time'] = time ?? '';
  //     form.fields['date'] = date ?? '';
  //     form.fields['description'] = description ?? '';
  //     form.fields['broadcastSoftware'] = broadcastSoftware ?? '';
  //     if (haveBroadcastRoom != null) {
  //       form.fields['haveBroadcastRoom'] = haveBroadcastRoom.toString();
  //     }
  //     form.fields['scheduledTestDate'] = scheduledTestDate ?? '';
  //
  //     // Validate and add prices
  //     if (prices != null && prices.isNotEmpty) {
  //       for (int i = 0; i < prices.length; i++) {
  //         final item = prices[i];
  //         if (item.currency.isEmpty || int.tryParse(item.amount)! <= 0) {
  //           throw Exception("Invalid price data at index $i");
  //         }
  //
  //         form.fields['prices[$i][currency]'] = item.currency;
  //         form.fields['prices[$i][amount]'] = item.amount.toString();
  //       }
  //     } else {
  //       throw Exception("At least one price must be provided.");
  //     }
  //
  //     final streamedResponse = await form.send();
  //     final response = await http.Response.fromStream(streamedResponse);
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return response;
  //     } else {
  //       print("error hre is : ${response.body}");
  //       // String error = jsonDecode(response.body)['error'];
  //       // if(error.contains('Invalid or expired session token')){
  //       //
  //       // }
  //       throw Exception('${jsonDecode(response.body)['message']}');
  //     }
  //   } catch (e) {
  //     debugPrint('Error: $e');
  //     rethrow;
  //   }
  // }

  Future<ApiResponse> put({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      debugPrint("url is : $url");

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${getToken()}',
        'x-session-token': getSessionToken(),
      };
      final response = await http
          .put(Uri.parse(url), headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: timeOut));
      return await handleResponse(response);
    } on http.ClientException catch (e) {
      throw Exception('HTTP Client Exception: $e');
    } on TimeoutException catch (e) {
      throw Exception('Request timeout: $e');
    } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains('Exception: ')) {
        errorMessage = errorMessage.replaceAll('Exception: ', '');
      }
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> patch({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      debugPrint("url is : $url");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${getToken()}',
        'x-session-token': getSessionToken(),
      };
      final response = await http
          .patch(Uri.parse(url), headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: timeOut));
      return await handleResponse(response);
    } on http.ClientException catch (e) {
      throw Exception('HTTP Client Exception: $e');
    } on TimeoutException catch (e) {
      throw Exception('Request timeout: $e');
    } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains('Exception: ')) {
        errorMessage = errorMessage.replaceFirst('Exception: ', '');
      }
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> delete({required String url}) async {
    try {
      debugPrint("url is : $url");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${getToken()}',
        'x-session-token': getSessionToken(),
      };

      final response = await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: timeOut));

      return await handleResponse(response);
    } on http.ClientException catch (e) {
      throw Exception('HTTP Client Exception: $e');
    } on TimeoutException catch (e) {
      throw Exception('Request timeout: $e');
    } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains('Exception: ')) {
        errorMessage = errorMessage.replaceFirst('Exception: ', '');
      }
      throw Exception(errorMessage);
    }
  }

  Future<ApiResponse> getData({required String url}) async {
    try {
      debugPrint("get request url =>  : $url");
      final sessionToken = getSessionToken();
      debugPrint("session is : $sessionToken");
      debugPrint("country code : ${getCountryCode()}");

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${getToken()}',
        if (sessionToken.isNotEmpty) 'x-session-token': sessionToken,
      };

      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: timeOut));
      return await handleResponse(response);
    } on http.ClientException catch (e) {
      throw Exception('HTTP Client Exception: $e');
    } on TimeoutException catch (e) {
      throw Exception('Request timeout: $e');
    } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains('Exception: ')) {
        errorMessage = errorMessage.replaceFirst('Exception: ', '');
      }
      throw Exception(errorMessage);
    }
  }

  bool isValidFileType(String filePath) {
    final allowedExtensions = ['jpg', 'jpeg', 'png', 'mp4', 'pdf'];
    final extension = filePath.split('.').last.toLowerCase();
    return allowedExtensions.contains(extension);
  }
}

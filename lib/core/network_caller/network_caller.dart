import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

part 'network_response.dart';

class NetworkCaller {

  final Logger _logger = Logger();

  final Map<String, String> Function() headers; // to get fresh token instead of snapshot of token
  final VoidCallback onUnAuthorized;

  NetworkCaller({required this.headers, required this.onUnAuthorized});

  Future<NetworkResponse> getRequest(String url) async {

    try {

      final Uri uri = Uri.parse(url);

      _logRequest(url, null);

      final http.Response response = await http.get(
          uri,
          headers: headers()
      );

      _logResponse(response);

      if (response.statusCode == 200 || response.statusCode == 201){

        final decodedData = jsonDecode(response.body);

        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          body: decodedData
        );

      } else if (response.statusCode == 401){

        onUnAuthorized(); // unAuthorized user

        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          body: null,
          errorMessage: 'Unauthorized'
        );

      } else {

        final dynamic decodedData = jsonDecode(response.body);

        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          body: null,
          errorMessage: decodedData['msg']
        );

      }

    } on Exception catch(error){

      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        body: null,
        errorMessage: error.toString()
      );

    }

  }

  Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
    bool fromLogin = false}) async {

    try {

      final Uri uri = Uri.parse(url);

      _logRequest(url, body);

      final http.Response response = await http.post(
          uri,
          headers: headers(),
          body: jsonEncode(body)
      );

      _logResponse(response);

      if (response.statusCode == 200 || response.statusCode == 201){

        final decodedData = jsonDecode(response.body);

        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            body: decodedData
        );

      } else if (response.statusCode == 401){

        if(!fromLogin) onUnAuthorized(); // unAuthorized user

        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            body: null,
            errorMessage: 'Unauthorized'
        );

      } else {

        final dynamic decodedData = jsonDecode(response.body);

        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            body: null,
            errorMessage: decodedData['msg']
        );

      }

    } on Exception catch(error){

      return NetworkResponse(
          statusCode: -1,
          isSuccess: false,
          body: null,
          errorMessage: error.toString()
      );

    }

  }

  Future<NetworkResponse> putRequest(String url, Map<String, dynamic>? body) async {

    try {

      final Uri uri = Uri.parse(url);

      _logRequest(url, body);

      final http.Response response = await http.put(
          uri,
          headers: headers(),
          body: jsonEncode(body)
      );

      _logResponse(response);

      if (response.statusCode == 200 || response.statusCode == 201){

        final decodedData = jsonDecode(response.body);

        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            body: decodedData
        );

      } else if (response.statusCode == 401){

        onUnAuthorized(); // unAuthorized user

        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            body: null,
            errorMessage: 'Unauthorized'
        );

      } else {

        final dynamic decodedData = jsonDecode(response.body);

        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            body: null,
            errorMessage: decodedData['msg']
        );

      }

    } on Exception catch(error){

      return NetworkResponse(
          statusCode: -1,
          isSuccess: false,
          body: null,
          errorMessage: error.toString()
      );

    }

  }

  Future<NetworkResponse> patchRequest(String url, Map<String, dynamic>? body) async {

    try {

      final Uri uri = Uri.parse(url);

      _logRequest(url, body);

      final http.Response response = await http.patch(
          uri,
          headers: headers(),
          body: jsonEncode(body)
      );

      _logResponse(response);

      if (response.statusCode == 200 || response.statusCode == 201){

        final decodedData = jsonDecode(response.body);

        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            body: decodedData
        );

      } else if (response.statusCode == 401){

        onUnAuthorized(); // unAuthorized user

        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            body: null,
            errorMessage: 'Unauthorized'
        );

      } else {

        final dynamic decodedData = jsonDecode(response.body);

        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            body: null,
            errorMessage: decodedData['message']
        );

      }

    } on Exception catch(error){

      return NetworkResponse(
          statusCode: -1,
          isSuccess: false,
          body: null,
          errorMessage: error.toString()
      );

    }

  }

  Future<NetworkResponse> deleteRequest(String url, Map<String, dynamic>? body) async {

    try {

      final Uri uri = Uri.parse(url);

      _logRequest(url, body);


      final http.Response response = await http.delete(
          uri,
          headers: headers(),
          body: body != null ? jsonEncode(body) : null
      );

      _logResponse(response);

      if (response.statusCode == 200 || response.statusCode == 201){

        final decodedData = jsonDecode(response.body);

        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            body: decodedData
        );

      } else if (response.statusCode == 401){

        onUnAuthorized(); // unAuthorized user

        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            body: null,
            errorMessage: 'Unauthorized'
        );

      } else {

        final dynamic decodedData = jsonDecode(response.body);

        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            body: null,
            errorMessage: decodedData['msg']
        );

      }

    } on Exception catch(error){

      return NetworkResponse(
          statusCode: -1,
          isSuccess: false,
          body: null,
          errorMessage: error.toString()
      );

    }

  }

  void _logRequest (String url, Map<String, dynamic>? body){

    _logger.i('''
      URL => $url
      BODY => $body
    ''');

  }

  void _logResponse (http.Response response){

    _logger.i('''
      URL => ${response.request?.url}
      STATUS CODE => ${response.statusCode}
      BODY => ${response.body}
    ''');

  }

}
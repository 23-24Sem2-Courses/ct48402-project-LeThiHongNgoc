import 'dart:convert';
import 'dart:io';
<<<<<<< HEAD
=======

>>>>>>> b4afc48625cad5c874de557f0ac20f24ecc05c50
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/auth_token.dart';
import 'package:http/http.dart' as http;

enum HttpMethod { get, post, put, patch, delete }

abstract class FirebaseService {
  String? _token;
  String? _userId;
  String? databaseUrl;

  FirebaseService([AuthToken? authToken])
      : _token = authToken?.token,
        _userId = authToken?.userId {
<<<<<<< HEAD
    databaseUrl = dotenv.env['FIREBASE_RTDB_URL'];
=======
    databaseUrl = dotenv.env['FIREBASE_URL'];
>>>>>>> b4afc48625cad5c874de557f0ac20f24ecc05c50
  }

  set authToken(AuthToken? authToken) {
    _token = authToken?.token;
    _userId = authToken?.userId;
  }

  @protected
  String? get token => _token;

  @protected
  String? get userId => _userId;

  Future<dynamic> httpFetch(
    String uri, {
    HttpMethod method = HttpMethod.get,
    Map<String, String>? headers,
    Object? body,
  }) async {
    Uri requestUri = Uri.parse(uri);
    http.Response response = switch (method) {
      HttpMethod.get => await http.get(
          requestUri,
          headers: headers,
        ),
      HttpMethod.post => await http.post(
          requestUri,
          headers: headers,
          body: body,
        ),
      HttpMethod.put => await http.put(
          requestUri,
          headers: headers,
          body: body,
        ),
      HttpMethod.patch => await http.patch(
          requestUri,
          headers: headers,
          body: body,
        ),
      HttpMethod.delete => await http.delete(
          requestUri,
          headers: headers,
        )
    };

    final json = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw HttpException(json['error']);
    }
    return json;
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> b4afc48625cad5c874de557f0ac20f24ecc05c50

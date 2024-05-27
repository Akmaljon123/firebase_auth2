import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth2/models/user_model.dart';
import 'package:firebase_auth2/services/util_service.dart';
import 'package:flutter/cupertino.dart';

class HttpService{
  static Future<String?> get()async{
    HttpClient httpClient = HttpClient();

    try{
      Uri url = Uri.https("65cbb766efec34d9ed87fe33.mockapi.io", "/users");
      HttpClientRequest request = await httpClient.getUrl(url);
      request.headers.set("Content-Type", "application/json");

      HttpClientResponse response = await request.close();

      if(response.statusCode<=201){
        String data = await response.transform(utf8.decoder).join();

        return data;
      }else{
        return null;
      }
    }catch (e){
      return null;
    }finally{
      httpClient.close();
    }
  }

  static Future<void> post(BuildContext context, UserModel user)async{
    HttpClient httpClient = HttpClient();

    Uri url = Uri.https("65cbb766efec34d9ed87fe33.mockapi.io", "/users");
    HttpClientRequest request = await httpClient.postUrl(url);
    request.headers.set("Content-Type", "application/json");
    request.add(utf8.encode(jsonEncode(user)));
    HttpClientResponse response = await request.close();

    if(context.mounted){
      if(response.statusCode >= 205){
        Utils.fireSnackBar("Something went wrong", context);
      }
    }
  }
}
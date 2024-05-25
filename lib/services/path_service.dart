import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth2/models/user_model.dart';
import 'package:firebase_auth2/my_app/setup.dart';
import 'package:path_provider/path_provider.dart';

class PathService{
  static Future<void> saveData(UserModel user)async{
    final directory = await getApplicationDocumentsDirectory();
    userList.add(user);

    File file = File("${directory.path}.users");

    await file.writeAsString(jsonEncode(userList));
  }

  static Future<void> getData()async{
    final directory = await getApplicationDocumentsDirectory();

    File file = File("${directory.path}.users");
    String data = await file.readAsString();

    userList = userModelFromJson(data);
  }
}
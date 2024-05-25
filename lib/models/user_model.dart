import 'dart:convert';

List<UserModel> userModelFromJson(String str)=>List<UserModel>.from(jsonDecode(str).map((e)=>UserModel.fromJson(e)));

String userModelToJson(List<UserModel> users)=> jsonEncode(List<dynamic>.from(users.map((e)=>e.toJson())));




class UserModel{
  late String name;
  late String email;
  late String password;

  UserModel({required this.password, required this.email, required this.name});

  UserModel.fromJson(Map<String, dynamic> json){
    name = json["name"];
    email = json["email"];
    password = json["password"];
  }

  Map<String, dynamic> toJson(){
    return {
      "name": name,
      "email": email,
      "password": password
    };
  }
}
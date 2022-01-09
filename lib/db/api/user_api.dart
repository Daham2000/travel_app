import 'dart:convert';
import 'package:travel_app/db/constants/url.dart';
import 'package:travel_app/db/model/user.dart';
import 'package:http/http.dart' as http;

class UserAPI{

  Future<User> loginUser(String token)async{
    final String pathParameters = "?loginTime=2021-12-23";
    User userModel;
    final String path = "${UrlConstants.LOGIN_USER}$pathParameters";
    var url = Uri.parse(path);
    try{
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final jsonString = response.body;
        print(jsonString);
        final jsonMap = json.decode(jsonString);
        userModel = User.fromJson(jsonMap);
        return userModel;
      }
    }catch(e){
      print(e.toString());
    }
    return userModel;
  }
}
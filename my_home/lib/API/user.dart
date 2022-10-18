import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_home/screens/home.dart';
import 'package:my_home/screens/intro.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  static var token = '';
  static var name = 'User';
  static var mail = 'User';

  static saveData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print('savedata');
    pref.setString('token', token);
  }

  static getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }

  static login(var email, var password) async {
    try {
      var headers = {'Accept': 'application/json'};
      var data = {'email': email, 'password': password};

      var response = await http.post(Uri.parse('http://192.168.100.202:8000/api/login'), headers: headers, body: data);

      var result = json.decode(response.body);
      if (result['message'] == 'success') {
        token = result['token'];

        saveData();
      }
      return result;
    } catch (e) {
      return {'message': 'no internet'};
    }
  }

  static register(var name, var email, var password) async {
    try {
      var headers = {'Accept': 'application/json'};
      var data = {'name': name, 'email': email, 'password': password};
      var response =
          await http.post(Uri.parse('http://192.168.100.202:8000/api/register'), headers: headers, body: data);

      var result = json.decode(response.body);
      if (result['token'] != null) {
        token = result['token'];

        saveData();
      }

      return result;
    } catch (e) {
      return {'message': 'no internet'};
    }
  }

  static get() async {
    try {
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};

      var response = await http.get(Uri.parse('http://192.168.100.202:8000/api/user'), headers: headers);
      var result = json.decode(response.body);
      // print(result);
      mail = result['email'];
      name = result['name'];
      print('tes');
      return result;
    } catch (e) {
      return {'message': 'no internet'};
    }
  }

  static checkPassword(var password) async {
    try {
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      var data = {'password': password};

      var response =
          await http.post(Uri.parse('http://192.168.100.202:8000/api/password'), headers: headers, body: data);

      var result = json.decode(response.body);
      print(result);
      if (result['message'] == 'match') {
        return true;
      } else {
        return false;
      }
    } catch (e) {}
  }

  static update(var name, var password, var email) async {
    try {
      var body = Map<String, String>();
      if (name != '') {
        body['name'] = name;
      }
      if (email != '') {
        body['email'] = email;
      }
      if (password != '') {
        body['password'] = password;
      }
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      var response = await http.put(Uri.parse('http://192.168.100.202:8000/api/user'), headers: headers, body: body);
      var result = json.decode(response.body);
      print(result);
      return result;
    } catch (e) {}
  }

  static logout() async {
    try {
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      var response = await http.get(Uri.parse('http://192.168.100.202:8000/api/logout'), headers: headers);
      token = '';
      saveData();
      return json.decode(response.body);
    } catch (e) {
      return {'message': 'no internet'};
    }
  }

  Widget handleAuth() {
    return FutureBuilder<dynamic>(
      future: getToken(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          print(data);
          if (data == '') {
            return Intro();
          } else {
            token = data;
            return HomePage();
          }
        }
        return Intro();
      },
    );
  }
}

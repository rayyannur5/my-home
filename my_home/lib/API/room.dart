import 'dart:convert';

import 'package:my_home/API/user.dart';
import 'package:http/http.dart' as http;

class Room {
  static int countRoom = 0;
  static create(String name, String desc, int tipe) async {
    try {
      String token = User.token;
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      var body = {'name': name, 'desc': desc, 'tipe': tipe.toString()};
      var response = await http.post(Uri.parse('http://192.168.100.202:8000/api/rooms'), headers: headers, body: body);
      return json.decode(response.body);
    } catch (e) {
      return {'message': 'no internet'};
    }
  }

  static get() async {
    try {
      String token = User.token;
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      var response = await http.get(Uri.parse('http://192.168.100.202:8000/api/rooms'), headers: headers);
      var result = json.decode(response.body);
      if (result[0] != null) {
        countRoom = result.length;
      } else {
        countRoom = 0;
      }
      return result;
    } catch (e) {
      return {'message': 'no internet'};
    }
  }

  static getById(int id) async {
    try {
      String token = User.token;
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      var response = await http.get(Uri.parse('http://192.168.100.202:8000/api/rooms/$id'), headers: headers);
      return json.decode(response.body);
    } catch (e) {
      return {'message': 'no internet'};
    }
  }

  static update(String name, String desc, int tipe, int id) async {
    try {
      String token = User.token;
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      var body = {'name': name, 'desc': desc, 'tipe': tipe.toString()};
      var response =
          await http.put(Uri.parse('http://192.168.100.202:8000/api/rooms/$id'), headers: headers, body: body);
      print(response.body);
      return json.decode(response.body);
    } catch (e) {
      return {'message': 'no internet'};
    }
  }

  static delete(int id) async {
    try {
      String token = User.token;
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      var response = await http.delete(Uri.parse('http://192.168.100.202:8000/api/rooms/$id'), headers: headers);
      return json.decode(response.body);
    } catch (e) {
      return {'message': 'no internet'};
    }
  }
}

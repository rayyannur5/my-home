import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_home/API/user.dart';

class Device {
  static int countDevice = 0;

  static create(int room_id, String name, int tipe) async {
    try {
      tipe = tipe * 2;
      String token = User.token;
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      var body = {'room_id': room_id.toString(), 'name': name, 'tipe': tipe.toString(), 'state': '0'};
      var response =
          await http.post(Uri.parse('http://192.168.100.202:8000/api/devices'), headers: headers, body: body);
      return json.decode(response.body);
    } catch (e) {
      return {'message': 'no internet'};
    }
  }

  static get(var room_id) async {
    try {
      String token = User.token;
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      var response =
          await http.get(Uri.parse('http://192.168.100.202:8000/api/rooms/$room_id/devices'), headers: headers);

      return json.decode(response.body);
    } catch (e) {
      return {'message': 'no internet'};
    }
  }

  static getAll() async {
    try {
      print('masuk getALL');
      String token = User.token;
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
      print('masuk getALL');
      var response = await http.get(Uri.parse('http://192.168.100.202:8000/api/devices'), headers: headers);
      print('masuk getALL');
      var result = json.decode(response.body);
      print('didalam getAll: ');
      print(result);
      if (result[0] != null) {
        countDevice = result.length;
      } else {
        countDevice = 0;
      }
      return result;
    } catch (e) {
      return {'message': 'no internet'};
    }
  }

  static updateName(String name, int id) async {
    try {
      String token = User.token;
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      var body = {'name': name};
      var response =
          await http.put(Uri.parse('http://192.168.100.202:8000/api/devices/$id'), headers: headers, body: body);
      print(response.body);
      return json.decode(response.body);
    } catch (e) {
      return {'message': 'no internet'};
    }
  }

  static updateValue(int value, int id) async {
    try {
      String token = User.token;
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      var body = {'value': value};
      var response =
          await http.put(Uri.parse('http://192.168.100.202:8000/api/devices/$id'), headers: headers, body: body);
      print(response.body);
      return json.decode(response.body);
    } catch (e) {
      return {'message': 'no internet'};
    }
  }

  static updateState(int state, int id) async {
    try {
      String token = User.token;
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      var body = {'state': state.toString()};
      var response =
          await http.put(Uri.parse('http://192.168.100.202:8000/api/devices/$id'), headers: headers, body: body);
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
      var response = await http.delete(Uri.parse('http://192.168.100.202:8000/api/devices/$id'), headers: headers);
      return json.decode(response.body);
    } catch (e) {
      return {'message': 'no internet'};
    }
  }
}

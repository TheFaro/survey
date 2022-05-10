import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snau_survey/models/models.dart';
import 'dart:async';
import 'dart:convert';
import 'package:snau_survey/views/views.dart';

abstract class AccessServiceAbstract {
  Future<Map<String, dynamic>> loginRequest(
      {required String email, required String password});
  Future<String> registerRequest(
      {required String email,
      required String username,
      required String name,
      required String password,
      required Object organization});
  Future<Map<String, dynamic>> checkLoginStatus();
  Future saveSharedPreferences({
    required int id,
    required String email,
    required String name,
    required bool logged,
    required String surname,
    required String phone,
    required String gender,
    required String designation,
    required int level,
    required String status,
    required String token,
  });
  Future confirmEmailForgotPassword({required String email});
  Future<String> resetPassword({required String password});
  Future<List<Organization>> getOrganizations();
  Future<int> getUserId();
}

class AccessService extends AccessServiceAbstract {
  //final String domain = "http://backend.esnaufis.org/api"; // live server
  // final String domain = "http://localhost:4000/api";
  final String domain = "http://survey.esnaufis.org/api/"; // new server
  Helpers helper = Helpers();

  @override
  Future<Map<String, dynamic>> loginRequest({
    required String email,
    required String password,
  }) async {
    Uri uri = Uri.parse(domain + '/login');

    Map<String, String> headers = {'Content-Type': 'application/json'};

    Map<String, dynamic> body = {
      'username': email,
      'password': password,
    };

    try {
      http.Response response =
          await http.post(uri, headers: headers, body: json.encode(body));
      print(response.body);

      if (response.body.isNotEmpty) {
        Map res = json.decode(response.body);

        if (res['success'] == 1) {
          // Object organization = res['organization'];
          // String username = res['username'];
          // String name = res['name'];
          saveSharedPreferences(
            id: res['id'],
            email: res['email'],
            name: res['name'],
            logged: true,
            surname: res['surname'],
            phone: res['phone'],
            gender: res['gender'],
            designation: res['designation'],
            level: res['level'],
            status: res['status'],
            token: res['token'],
          );

          // create user
          User user = User(
            id: res['id'],
            name: res['name'],
            surname: res['surname'],
            phone: res['phone'],
            email: res['email'],
            gender: res['gender'],
            designation: res['designation'],
            level: res['level'],
            verificationCode: res['verification_code'],
            status: res['status'],
          );

          Map<String, dynamic> mess = {
            'user': user,
            'message': res['message'],
          };

          return mess;
        } else {
          throw Exception(res['message'].toString());
        }
      } else {
        throw Exception('Error occurred while logging $email');
      }
    } catch (err) {
      throw Exception(err.toString().replaceAll('Exception:', ''));
    }
  }

  @override
  Future<String> registerRequest({
    required String email,
    required String username,
    required String name,
    required String password,
    required Object organization,
  }) async {
    Uri uri = Uri.parse(domain + '');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'organization': organization,
      'email': email,
      'username': username,
      'name': name,
      'password': password,
    };

    try {
      http.Response response =
          await http.post(uri, headers: headers, body: json.encode(body));
      print(response.body);

      if (response.body.isNotEmpty) {
        Map res = json.decode(response.body);

        if (res['success'] == 1) {
          // save in shared preferences
          // saveSharedPreferences(
          //     organization, email, username, name, password, true);

          return 'Registration successful.';
        } else {
          throw Exception(res['message'].toString());
        }
      } else {
        throw Exception('Error occurred while registering : $email');
      }
    } catch (err) {
      throw Exception(err.toString().replaceAll('Exception:', ''));
    }
  }

  @override
  Future<Map<String, dynamic>> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? logged = prefs.getBool('logged');

    if (logged != null) {
      if (logged) {
        // get user Information
        User user = User(
          id: prefs.getInt('id')!,
          name: prefs.getString('name')!,
          surname: prefs.getString('surname')!,
          phone: prefs.getString('phone')!,
          email: prefs.getString('email')!,
          gender: prefs.getString('gender')!,
          designation: prefs.getString('designation')!,
          level: prefs.getInt('level')!,
          verificationCode: prefs.getString('verication_code'),
          status: prefs.getString('status')!,
        );

        return {'logged': logged, 'user': user};
      } else {
        return {'logged': logged};
      }
    } else {
      throw Exception('Please log in again.');
    }
  }

  @override
  Future saveSharedPreferences({
    required int id,
    required String email,
    required String name,
    required bool logged,
    required String surname,
    required String phone,
    required String gender,
    required String designation,
    required int level,
    required String status,
    required String token,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // TODO : save required fields

    //prefs.setString('organization', organization.toString());
    prefs.setInt('id', id);
    prefs.setString('email', email);
    prefs.setString('name', name);
    prefs.setString('surname', surname);
    prefs.setString('phone', phone);
    prefs.setString('gender', gender);
    prefs.setString('designation', designation);
    prefs.setInt('level', level);
    prefs.setString('status', status);
    prefs.setString('token', token);
    prefs.setBool('logged', logged);
  }

  @override
  Future confirmEmailForgotPassword({
    required String email,
  }) async {
    Uri uri = Uri.parse(domain + '');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {
      'email': email,
    };

    try {
      http.Response response =
          await http.post(uri, headers: headers, body: json.encode(body));
      print(response.body);

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email_forgot_password', email);
      } else {
        throw Exception('Error occurred while requesting renew password code.');
      }
    } catch (err) {
      throw Exception(err.toString().replaceAll('Exception:', ''));
    }
  }

  @override
  Future<String> resetPassword({
    required String password,
  }) async {
    Uri uri = Uri.parse(domain + '');

    Map<String, dynamic> body = {'new_password': password};

    try {
      http.Response response =
          await http.put(uri, headers: helper.headers, body: json.encode(body));
      print(response.body);

      if (response.statusCode == 200) {
        Map res = json.decode(response.body);

        if (res['success'] == 1) {
          return 'Successfully updated password.';
        } else {
          throw Exception('Error occurred while updating password.');
        }
      } else {
        throw Exception('Error occurred while updating new password.');
      }
    } catch (err) {
      throw Exception(err.toString().replaceAll('Exception:', ''));
    }
  }

  @override
  Future<List<Organization>> getOrganizations() async {
    Uri uri = Uri.parse(domain + '');

    try {
      http.Response response = await http.get(uri, headers: helper.headers);
      print(response.body);

      if (response.statusCode == 200) {
        Map res = json.decode(response.body);

        if (res['success'] == 1) {
          List orgs = res['organizations'];

          return orgs.map((e) => Organization.fromJson(e)).toList();
        } else {
          throw Exception('Error occurred while getting organizations.');
        }
      } else {
        Map res = json.decode(response.body);
        throw Exception(res['message'].toString());
      }
    } catch (err) {
      throw Exception(err.toString().replaceAll("Exception:", ''));
    }
  }

  @override
  Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int? id = prefs.getInt('id');

    if (id != null) {
      return id;
    } else {
      throw Exception('Id not found.');
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/model/client_model.dart';
import 'package:http/http.dart' as http;

class Clientprovider extends ChangeNotifier {
  Client? _client;
  String? accessToken;

  Client get getClient {
    return _client!;
  }

  Future<void> loginuser(String email, String password) async {
    const url = 'https://jide-taiwo.herokuapp.com/api/client/login';
    try {
      final response = await http.post(Uri.parse(url),
          body: {'email': email.toLowerCase(), 'password': password});
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
      var extractedClient = responseData['client'];
      _client = Client(
          clientId: extractedClient['id'].toString(),
          clientName: extractedClient['name'],
          phoneNumber: extractedClient['mobile'],
          emailAddress: extractedClient['email'],
          clientCategory: extractedClient['category']['name'],
          clientAddress: extractedClient['address'],
          clientDistrict: extractedClient['district'],
          clientState: extractedClient['state'],
          lastLogin: DateTime.parse(extractedClient['last_login']));
      accessToken = responseData['token'];
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  /*Future<String> loginUser(String id, String phoneNumber) async {
    const url = 'https://jidetaiwoandco.com/mytest/api/post/clientsdb.php';
    try {
      HttpClient httpClient = HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
      request.headers.set('Content-type', 'application/json');
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      var extractedData = json.decode(reply) as List<dynamic>;
      httpClient.close();
      final clientDetails = extractedData.firstWhere(
          (element) =>
              element['clientid'] == id &&
              element['clientmobilenumber'] == phoneNumber,
          orElse: () => null);
      if (clientDetails == null) {
        throw const HttpException('Incorrect login credentials');
      }
      _client = Client(
          clientId: clientDetails['clientid'],
          clientName: clientDetails['clientname'],
          phoneNumber: clientDetails['clientmobilenumber'],
          emailAddress: clientDetails['clientemail'],
          clientCategory: clientDetails['clientcategory'],
          clientAddress: clientDetails['clientaddress'],
          clientDistrict: clientDetails['clientdistrict'],
          clientState: clientDetails['clientstate']);
      notifyListeners();
      return clientDetails['clientid'];
    } catch (error) {
      rethrow;
    }
  }*/

  Future<void> signupUser(Client client, String password) async {
    try {
      final response = await http.post(
          Uri.parse('https://jide-taiwo.herokuapp.com/api/client/signup'),
          body: {
            'categoryId': client.clientCategory,
            'email': client.emailAddress.toString().toLowerCase(),
            'password': password,
            'mobile': client.phoneNumber,
            'name': client.clientName,
            'address': client.clientAddress,
          });
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateUser(
      {String? name,
      String? phoneNumber,
      String? address}) async {
    try {
      final response = await http.put(
          Uri.parse(
              'https://jide-taiwo.herokuapp.com/api/client/edit-client/${_client!.clientId}'),
          headers: {
            'Authorization': 'Bearer $accessToken'
          },
          body: {
            'name': name,
            'phone': phoneNumber,
            'address': address
          });
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
      _client = Client(
          clientId: _client!.clientId,
          clientName: responseData['client']['name'],
          phoneNumber: responseData['client']['mobile'],
          emailAddress: _client!.emailAddress,
          clientCategory: _client!.clientCategory,
          clientAddress: responseData['client']['address'],
          clientDistrict: _client!.clientDistrict,
          clientState: _client!.clientState,
          lastLogin: _client!.lastLogin);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> changepassword(String oldpassword, String newpassword) async {
    try {
      final response = await http.put(
          Uri.parse(
              'https://jide-taiwo.herokuapp.com/api/client/changepassword/${_client!.clientId}'),
          headers: {
            'Authorization': 'Bearer $accessToken'
          },
          body: {
            'oldpassword': oldpassword,
            'newpassword': newpassword,
          });
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> forgetpassword(String email) async {
    try {
      final response = await http.post(
          Uri.parse(
              'https://jide-taiwo.herokuapp.com/api/client/forgetpassword'),
          body: {'email': email});
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
      return;
    } catch (error) {
      rethrow;
    }
  }

  Future<String> verifycode(String code) async {
    try {
      final response = await http.post(
          Uri.parse('https://jide-taiwo.herokuapp.com/api/client/verify-code'),
          body: {'code': code});
      if (response.statusCode >= 400) {
        throw HttpException(json.decode(response.body)['error']);
      }
      return code;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> resetpassword(String code, String newPassword) async {
    try {
      final response = await http.post(
          Uri.parse(
              'https://jide-taiwo.herokuapp.com/api/client/resetpassword/$code'),
          body: {'newPassword': newPassword});
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
      return;
    } catch (error) {
      rethrow;
    }
  }
}

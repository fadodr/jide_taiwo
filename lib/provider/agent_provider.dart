import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jidetaiwoapp/model/agent_model.dart';

class Agentprovider extends ChangeNotifier {
  Agent? _agent;
  String? accessToken;

  Agent get getAgent {
    return _agent!;
  }

  Future<void> loginuser(String email, String password) async {
    const url = 'https://jide-taiwo.herokuapp.com/api/agent/login';
    try {
      final response = await http.post(Uri.parse(url),
          body: {'email': email.toLowerCase(), 'password': password});
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }
      var extractedClient = responseData['agent'];
      _agent = Agent(
          clientId: extractedClient['id'].toString(),
          clientName: extractedClient['name'],
          clientMobileNumber: extractedClient['mobile'],
          clientEmail: extractedClient['email'],
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

  Future<void> signupUser(Agent agent, String password) async {
    try {
      final response = await http.post(
          Uri.parse('https://jide-taiwo.herokuapp.com/api/agent/signup'),
          body: {
            'categoryId': agent.clientCategory,
            'email': agent.clientEmail.toString().toLowerCase(),
            'password': password,
            'mobile': agent.clientMobileNumber,
            'name': agent.clientName,
            'address': agent.clientAddress,
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
              'https://jide-taiwo.herokuapp.com/api/agent/edit-agent/${_agent!.clientId}'),
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
      _agent = Agent(
          clientId: _agent!.clientId,
          clientName: responseData['agent']['name'],
          clientMobileNumber: responseData['agent']['mobile'],
          clientEmail: _agent!.clientEmail,
          clientCategory: _agent!.clientCategory,
          clientAddress: responseData['agent']['address'],
          clientDistrict: _agent!.clientDistrict,
          clientState: _agent!.clientState,
          lastLogin: _agent!.lastLogin);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> changepassword(String oldpassword, String newpassword) async {
    try {
      final response = await http.put(
          Uri.parse(
              'https://jide-taiwo.herokuapp.com/api/agent/changepassword/${_agent!.clientId}'),
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
              'https://jide-taiwo.herokuapp.com/api/agent/forgetpassword'),
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
          Uri.parse('https://jide-taiwo.herokuapp.com/api/agent/verify-code'),
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
              'https://jide-taiwo.herokuapp.com/api/agent/resetpassword/$code'),
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

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/model/client_dashboard_model.dart';
import 'package:http/http.dart' as http;

class ClientDashboardProvider extends ChangeNotifier {
  List<ClientDashboard> _clientDashboard = [];

  List<ClientDashboard> get getClientDashboardData {
    return [..._clientDashboard];
  }

  Future<void> fetchClientDashboardInformation(int clientId) async {
    try {
      HttpClient httpClient = HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          'https://jidetaiwoandco.com/mailsolution/propertybriefauthapi.php?client=$clientId'));
      request.headers.set('Content-type', 'application/json');
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      var extractedData = json.decode(reply) as List<dynamic>;
      List<ClientDashboard> loadedClientDashboardInfo = [];
      for(var clientInfo in extractedData){
         loadedClientDashboardInfo.add(ClientDashboard(
            property: clientInfo['title'],
            type: clientInfo['propertytype'],
            tenancy: clientInfo['propertystatus'],
            contract: clientInfo['propertycontract']));
      }
      httpClient.close();
      _clientDashboard = loadedClientDashboardInfo;
    } catch (error) {
      rethrow;
    }
  }
}

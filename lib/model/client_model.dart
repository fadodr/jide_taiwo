import 'package:flutter/material.dart';

class Client {
  final String? clientId;
  final String? clientName;
  final String? phoneNumber;
  final String? emailAddress;
  final String? clientCategory;
  final String? clientAddress;
  final String? clientDistrict;
  final String? clientState;
  final DateTime? lastLogin;

  Client(
      {@required this.clientId,
      @required this.clientName,
      @required this.phoneNumber,
      @required this.emailAddress,
      @required this.clientCategory,
      @required this.clientAddress,
      @required this.clientDistrict,
      @required this.clientState,
      @required this.lastLogin});
}

import 'package:flutter/material.dart';

class Agent {
  final String? clientId;
  final String? clientCategory;
  final String? clientEmail;
  final String? clientMobileNumber;
  final String? clientName;
  final String? clientAddress;
  final String? clientDistrict;
  final String? clientState;
  final DateTime? lastLogin;

  Agent(
      {@required this.clientId,
      @required this.clientCategory,
      @required this.clientEmail,
      @required this.clientMobileNumber,
      @required this.clientName,
      @required this.clientAddress,
      @required this.clientDistrict,
      @required this.clientState,
      @required this.lastLogin});
}

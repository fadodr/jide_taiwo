import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/model/account_type_model.dart';
import 'package:http/http.dart' as http;

class AccountTypeProvider extends ChangeNotifier {
  List<AccountType> _accountType = [];

  List<AccountType> get getaccountType {
    return [..._accountType];
  }

  Future<void> fetchAccoutType() async {
    if (_accountType.isEmpty) {
      try {
        final response = await http.get(
            Uri.parse('https://jide-taiwo.herokuapp.com/api/categories/fetch'));
        final responseData =
            json.decode(response.body)['categories'] as List<dynamic>;
        List<AccountType> _loadedAccountType = [];
        if(responseData.length != 0){
          responseData.forEach((accountType) {
            _loadedAccountType
                .add(AccountType(accountType['id'], accountType['name']));
          });
        }
        _accountType = _loadedAccountType;
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }
}

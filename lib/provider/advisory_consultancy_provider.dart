import 'package:flutter/material.dart';

class Advisory {
  final String? text;
  final String? title;
  final String? image;

  Advisory({@required this.title, @required this.image, @required this.text});
}

List<Advisory> advisories = [
  Advisory(
      title: 'Project Development',
      image: 'assets/images/Project_development.png',
      text:
          'The Project Team work across the depth of our branch offices located in every geo-political zones of Nigeria. Professionally qualified and leaning on a rare assemblage of wealth of experience, each consultant regularly updates knowledge of the current trends and potentialities of the future. '),
  Advisory(
      title: 'Rating Services',
      image: 'assets/images/Rating_services.png',
      text:
          'Whether for government, businesses, landlords or tenants, our rating team provides best- in class services. Our teams help clients in assessing, managing and challenging rateable values and taxes on clients behalf. We help clients minimize rates and tax liabilities, while ensuring advisory on vacant or under-utilized spaces yield optimally for our clients.'),
];
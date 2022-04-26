import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/widgets/appbar_widget.dart';
import 'package:jidetaiwoapp/widgets/button_widget.dart';

class SearchforpropertyScreen extends StatefulWidget {
  static const routename = '/searchforpropertyscreen';
  SearchforpropertyScreen({Key? key}) : super(key: key);

  @override
  State<SearchforpropertyScreen> createState() =>
      _SearchforpropertyScreenState();
}

class _SearchforpropertyScreenState extends State<SearchforpropertyScreen> {
  List _searches = [];
  TextEditingController _propertyId = TextEditingController();

  @override
  void dispose() {
    _propertyId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _dropdownform(String hintText, List<String> data) {
      return DropdownButtonFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: hextocolor('#FAFAFA'),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.white)),
        ),
        hint: Text(
          hintText,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 14, color: hextocolor('#C4C4C4')),
        ),
        isExpanded: true,
        iconEnabledColor: Theme.of(context).primaryColor,
        items: data.map((value) {
          return DropdownMenuItem(
            value: value,
            child: FittedBox(
              child: Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14, color: hextocolor('#5E5B5B')),
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          FocusScope.of(context).requestFocus(FocusNode());
          if(hintText.toLowerCase() != 'location'){
            _searches
                .add({hintText.toLowerCase(): value.toString().toLowerCase()});
          }
        },
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget('Search for Properties', IconButton(
        onPressed: () {
          Navigator.pop(context, _searches);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 28,
        ))),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/watermarkimage2.png'))),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Search by filters',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 14,
                      color: hextocolor('#C4C4C4'),
                    ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                      child: _dropdownform('Type', [
                    'Commercial and Industrial',
                    'Land',
                    'Mixed use',
                    'Residential'
                  ])),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: _dropdownform('Sale', [
                    'Contract',
                    'Letting',
                    'Lease',
                    'Valuation',
                    'Sale'
                  ]))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child:
                          _dropdownform('Bedrooms', ['1', '2', '3', '4', '5'])),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child:
                          _dropdownform('Bathrooms', ['1', '2', '3', '4', '5']))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              _dropdownform(
                  'Location', ['Nigeria', 'UK (London)', 'UAE (Dubai)']),
              const SizedBox(
                height: 10,
              ),
              _dropdownform('Price Range', [
                '1000000 - 50000000',
                '51000000 - 100000000',
                '101000000 - 200000000',
                '201000000 - 300000000'
              ]),
              const SizedBox(
                height: 10,
              ),
              TextField(
                autofocus: false,
                controller: _propertyId,
                focusNode: FocusNode(canRequestFocus: false),
                onChanged: (value) {
                  _searches.add({'propertyid': value.toLowerCase()});
                },
                decoration: InputDecoration(
                  labelText: 'Property ID',
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 16, color: hextocolor('#C4C4C4')),
                  filled: true,
                  fillColor: hextocolor('#FAFAFA'),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.blue)),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButtonWidget(
                  width: double.infinity,
                  height: 48,
                  buttonText: 'Search',
                  borderRadius: 8,
                  ontap: () {
                    Navigator.pop(context, _searches);
                  },
                  textColor: Colors.white,
                  bgColor: Theme.of(context).primaryColor)
            ]),
          ),
        ),
      ),
    );
  }
}

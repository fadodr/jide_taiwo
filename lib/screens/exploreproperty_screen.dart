import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/model/property_model.dart';
import 'package:jidetaiwoapp/provider/property_provider.dart';
import 'package:jidetaiwoapp/screens/getintouch_screen.dart';
import 'package:jidetaiwoapp/screens/login_screen.dart';
import 'package:jidetaiwoapp/screens/searchforproperty_screen.dart';
import 'package:jidetaiwoapp/widgets/appbar_widget.dart';
import 'package:jidetaiwoapp/widgets/property_image_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ExplorePropertyScreen extends StatefulWidget {
  static const routename = '/explorescreen';
  const ExplorePropertyScreen({Key? key}) : super(key: key);

  @override
  State<ExplorePropertyScreen> createState() => _ExplorePropertyScreenState();
}

class _ExplorePropertyScreenState extends State<ExplorePropertyScreen> {
  final FocusNode _searchfocusNode = FocusNode();
  final value = NumberFormat("#,##0.00", "en_US");
  List _searches = [];
  List<Property> extractedPropertiesData = [];
  List<Property> propertiesData = [];

  @override
  void initState() {
    extractedPropertiesData =
        Provider.of<PropertyProvider>(context, listen: false).getPropertiesData;
    propertiesData = extractedPropertiesData;
    _searchfocusNode.addListener(_onsearchTap);
    super.initState();
  }

  @override
  void dispose() {
    _searchfocusNode.removeListener(_onsearchTap);
    _searchfocusNode.dispose();
    super.dispose();
  }

  void _onsearchTap() {
    if (_searchfocusNode.hasFocus) {
      FocusScope.of(context).unfocus();
      Navigator.of(context)
          .pushNamed(SearchforpropertyScreen.routename)
          .then((value) {
        _searches = value as List;
        if (_searches.isNotEmpty) {
          for (var item in _searches) {
            if (item['price range'] != null) {
              final lowPrice = item['price range'].split(' - ')[0];
              final highPrice = item['price range'].split(' - ')[1];

              propertiesData = extractedPropertiesData
                  .where((element) =>
                      element.contract.toString().toLowerCase() ==
                          item['sale'] ||
                      element.numberOfRooms == item['bedrooms'] ||
                      element.numberOfBathrooms == item['bathrooms'] ||
                      (double.parse(lowPrice) <= element.price! &&
                          element.price! <= double.parse(highPrice)) ||
                      element.id.toString().toLowerCase() == item['propertyid'])
                  .toList();
            } else {
              propertiesData = extractedPropertiesData
                  .where((element) =>
                      element.contract.toString().toLowerCase() ==
                          item['sale'] ||
                      element.numberOfRooms == item['bedrooms'] ||
                      element.numberOfBathrooms == item['bathrooms'] ||
                      element.id.toString().toLowerCase() == item['propertyid'])
                  .toList();
            }
          }
        } else {
          propertiesData = extractedPropertiesData;
        }
        setState(() {});
      });
    }
  }

  Widget _fourContainers(IconData icon, int index, int propertyIndex,
      String label, Color bgColor, Color textColor) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {}
        if (index == 1) {
          Navigator.of(context).pushNamed(LoginScreen.routename,
              arguments: {'appbarText': 'client'});
        }
        if (index == 2) {
          launch('tel://${propertiesData[propertyIndex].clientMobile}');
        }
        if (index == 3) {
          Navigator.of(context).pushNamed(GetInTouchScreen.routename);
        }
      },
      child: Container(
        height: 46,
        width: (MediaQuery.of(context).size.width / 2) - 35.0,
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: textColor,
            ),
            const SizedBox(width: 7),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 14, color: textColor),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Builder(
          builder: (context) => const AppBarWidget('Explore our properties'),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/watermarkimage2.png'))),
        child: Column(
          children: [
            TextField(
              autofocus: false,
              focusNode: _searchfocusNode,
              decoration: InputDecoration(
                labelText: 'Search for properties',
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16, color: hextocolor('#C4C4C4')),
                filled: true,
                fillColor: hextocolor('#FAFAFA'),
                suffixIcon: const Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Colors.blue)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            propertiesData.isEmpty ? Expanded(
              child: Center(
                child: Text('No items found', style: TextStyle(
                  fontSize: 18
                ),),
              ),
            ) : Expanded(
                child: ListView.builder(
                    itemCount: propertiesData.length,
                    itemBuilder: (ctx, index) => Column(
                          children: [
                            PropertyImageWidget(id: propertiesData[index].id!),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(propertiesData[index].description!,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 16)),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: hextocolor('#F7FCFF'),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Office ID: ${propertiesData[index].officeId}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 14,
                                              color: hextocolor('#5694C1')),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Location: ${propertiesData[index].location}',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 14,
                                              color: hextocolor('#5694C1')),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Branch: ${propertiesData[index].branch}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 14,
                                              color: hextocolor('#5694C1')),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Price: ${value.format(propertiesData[index].price!.toInt())}',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 14,
                                              color: hextocolor('#5694C1')),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Contract: ${propertiesData[index].contract}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 14,
                                              color: hextocolor('#5694C1')),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Rooms: ${propertiesData[index].numberOfRooms}',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 14,
                                              color: hextocolor('#5694C1')),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Status: ${propertiesData[index].status}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 14,
                                              color: hextocolor('#5694C1')),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Area: ${propertiesData[index].area}',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 14,
                                              color: hextocolor('#5694C1')),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Bathrooms: ${propertiesData[index].numberOfBathrooms}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 14,
                                              color: hextocolor('#5694C1')),
                                        ),
                                      ),
                                      if (propertiesData[index].balcony == true)
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.check_circle,
                                                size: 18,
                                                color: hextocolor('#5694C1'),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Balcony',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 14,
                                                    color:
                                                        hextocolor('#5694C1')),
                                              )
                                            ],
                                          ),
                                        )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.remove_red_eye,
                                              size: 18,
                                              color: hextocolor('#5694C1'),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${propertiesData[index].numberOfViews} views',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14,
                                                  color: hextocolor('#5694C1')),
                                            )
                                          ],
                                        ),
                                      ),
                                      if (propertiesData[index].parking == true)
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.check_circle,
                                                size: 18,
                                                color: hextocolor('#5694C1'),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'parking',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 14,
                                                    color:
                                                        hextocolor('#5694C1')),
                                              )
                                            ],
                                          ),
                                        )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _fourContainers(
                                    Icons.share,
                                    0,
                                    index,
                                    'Share property',
                                    hextocolor('#E1E1E1'),
                                    Colors.black),
                                _fourContainers(
                                    Icons.favorite_outline,
                                    1,
                                    index,
                                    'Add to Favourites',
                                    hextocolor('#FDEFED'),
                                    hextocolor('#EC5757'))
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _fourContainers(
                                    Icons.call,
                                    2,
                                    index,
                                    'Give us a call',
                                    hextocolor('#F2FFF3'),
                                    hextocolor('#247828')),
                                _fourContainers(
                                    Icons.mail,
                                    3,
                                    index,
                                    'Send a message',
                                    hextocolor('#FFFAEC'),
                                    hextocolor('#CF9B14'))
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        )))
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/provider/account_type_provider.dart';
import 'package:jidetaiwoapp/provider/property_provider.dart';
import 'package:jidetaiwoapp/screens/agentlisting_screen.dart';
import 'package:jidetaiwoapp/screens/auction_screen.dart';
import 'package:jidetaiwoapp/screens/getintouch_screen.dart';
import 'package:jidetaiwoapp/screens/login_screen.dart';
import 'package:jidetaiwoapp/screens/exploreproperty_screen.dart';
import 'package:jidetaiwoapp/screens/valuation_screen.dart';
import 'package:jidetaiwoapp/widgets/appbartwo_widget.dart';
import 'package:jidetaiwoapp/widgets/drawer/main_menu_one_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routename = '/homescreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  bool firsTimeLoaded = true;
  @override
  void initState() {
    if (firsTimeLoaded) {
      _loadPropertiesToScreen();
    }
    super.initState();
  }

  Future<void> _loadPropertiesToScreen() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<PropertyProvider>(context, listen: false)
          .fetchListOfProperties();
      await Provider.of<AccountTypeProvider>(context, listen: false)
          .fetchAccoutType();
      setState(() {
        _isLoading = false;
      });
    } on SocketException catch (_) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Please check your internet connection',
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false);
                    },
                    child: Text(
                      'try again',
                      style: TextStyle(
                          fontSize: 14, color: Theme.of(context).primaryColor),
                    ))
              ],
            );
          });
    } catch (error) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'An error occured , try again later',
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false);
                    },
                    child: Text(
                      'try again',
                      style: TextStyle(
                          fontSize: 14, color: Theme.of(context).primaryColor),
                    ))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final valueLoaded = ModalRoute.of(context)!.settings.arguments;
    if (valueLoaded == null) {
      firsTimeLoaded = true;
    } else {
      firsTimeLoaded = ModalRoute.of(context)!.settings.arguments as bool;
    }
    List gridviewItems = [
      {
        'image': 'assets/icons/propertysearch.png',
        'text': 'Property Search',
        'navigation': ExplorePropertyScreen.routename
      },
      {
        'image': 'assets/icons/clientlogin.png',
        'text': 'Client Login',
        'navigation': LoginScreen.routename
      },
      {
        'image': 'assets/icons/saleauctions.png',
        'text': 'Auctions',
        'navigation': AuctionScreen.routename
      },
      {
        'image': 'assets/icons/agentlisting.png',
        'text': 'Agent Property Listing',
        'navigation': AgentListingScreen.routename
      },
      {
        'image': 'assets/icons/contactus.png',
        'text': 'Contact Us',
        'navigation': GetInTouchScreen.routename
      },
      {
        'image': 'assets/icons/valuation.png',
        'text': 'Valuation',
        'navigation': ValuationScreen.routename
      }
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Builder(
          builder: (context) => AppBarTwoWidget(
              'JIDE TAIWO & CO.',
              _isLoading
                  ? () {}
                  : () {
                      Scaffold.of(context).openDrawer();
                    }),
        ),
      ),
      drawerEnableOpenDragGesture: false,
      drawer: const MenuMenuOneDrawer(),
      body: _isLoading
          ? Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/watermarkimage2.png'))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                      color: Theme.of(context).primaryColor),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    'Please Wait',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/watermarkimage2.png'))),
              child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 30),
                  itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () {
                          if (gridviewItems[index]['navigation'] !=
                              LoginScreen.routename) {
                            Navigator.of(context)
                                .pushNamed(gridviewItems[index]['navigation']);
                          } else {
                            Navigator.of(context).pushNamed(
                                gridviewItems[index]['navigation'],
                                arguments: {'appbarText': 'client'});
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  padding: index != 4
                                      ? const EdgeInsets.only(top: 10, left: 10)
                                      : null,
                                  decoration: index != 4
                                      ? BoxDecoration(
                                          color: hextocolor('#FFEAE8'),
                                          shape: BoxShape.circle)
                                      : null,
                                  child: Image(
                                    image: AssetImage(
                                        gridviewItems[index]['image']),
                                    fit: BoxFit.cover,
                                  )),
                              Text(
                                gridviewItems[index]['text'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      )),
            ),
    );
  }
}

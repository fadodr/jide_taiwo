import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/widgets/appbar_dashboard.dart';
import 'package:jidetaiwoapp/widgets/client_dashboard_datatable_widget.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({Key? key}) : super(key: key);

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  bool showRent = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hextocolor('#E5E5E5'),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarDashboardWidget('My Dashboard'),
      ),
      body: Container(
        decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/watermarkimage2.png'))),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 50, left: 50, right: 20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const Text(
                        'Rent savings',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          showRent
                              ? const Expanded(
                                child: Text('Unavailable',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              )
                              : const Expanded(
                                child: Text('********',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              ),
                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(onPressed: (){
                            setState(() {
                              showRent = !showRent;
                            });
                          }, icon: showRent ? const Icon(
                            Icons.visibility,
                            color: Colors.white,
                          ) : const Icon(
                            Icons.visibility_off,
                            color: Colors.white,
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const ClientDashboardDataTable()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

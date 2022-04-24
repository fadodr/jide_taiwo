import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/provider/client_provider.dart';
import 'package:jidetaiwoapp/widgets/appbartwo_widget.dart';
import 'package:jidetaiwoapp/widgets/drawer/client_dashboard_menu_drawer.dart';
import 'package:provider/provider.dart';

class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({Key? key}) : super(key: key);

  DataRow dataRows(property, textString) {
    return DataRow(cells: [
      DataCell(Text(
        property,
        style: const TextStyle(fontSize: 15),
      )),
      textString !=
          null ? DataCell(Text(
        textString,
        style: const TextStyle(fontSize: 15),
      )) : const DataCell(Text(
          '',
      ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final _client = Provider.of<Clientprovider>(context).getClient;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Builder(
            builder: (context) => AppBarTwoWidget('My Profile', () {
              Scaffold.of(context).openDrawer();
            }),
          ),
        ),
        drawerEnableOpenDragGesture: false,
        drawer: const ClientDashboradMenuDrawer(),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/watermarkimage2.png'))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  title: Text(_client.clientName.toString()),
                  subtitle: Text('Email: ${_client.emailAddress}'),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    'Personal Details',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: DataTable(
                      dataRowHeight: 60,
                      showBottomBorder: true,
                      headingRowHeight: 0,
                      columns: const [
                        DataColumn(label: Text('')),
                        DataColumn(label: Text(''))
                      ],
                      rows: [
                        dataRows('Account Type', _client.clientCategory),
                        dataRows('Mobile Number', _client.phoneNumber),
                        dataRows('Address', _client.clientAddress),
                        dataRows('District', _client.clientDistrict),
                        dataRows('State', _client.clientState),
                      ]),
                )
              ],
            ),
          ),
        ));
  }
}

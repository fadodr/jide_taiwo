import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/widgets/appbar_widget.dart';
import 'package:jidetaiwoapp/widgets/appbartwo_widget.dart';
import 'package:jidetaiwoapp/widgets/bottom_navigation_widget.dart';
import 'package:jidetaiwoapp/widgets/drawer/client_dashboard_menu_drawer.dart';
import '../hextocolor.dart';

class ComplaintsScreen extends StatelessWidget {
  static const routename = '/complaintscreen';

  const ComplaintsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hextocolor('#E5E5E5'),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Builder(
          builder: (context) => AppBarTwoWidget('Complaints', () {
            Scaffold.of(context).openDrawer();
          }),
        ),
      ),
      drawerEnableOpenDragGesture: false,
      drawer: const ClientDashboradMenuDrawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/watermarkimage2.png'))),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none
                ),
                filled: true,
                fillColor: hextocolor('#FFFFFF'),
                labelText: 'Add a complaint',
                labelStyle: const TextStyle(
                  fontSize: 14
                )
            )
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: DataTable(
                  columnSpacing: 42.0,
                    columns: [
                      DataColumn(label: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: hextocolor('#A4A4A4')
                          )
                        ),
                      )),
                      const DataColumn(label: Text('Complaints')),
                      const DataColumn(label: Text('Status')),
                      const DataColumn(label: Text('View')),
                    ],
                    showBottomBorder: true,
                    rows: const []),
              ),
            )
          ],
        ),
      ),
      //bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}

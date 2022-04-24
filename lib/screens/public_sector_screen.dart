import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/widgets/appbartwo_widget.dart';
import 'package:jidetaiwoapp/widgets/appbar_widget.dart';
import 'package:jidetaiwoapp/widgets/bottom_navigation_widget.dart';
import 'package:jidetaiwoapp/widgets/drawer/main_menu_one_drawer.dart';

class PublicSectorScreen extends StatelessWidget {
  static const routename = '/publicsectorscreen';
  const PublicSectorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Builder(
          builder: (context) => AppBarTwoWidget('Public Sector', () {
            Scaffold.of(context).openDrawer();
          }),
        ),
      ),
      drawerEnableOpenDragGesture: false,
      drawer: const MenuMenuOneDrawer(),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/watermarkimage2.png'))),
        child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '''Jide Taiwo and Co. Public Sector Services team advises clients across the whole spectrum of the public sector. We provide comprehensive property advice in the form of estate strategies, asset management planning and cost reduction initiatives.
        
We undertake feasibility studies, options appraisals and business case work which underpin capital investment decisions and funding approvals in all areas. We add value through the planning and development process, as well as help structure Public Private Partnerships (PPP) or Joint Ventures (JV).''',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14, height: 1.5),
                textAlign: TextAlign.left,
              )),
        ),
      ),
    );
  }
}

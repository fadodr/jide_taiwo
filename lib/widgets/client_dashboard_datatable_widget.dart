import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/hextocolor.dart';
import 'package:jidetaiwoapp/model/client_dashboard_model.dart';
import 'package:jidetaiwoapp/provider/client_dashboard_provider.dart';
import 'package:provider/provider.dart';

class ClientDashboardDataTable extends StatelessWidget {
  const ClientDashboardDataTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ClientDashboard> _clientDashboardData = [];
    List<List<Widget>> _datarows = [];
    _clientDashboardData =
        Provider.of<ClientDashboardProvider>(context, listen: false)
            .getClientDashboardData;
    _clientDashboardData.asMap().forEach((index, data) {
      _datarows.add(<Widget>[
        Text(
          (index + 1).toString(),
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 14, color: hextocolor('#ACA1A1')),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          margin: const EdgeInsets.only(bottom: 10, top: 10),
          width: 100,
          decoration: BoxDecoration(
              color: hextocolor('#FFEAE8'),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            data.property!,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 14, color: Theme.of(context).primaryColor),
          ),
        ),
        Text(
          data.type!,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 14, color: hextocolor('#ACA1A1')),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: data.tenancy!.toLowerCase() == 'available'
                  ? hextocolor('#108315').withOpacity(0.13)
                  : hextocolor('#FFBF00').withOpacity(0.13)),
          child: Text(data.tenancy!,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 14,
                  color: data.tenancy!.toLowerCase() == 'available'
                      ? hextocolor('#1A941F')
                      : hextocolor('#FFBF00'))),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Text(data.contract!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 14, color: hextocolor('#ACA1A1'))),
        ),
      ]);
    });
    return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.white),
              child: FittedBox(
                child: DataTable(
                    dataRowHeight: 100,
                    columnSpacing: 25.0,
                    
                    columns: [
                      DataColumn(
                          label: Text(
                        '#',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Flexible(
                            child: Text(
                                'Property',
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                        )),
                      DataColumn(
                          label: Text(
                        'Type',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'Tenancy',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'Contract',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ))
                    ],
                    rows: List.generate(
                      _clientDashboardData.length,
                      (index) => DataRow(
                          cells: List.generate(
                              5,
                              (innerIndex) =>
                                  DataCell(_datarows[index][innerIndex]))),
                    )),
              ),
            ),
          );
  }
}

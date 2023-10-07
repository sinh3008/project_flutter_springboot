import 'package:flutter/material.dart';
import 'package:project_flutter_springboot/providers/app_data_provider.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/reservation_item_body_view.dart';
import '../custom_widgets/reservation_item_header_view.dart';
import '../models/reservation_expansion_item.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  bool isFirst = true;

  List<ReservationExpansionItem> items = [];

  @override
  void didChangeDependencies() {
    if (isFirst) {
      _getData();
    }
    super.didChangeDependencies();
  }

  _getData() async {
    await Provider.of<AppDataProvider>(context, listen: false)
        .getAllReservations();
    items = Provider.of<AppDataProvider>(context, listen: false)
        .getExpansionItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  items[panelIndex].isExpanded = !isExpanded;
                });
              },
              children: items
                  .map(
                    (item) => ExpansionPanel(
                      isExpanded: item.isExpanded,
                      headerBuilder: (context, isExpanded) =>
                          ReservationItemHeaderView(header: item.header),
                      body: ReservationItemBodyView(body: item.body),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

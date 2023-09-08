import 'package:flutter/material.dart';
import 'package:project_flutter_springboot/models/but_route.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    final BusRoute route = argList[0];
    final String departureDate = argList[1];
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results on $departureDate'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(route.cityTo),
      ),
    );
  }
}

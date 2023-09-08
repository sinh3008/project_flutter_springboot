import 'package:flutter/material.dart';
import 'package:project_flutter_springboot/datasource/data_source.dart';
import 'package:project_flutter_springboot/datasource/dummy_data_source.dart';

import '../models/but_route.dart';

class AppDataProvider extends ChangeNotifier {
  final DataSource _dataSource = DummyDataSource();

  Future<BusRoute?> getRouteByCityFromAndCityTo(
      String cityFrom, String cityTo) {
    return _dataSource.getRouteByCityFromAndCityTo(cityFrom, cityTo);
  }
}

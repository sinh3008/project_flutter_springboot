import 'package:flutter/material.dart';
import 'package:project_flutter_springboot/datasource/data_source.dart';
import 'package:project_flutter_springboot/datasource/dummy_data_source.dart';

import '../models/bus_schedule.dart';
import '../models/but_route.dart';

class AppDataProvider extends ChangeNotifier {
  List<BusSchedule> _scheduleList = [];

  List<BusSchedule> get scheduleList => _scheduleList;

  final DataSource _dataSource = DummyDataSource();

  Future<BusRoute?> getRouteByCityFromAndCityTo(
      String cityFrom, String cityTo) {
    return _dataSource.getRouteByCityFromAndCityTo(cityFrom, cityTo);
  }

  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) async {
    return _dataSource.getSchedulesByRouteName(routeName);
  }
}

import 'package:flutter/material.dart';
import 'package:project_flutter_springboot/datasource/temp_db.dart';
import 'package:project_flutter_springboot/utils/helper_functions.dart';

import '../utils/constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? fromCity, toCity;
  DateTime? departureDate;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true, //đặt thẻ thành center vertical
            padding: const EdgeInsets.all(8),
            children: [
              DropdownButtonFormField<String>(
                value: fromCity,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
                ),
                hint: const Text('Chose from city'),
                items: cities
                    .map((city) => DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        ))
                    .toList(),
                onChanged: (value) {
                  fromCity = value;
                  print(fromCity);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                value: toCity,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
                ),
                hint: const Text('Chose to city'),
                items: cities
                    .map((city) => DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        ))
                    .toList(),
                onChanged: (value) {
                  toCity = value;
                  print(toCity);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: _selectedDate,
                      child: const Text('Select Departure Date'),
                    ),
                    Text(departureDate == null
                        ? 'No date chosen'
                        : getFormattedDate(departureDate!,
                            pattern: 'EEE MMM dd/ yyyy')),
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _search,
                    child: const Text(
                      'SEARCH',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectedDate() async {
    //1 tuần
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 7),
      ),
    );

    if (selectedDate != null) {
      setState(() {
        departureDate = selectedDate;
      });
    }
  }

  void _search() {
    if (departureDate == null) {
      showMsg(context, emptyDateErrMessage);
      return;
    }
    if (_formKey.currentState!.validate()) {
      try {
        final route = TempDB.tableRoute.firstWhere((element) =>
            element.cityFrom == fromCity && element.cityTo == toCity);
        showMsg(context, route.routeName);
        
      } on StateError catch (error) {
        showMsg(context, 'No route found');
      }
    }
  }
}
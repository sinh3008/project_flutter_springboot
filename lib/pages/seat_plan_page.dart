import 'package:flutter/material.dart';
import 'package:project_flutter_springboot/custom_widgets/seat_plan_widgets.dart';
import 'package:project_flutter_springboot/models/bus_schedule.dart';
import 'package:project_flutter_springboot/utils/colors.dart';
import 'package:project_flutter_springboot/utils/constants.dart';

class SeatPlanPage extends StatefulWidget {
  const SeatPlanPage({super.key});

  @override
  State<SeatPlanPage> createState() => _SeatPlanPageState();
}

class _SeatPlanPageState extends State<SeatPlanPage> {
  late BusSchedule schedule;
  late String departureDate;
  int totalSeatBooked = 0;
  String bookedSeatNumbers = '';
  List<String> selectedSeats = [];
  bool isFirst = true;
  bool isDataLoading = true;
  ValueNotifier<String> selectedSeatStringNotifier = ValueNotifier('');

  @override
  void didChangeDependencies() {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    schedule = argList[0];
    departureDate = argList[1];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Plan'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: seatBookedColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Booked',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: seatAvailableColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Available',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: selectedSeatStringNotifier,
              builder: (context, value, _) => Text(
                'Selected: $value',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: SeatPlanView(
                  onSeatSelected: (value, seat) {
                    if (value) {
                      selectedSeats.add(seat);
                      print(selectedSeats.length);
                    }else{
                      selectedSeats.remove(seat);
                      print(selectedSeats.length);
                    }
                    selectedSeatStringNotifier.value = selectedSeats.join(',');
                  },
                  totalSeat: schedule.bus.totalSeat,
                  bookedSeatNumbers: bookedSeatNumbers,
                  totalSeatBooked: totalSeatBooked,
                  isBusinessClass: schedule.bus.busType == busTypeACBusiness,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

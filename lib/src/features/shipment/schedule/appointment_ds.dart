import 'package:expede/src/core/ui/constants.dart';
import 'package:expede/src/model/shipment_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDs extends CalendarDataSource {
  final List<ShipmentModel> schedules;
  final DateTime dateSelected;

  AppointmentDs({required this.schedules, required this.dateSelected});

  @override
  List<dynamic>? get appointments {
    return schedules.map((e) {
      final ShipmentModel(
        sendDate: sendDate,
        arrivalDate: arrivalDate,
        :hour,
        :id,
      ) = e;

      final startTime = DateTime(sendDate.year, sendDate.month, sendDate.day, 0, 0, 0);
      final endTime = DateTime(arrivalDate.year, arrivalDate.month, arrivalDate.day, hour, 0, 0);

      return Appointment(
        color: dateSelected == startTime ?  ColorsConstants.grey : Colors.green,
        startTime: sendDate,
        endTime: arrivalDate,
        subject: dateSelected == startTime ?  ("Envio carregamento: $id") : (" Chegada carregamento: $id"),
        
      );
    }).toList();
  }
}

import 'dart:developer';
import 'package:expede/src/core/ui/constants.dart';
import 'package:expede/src/core/ui/widgets/app_loader.dart';
import 'package:expede/src/features/shipment/schedule/appointment_ds.dart';
import 'package:expede/src/features/shipment/schedule/shipments_schedule_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ShipmentsSchedulePage extends ConsumerStatefulWidget {
  const ShipmentsSchedulePage({super.key});

  @override
  ConsumerState<ShipmentsSchedulePage> createState() =>
      _ShipmentsSchedulePageState();
}

class _ShipmentsSchedulePageState extends ConsumerState<ShipmentsSchedulePage> {
  late DateTime dateSelected;
  DateTime dateSelected1 = DateTime.now();
  var ignoreFistLoad = true;
  var companyId = 3;

  @override
  void initState() {
    final DateTime(:year, :month, :day) = DateTime.now();
    dateSelected = DateTime(year, month, day, 0, 0, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final UserModel(id: userId, :name) =
    //     ModalRoute.of(context)!.settings.arguments as UserModel;

    final scheduleAsync =
        ref.watch(shipmentsScheduleVmProvider(0, companyId, dateSelected, 0));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      body: Column(
        children: [
          const Text(
            "name",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 44,
          ),
          scheduleAsync.when(
            loading: () => const AppLoader(),
            error: (error, stackTrace) {
              log('Erro ao carregar agendamento',
                  error: error, stackTrace: stackTrace);
              return const Center(
                child: Text(
                  'Erro ao carregar pagina',
                ),
              );
            },
            data: (schedules) {
              return Expanded(
                child: SfCalendar(
                  allowViewNavigation: true,
                  view: CalendarView.day,
                  showNavigationArrow: true,
                  todayHighlightColor: ColorsConstants.brow,
                  showDatePickerButton: true,
                  showTodayButton: true,
                  dataSource: AppointmentDs(schedules: schedules, dateSelected: dateSelected1),
                  onViewChanged: (viewChangedDetails) {
                    if (ignoreFistLoad) {
                      ignoreFistLoad = false;
                      return;
                    }
                    ref
                        .read(shipmentsScheduleVmProvider(0, companyId, dateSelected, 0)
                            .notifier)
                        .changeDate(
                            0, companyId, viewChangedDetails.visibleDates.first, 0);
                            dateSelected1 = viewChangedDetails.visibleDates.first;
                  },
                  onTap: (calendarTapDetails) {
                    if (calendarTapDetails.appointments != null &&
                        calendarTapDetails.appointments!.isNotEmpty) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          final dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'Cliente: ${calendarTapDetails.appointments?.first.subject}'),
                                  Text(
                                      'Horário: ${dateFormat.format(calendarTapDetails.date ?? DateTime.now())}')
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

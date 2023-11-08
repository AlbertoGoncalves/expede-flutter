import 'package:expede/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class HoursPanel extends StatefulWidget {
  final List<int>? enabledTimes;
  final ValueChanged<int> onHourPressed;
  final int startTime;
  final int endTime;
  final bool singleSelection;

  const HoursPanel({
    super.key,
    this.enabledTimes,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
  }): singleSelection = false;

    const HoursPanel.singleSelection({
    super.key,
    this.enabledTimes,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
  }): singleSelection = true;

  @override
  State<HoursPanel> createState() => _HoursPanelState();
}

class _HoursPanelState extends State<HoursPanel> {

  int? lastSelection;

  @override
  Widget build(BuildContext context) {
    final HoursPanel(: singleSelection) = widget;
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecione os horarios',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 16,
          children: [
            for (int i = widget.startTime; i <= widget.endTime; i++)
              ButtonHours(
                enabledTimes: widget.enabledTimes,
                label: '${i.toString().padLeft(2, '0')}:00',
                value: i,
                timeSelected: lastSelection,
                singleSelection: singleSelection,
                onHourPressed: (timeSelected){
                  
                  setState(() {
                    if (singleSelection) {
                      if (lastSelection == timeSelected) {
                        lastSelection = null;
                      }else{
                         lastSelection = timeSelected;
                      }
                    }  
                  });

                  widget.onHourPressed(timeSelected);
                },
              )
          ],
        ),
      ],
    );
  }
}

class ButtonHours extends StatefulWidget {
  final String label;
  final int value;
  final ValueChanged<int> onHourPressed;
  final List<int>? enabledTimes;
  final bool singleSelection;
  final int? timeSelected;

  const ButtonHours({
    super.key,
    this.enabledTimes,
    required this.label,
    required this.value,
    required this.onHourPressed,
    required this.singleSelection,
    required this.timeSelected,
  });

  @override
  State<ButtonHours> createState() => _ButtonHoursState();
}

class _ButtonHoursState extends State<ButtonHours> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    final ButtonHours(:value, :label, :enabledTimes, :onHourPressed, :singleSelection, :timeSelected) = widget;
    
    if (singleSelection) {
      if (timeSelected != null ) {
        if (timeSelected == value) {
          selected = true;
        }else{
          selected = false;
        }
      }  
    }




    final textColor = selected ? Colors.white : ColorsConstants.grey;
    var buttonColor = selected ? ColorsConstants.brow : Colors.white;
    final buttonBorderColor = selected ? Colors.white : ColorsConstants.grey;
    final disableTime = enabledTimes != null && !enabledTimes.contains(value);

    if (disableTime) {
      buttonColor = Colors.grey[400]!;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: disableTime
          ? null
          : () {
              
              setState(() {
                selected = !selected;
                onHourPressed(value);
              });
            },
      child: Container(
        padding: const EdgeInsets.all(5),
        width: 64,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: buttonColor,
          border: Border.all(
            color: buttonBorderColor,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

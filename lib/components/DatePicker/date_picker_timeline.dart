library date_picker_timeline;


import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:stress_app/components/DatePicker/gestures/tap.dart';

import 'date_widget.dart';
import 'extra/color.dart';
import 'extra/style.dart';

class DatePickerTimeline extends StatefulWidget {
  double width;
  double height;

  TextStyle monthTextStyle, dayTextStyle, dateTextStyle;
  Color selectionColor;
  DateTime currentDate;
  DateChangeListener onDateChange;
  String locale;
  List<DateTime> dates;

  // Creates the DatePickerTimeline Widget
  DatePickerTimeline({
    Key key,
    this.currentDate = null,
    this.width,
    this.height = 80,
    this.monthTextStyle = defaultMonthTextStyle,
    this.dayTextStyle = defaultDayTextStyle,
    this.dateTextStyle = defaultDateTextStyle,
    this.selectionColor = AppColors.defaultSelectionColor,
    this.onDateChange,
    this.dates,
    this.locale = "en_US",
  }) : super(key: key){
    currentDate = (currentDate==null)? (dates.length>0)? dates[0] : DateTime.now(): currentDate;
    dates.sort((a,b) => a.compareTo(b));
  }

  @override
  State<StatefulWidget> createState() => new _DatePickerState();
}

class _DatePickerState extends State<DatePickerTimeline> {

  @override void initState() {
    super.initState();

    initializeDateFormatting(widget.locale, null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: createlistView(),
    );
  }

  ListView createlistView(){

    return ListView.builder(
      itemCount: widget.dates.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        // Return the Date Widget
        DateTime _date = widget.dates[index];
        DateTime date = new DateTime(_date.year, _date.month, _date.day);
        bool isSelected = compareDate(date, widget.currentDate);

        return DateWidget(
          date: date,
          monthTextStyle: widget.monthTextStyle,
          dateTextStyle: widget.dateTextStyle,
          dayTextStyle: widget.dayTextStyle,
          locale: widget.locale,
          selectionColor:
          isSelected ? widget.selectionColor : Colors.transparent,
          onDateSelected: (selectedDate) {
            // A date is selected
            if (widget.onDateChange != null) {
              widget.onDateChange(selectedDate);
            }
            setState(() {
              widget.currentDate = selectedDate;
            });
          },
        );
      },
    );
  }

  bool compareDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }
}

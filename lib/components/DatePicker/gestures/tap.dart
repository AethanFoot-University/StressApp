import 'package:stress_app/components/DatePicker/date_picker_timeline.dart';
import 'package:stress_app/screens/graph_view/date_picker.dart';

/// Signature for a function that detects when a tap is occurred.
///
/// Used by [DatePickerTimeline] for tap detection.
typedef DateSelectionCallback = void Function(DateTime selectedDate);

/// Signature for a function that is called when selected date is changed
///
/// Used by [DatePickerTimeline] for tap detection.
typedef DateChangeListener = void Function(DateTime selectedDate, DatePickerTimeline picker);

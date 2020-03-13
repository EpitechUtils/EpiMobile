part of calendar;

/// All day appointment views default height
const double _kAllDayLayoutHeight = 60;

//// All day appointment height
const double _kAllDayAppointmentHeight = 20;

/// Contains options to customize the time slots in calendar
///
/// ```dart
///Widget build(BuildContext context) {
///    return Container(
///      child: SfCalendar(
///        view: CalendarView.workWeek,
///        timeSlotViewSettings: TimeSlotViewSettings(
///            startHour: 10,
///            endHour: 20,
///            nonWorkingDays: <int>[
///              DateTime.saturday,
///              DateTime.sunday,
///              DateTime.friday
///            ],
///            timeInterval: Duration(minutes: 120),
///            timeIntervalHeight: 80,
///            timeFormat: 'h:mm',
///            dateFormat: 'd',
///            dayFormat: 'EEE',
///            timeRulerSize: 70),
///      ),
///    );
///  }
/// ```
class TimeSlotViewSettings {
  TimeSlotViewSettings(
      {this.startHour = 0,
      this.endHour = 24,
      this.nonWorkingDays = const <int>[DateTime.saturday, DateTime.sunday],
      this.timeFormat = 'h a',
      this.timeInterval = const Duration(minutes: 60),
      this.timeIntervalHeight = 40,
      this.timelineAppointmentHeight = 60,
      this.minimumAppointmentDuration,
      this.dateFormat = 'd',
      this.dayFormat = 'EE',
      this.timeRulerSize = -1,
      this.timeTextStyle});

  /// The start hour value for the day/week/workweek and time line view of calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.workWeek,
  ///        timeSlotViewSettings: TimeSlotViewSettings(
  ///            startHour: 10,
  ///            endHour: 20,
  ///            nonWorkingDays: <int>[
  ///              DateTime.saturday,
  ///              DateTime.sunday,
  ///              DateTime.friday
  ///            ],
  ///            timeInterval: Duration(minutes: 120),
  ///            timeIntervalHeight: 80,
  ///            timeFormat: 'h:mm',
  ///            dateFormat: 'd',
  ///            dayFormat: 'EEE',
  ///            timeRulerSize: 70),
  ///      ),
  ///    );
  ///  }
  /// ```
  final double startHour;

  /// The end hour value of the day/week/workweek and timeline view of month view
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.workWeek,
  ///        timeSlotViewSettings: TimeSlotViewSettings(
  ///            startHour: 10,
  ///            endHour: 20,
  ///            nonWorkingDays: <int>[
  ///              DateTime.saturday,
  ///              DateTime.sunday,
  ///              DateTime.friday
  ///            ],
  ///            timeInterval: Duration(minutes: 120),
  ///            timeIntervalHeight: 80,
  ///            timeFormat: 'h:mm',
  ///            dateFormat: 'd',
  ///            dayFormat: 'EEE',
  ///            timeRulerSize: 70),
  ///      ),
  ///    );
  ///  }
  /// ```
  final double endHour;

  /// The non working days in the work week of the calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.workWeek,
  ///        timeSlotViewSettings: TimeSlotViewSettings(
  ///            startHour: 10,
  ///            endHour: 20,
  ///            nonWorkingDays: <int>[
  ///              DateTime.saturday,
  ///              DateTime.sunday,
  ///              DateTime.friday
  ///            ],
  ///            timeInterval: Duration(minutes: 120),
  ///            timeIntervalHeight: 80,
  ///            timeFormat: 'h:mm',
  ///            dateFormat: 'd',
  ///            dayFormat: 'EEE',
  ///            timeRulerSize: 70),
  ///      ),
  ///    );
  ///  }
  /// ```
  final List<int> nonWorkingDays;

  /// The time interval value for the time slots of calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.workWeek,
  ///        timeSlotViewSettings: TimeSlotViewSettings(
  ///            startHour: 10,
  ///            endHour: 20,
  ///            nonWorkingDays: <int>[
  ///              DateTime.saturday,
  ///              DateTime.sunday,
  ///              DateTime.friday
  ///            ],
  ///            timeInterval: Duration(minutes: 120),
  ///            timeIntervalHeight: 80,
  ///            timeFormat: 'h:mm',
  ///            dateFormat: 'd',
  ///            dayFormat: 'EEE',
  ///            timeRulerSize: 70),
  ///      ),
  ///    );
  ///  }
  /// ```
  final Duration timeInterval;

  /// The time interval height value of the time slots in calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.workWeek,
  ///        timeSlotViewSettings: TimeSlotViewSettings(
  ///            startHour: 10,
  ///            endHour: 20,
  ///            nonWorkingDays: <int>[
  ///              DateTime.saturday,
  ///              DateTime.sunday,
  ///              DateTime.friday
  ///            ],
  ///            timeInterval: Duration(minutes: 120),
  ///            timeIntervalHeight: 80,
  ///            timeFormat: 'h:mm',
  ///            dateFormat: 'd',
  ///            dayFormat: 'EEE',
  ///            timeRulerSize: 70),
  ///      ),
  ///    );
  ///  }
  /// ```
  final double timeIntervalHeight;

  /// The time format of the time label in time slots of month view
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.workWeek,
  ///        timeSlotViewSettings: TimeSlotViewSettings(
  ///            startHour: 10,
  ///            endHour: 20,
  ///            nonWorkingDays: <int>[
  ///              DateTime.saturday,
  ///              DateTime.sunday,
  ///              DateTime.friday
  ///            ],
  ///            timeInterval: Duration(minutes: 120),
  ///            timeIntervalHeight: 80,
  ///            timeFormat: 'h:mm',
  ///            dateFormat: 'd',
  ///            dayFormat: 'EEE',
  ///            timeRulerSize: 70),
  ///      ),
  ///    );
  ///  }
  /// ```
  final String timeFormat;

  /// The height of an appointment in time line view of calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.timelineWeek,
  ///        timeSlotViewSettings: TimeSlotViewSettings(
  ///            startHour: 10,
  ///            endHour: 20,
  ///            nonWorkingDays: <int>[
  ///              DateTime.saturday,
  ///              DateTime.sunday,
  ///              DateTime.friday
  ///            ],
  ///            timeInterval: Duration(minutes: 120),
  ///            timeIntervalHeight: 80,
  ///            timelineAppointmentHeight: 50,
  ///            timeFormat: 'h:mm',
  ///            dateFormat: 'd',
  ///            dayFormat: 'EEE',
  ///            timeRulerSize: 70),
  ///      ),
  ///    );
  ///  }
  /// ```

  final double timelineAppointmentHeight;

  /// The minimum duration duration of an appointment in time slots of calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.workWeek,
  ///        timeSlotViewSettings: TimeSlotViewSettings(
  ///            startHour: 10,
  ///            endHour: 20,
  ///            nonWorkingDays: <int>[
  ///              DateTime.saturday,
  ///              DateTime.sunday,
  ///              DateTime.friday
  ///            ],
  ///            timeInterval: Duration(minutes: 60),
  ///            minimumAppointmentDuration: Duration(minutes: 30),
  ///            timeIntervalHeight: 80,
  ///            timeFormat: 'h:mm',
  ///            dateFormat: 'd',
  ///            dayFormat: 'EEE',
  ///            timeRulerSize: 70),
  ///      ),
  ///    );
  ///  }
  /// ```
  final Duration minimumAppointmentDuration;

  /// The date format for the view header view in calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.workWeek,
  ///        timeSlotViewSettings: TimeSlotViewSettings(
  ///            startHour: 10,
  ///            endHour: 20,
  ///            nonWorkingDays: <int>[
  ///              DateTime.saturday,
  ///              DateTime.sunday,
  ///              DateTime.friday
  ///            ],
  ///            timeInterval: Duration(minutes: 120),
  ///            timeIntervalHeight: 80,
  ///            timeFormat: 'h:mm',
  ///            dateFormat: 'd',
  ///            dayFormat: 'EEE',
  ///            timeRulerSize: 70),
  ///      ),
  ///    );
  ///  }
  /// ```
  final String dateFormat;

  /// The day format for view header view of calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.workWeek,
  ///        timeSlotViewSettings: TimeSlotViewSettings(
  ///            startHour: 10,
  ///            endHour: 20,
  ///            nonWorkingDays: <int>[
  ///              DateTime.saturday,
  ///              DateTime.sunday,
  ///              DateTime.friday
  ///            ],
  ///            timeInterval: Duration(minutes: 120),
  ///            timeIntervalHeight: 80,
  ///            timeFormat: 'h:mm',
  ///            dateFormat: 'd',
  ///            dayFormat: 'EEE',
  ///            timeRulerSize: 70),
  ///      ),
  ///    );
  ///  }
  /// ```
  final String dayFormat;

  /// The time ruler width for the time slots in calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.workWeek,
  ///        timeSlotViewSettings: TimeSlotViewSettings(
  ///            startHour: 10,
  ///            endHour: 20,
  ///            nonWorkingDays: <int>[
  ///              DateTime.saturday,
  ///              DateTime.sunday,
  ///              DateTime.friday
  ///            ],
  ///            timeInterval: Duration(minutes: 120),
  ///            timeIntervalHeight: 80,
  ///            timeFormat: 'h:mm',
  ///            dateFormat: 'd',
  ///            dayFormat: 'EEE',
  ///            timeRulerSize: 70),
  ///      ),
  ///    );
  ///  }
  /// ```
  final double timeRulerSize;

  /// The text style for the time text in time slot view
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.timelineWeek,
  ///        timeSlotViewSettings: TimeSlotViewSettings(
  ///            startHour: 10,
  ///            endHour: 20,
  ///            nonWorkingDays: <int>[
  ///              DateTime.saturday,
  ///              DateTime.sunday,
  ///              DateTime.friday
  ///            ],
  ///            minimumAppointmentDuration: Duration(minutes: 30),
  ///            timeInterval: Duration(minutes: 120),
  ///            timeIntervalHeight: 80,
  ///            timeFormat: 'h:mm',
  ///            dateFormat: 'd',
  ///            dayFormat: 'EEE',
  ///            timeRulerSize: 70,
  ///            timeTextStyle: TextStyle(
  ///                fontSize: 15, fontStyle: FontStyle.italic, color: Colors.grey)),
  ///      ),
  ///    );
  ///  }
  /// ```
  final TextStyle timeTextStyle;

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final TimeSlotViewSettings otherStyle = other;
    return otherStyle.startHour == startHour &&
        otherStyle.endHour == endHour &&
        otherStyle.nonWorkingDays == nonWorkingDays &&
        otherStyle.timeInterval == timeInterval &&
        otherStyle.timeIntervalHeight == timeIntervalHeight &&
        otherStyle.timeFormat == timeFormat &&
        otherStyle.timelineAppointmentHeight == timelineAppointmentHeight &&
        otherStyle.minimumAppointmentDuration == minimumAppointmentDuration &&
        otherStyle.dateFormat == dateFormat &&
        otherStyle.dayFormat == dayFormat &&
        otherStyle.timeRulerSize == timeRulerSize &&
        otherStyle.timeTextStyle == timeTextStyle;
  }

  @override
  int get hashCode {
    return hashValues(
        startHour,
        endHour,
        nonWorkingDays,
        timeInterval,
        timeIntervalHeight,
        timeFormat,
        timelineAppointmentHeight,
        minimumAppointmentDuration,
        dateFormat,
        dayFormat,
        timeRulerSize,
        timeTextStyle);
  }
}

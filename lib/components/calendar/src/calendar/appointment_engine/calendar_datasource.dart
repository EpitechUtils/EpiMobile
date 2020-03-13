part of calendar;

/// Defines the data source of [SfCalendar] widget.
/// Calendar data source used to store the appointment related properties.
///
/// ```dart
///Widget build(BuildContext context) {
///   return Container(
///      child: SfCalendar(
///        view: CalendarView.day,
///        dataSource: _getCalendarDataSource(),
///      ),
///    );
///  }
///
/// class MeetingDataSource extends CalendarDataSource {
///  MeetingDataSource(this.source);
///  List<_Meeting> source;
///
///  @override
///  List<dynamic> get appointments => source;
///
///  @override
///  DateTime getStartTime(int index) {
///    return source[index].from;
///  }
///
///  @override
///  DateTime getEndTime(int index) {
///    return source[index].to;
///  }
///
///  @override
///  Color getColor(int index) {
///    return source[index].background;
///  }
///
///  @override
///  String getEndTimeZone(int index) {
///    return source[index].toZone;
///  }
///
///  @override
///  List<DateTime> getRecurrenceExceptionDates(int index) {
///    return source[index].exceptionDates;
///  }
///
///  @override
///  String getRecurrenceRule(int index) {
///    return source[index].recurrenceRule;
///  }
///
///  @override
///  String getStartTimeZone(int index) {
///    return source[index].fromZone;
///  }
///
///  @override
///  String getSubject(int index) {
///    return source[index].title;
///  }
///
///  @override
///  bool isAllDay(int index) {
///    return source[index].isAllDay;
///  }
/// }
///
/// class Meeting {
///  Meeting(
///      {this.from,
///      this.to,
///      this.title,
///      this.isAllDay,
///      this.background,
///      this.fromZone,
///      this.toZone,
///      this.exceptionDates,
///      this.recurrenceRule});
///
///  DateTime from;
///  DateTime to;
///  String title;
///  bool isAllDay;
///  Color background;
///  String fromZone;
///  String toZone;
///  String recurrenceRule;
///  List<DateTime> exceptionDates;
/// }
///
/// final DateTime date = DateTime.now();
///  MeetingDataSource _getCalendarDataSource() {
///    List<Meeting> appointments = <Meeting>[];
///    appointments.add(Meeting(
///     from: date,
///     to: date.add(const Duration(hours: 1)),
///     title: 'General Meeting',
///     isAllDay: false,
///     background: Colors.red,
///     fromZone: '',
///     toZone: '',
///     recurrenceRule: '',
///     exceptionDates: null
///  ));
///
///    return MeetingDataSource(appointments);
///  }
///  ```
abstract class CalendarDataSource extends CalendarDataSourceChangeNotifier {
  //// Defines the events/appointments to the calendar.
  List<dynamic> appointments;

  //// This method is used to get the appointment start time property value
  //// when custom appointment added in [CalendarDataSource].
  //// This method is mandatory to derive on subclasses.
  //// If subclasses does not derive the method then it return null value.
  @protected
  DateTime getStartTime(int index) => null;

  //// This method is used to get the appointment end time property value
  //// when custom appointment added in [CalendarDataSource].
  //// This method is mandatory to derive on subclasses.
  //// If subclasses does not derive the method then it return null value.
  @protected
  DateTime getEndTime(int index) => null;

  //// This method is used to get the appointment subject property value
  //// when custom appointment added in [CalendarDataSource].
  //// If subclasses does not derive the method then it return empty string value.
  @protected
  String getSubject(int index) => '';

  //// This method is used to get the appointment is all day property value
  //// when custom appointment added in [CalendarDataSource].
  //// If subclasses does not derive the method then it return false value.
  @protected
  bool isAllDay(int index) => false;

  //// This method is used to get the appointment color property  value
  //// when custom appointment added in [CalendarDataSource].
  //// If subclasses does not derive the method then it return light blue color value.
  @protected
  Color getColor(int index) => Colors.lightBlue;

  //// This method is used to get the appointment notes property value
  //// when custom appointment added in [CalendarDataSource].
  //// If subclasses does not derive the method then it return empty string value.
  @protected
  String getNotes(int index) => '';

  //// This method is used to get the appointment location property value
  //// when custom appointment added in [CalendarDataSource].
  //// If subclasses does not derive the method then it return empty string value.
  @protected
  String getLocation(int index) => '';

  //// This method is used to get the appointment start time zone property value
  //// when custom appointment added in [CalendarDataSource].
  //// If subclasses does not derive the method then it return empty string value.
  @protected
  String getStartTimeZone(int index) => '';

  //// This method is used to get the appointment end time zone property value
  //// when custom appointment added in [CalendarDataSource].
  //// If subclasses does not derive the method then it return empty string value.
  @protected
  String getEndTimeZone(int index) => '';

  //// This method is used to get the appointment recurrence rule property value
  //// when custom appointment added in [CalendarDataSource].
  //// If subclasses does not derive the method then it return empty string value.
  @protected
  String getRecurrenceRule(int index) => '';

  //// This method is used to get the recurrence appointment exception dates property value
  //// when custom appointment added in [CalendarDataSource].
  //// If subclasses does not derive the method then it return null value
  @protected
  List<DateTime> getRecurrenceExceptionDates(int index) => null;
}

//// Data source call back used to perform operation while data source changed.
typedef CalendarDataSourceCallback = void Function(
    CalendarDataSourceAction, List<dynamic>);

//// Data source notifier used to notify the action performed in data source
class CalendarDataSourceChangeNotifier {
  List<CalendarDataSourceCallback> _listeners;

  //// Add the listener used to call back when data source changed.
  void addListener(CalendarDataSourceCallback _listener) {
    _listeners ??= <CalendarDataSourceCallback>[];
    _listeners.add(_listener);
  }

  //// remove the listener used for notify the data source changes.
  void removeListener(CalendarDataSourceCallback _listener) {
    if (_listeners == null) {
      return;
    }

    _listeners.remove(_listener);
  }

  //// Notify to the listener while data source changed.
  void notifyListeners(CalendarDataSourceAction type, List<dynamic> data) {
    if (_listeners == null) {
      return;
    }

    for (CalendarDataSourceCallback listener in _listeners) {
      if (listener != null) {
        listener(type, data);
      }
    }
  }

  @mustCallSuper
  void dispose() {
    _listeners = null;
  }
}

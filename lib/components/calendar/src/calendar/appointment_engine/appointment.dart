part of calendar;

/// Contains properties used to create the calendar appointment.
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
/// class DataSource extends CalendarDataSource
/// {
///  DataSource(this.source);
///  List<Appointment> source;
///
///  @override
///  List<dynamic> get appointments => source;
/// }
///
/// DataSource _getCalendarDataSource() {
///    List<Appointment> appointments = <Appointment>[];
///    appointments.add(
///        Appointment(
///          startTime: DateTime.now(),
///          endTime: DateTime.now().add(
///              Duration(hours: 2)),
///          isAllDay: true,
///          subject: 'Meeting',
///          color: Colors.blue,
///          startTimeZone: '',
///          endTimeZone: ''
///        ));
///
///   return DataSource(appointments);
/// }
///  ```
class Appointment {
  Appointment({
    this.startTimeZone,
    this.endTimeZone,
    this.recurrenceRule,
    this.isAllDay = false,
    this.notes,
    this.location,
    DateTime startTime,
    DateTime endTime,
    String subject,
    Color color,
    List<DateTime> recurrenceExceptionDates,
  })  : startTime = startTime ?? DateTime.now(),
        endTime = endTime ?? DateTime.now(),
        subject = subject == null ? '' : subject,
        _actualStartTime = startTime,
        _actualEndTime = endTime,
        color = color ?? Colors.lightBlue,
        recurrenceExceptionDates = recurrenceExceptionDates ?? <DateTime>[],
        _isSpanned = false;

  /// Defines the start time of calendar appointment.
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
  /// class DataSource extends CalendarDataSource
  /// {
  ///  DataSource(this.source);
  ///  List<Appointment> source;
  ///
  ///  @override
  ///  List<dynamic> get appointments => source;
  /// }
  ///
  /// DataSource _getCalendarDataSource() {
  ///    List<Appointment> appointments = <Appointment>[];
  ///    appointments.add(
  ///        Appointment(
  ///          startTime: DateTime.now(),
  ///          endTime: DateTime.now().add(
  ///              Duration(hours: 2)),
  ///          isAllDay: true,
  ///          subject: 'Meeting',
  ///          color: Colors.blue,
  ///          startTimeZone: '',
  ///          endTimeZone: ''
  ///        ));
  ///
  ///   return DataSource(appointments);
  /// }
  ///  ```
  DateTime startTime;

  /// Defines the end time of calendar appointment.
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
  /// class DataSource extends CalendarDataSource
  /// {
  ///  DataSource(this.source);
  ///  List<Appointment> source;
  ///
  ///  @override
  ///  List<dynamic> get appointments => source;
  /// }
  ///
  /// DataSource _getCalendarDataSource() {
  ///    List<Appointment> appointments = <Appointment>[];
  ///    appointments.add(
  ///        Appointment(
  ///          startTime: DateTime.now(),
  ///          endTime: DateTime.now().add(
  ///              Duration(hours: 2)),
  ///          isAllDay: true,
  ///          subject: 'Meeting',
  ///          color: Colors.blue,
  ///          startTimeZone: '',
  ///          endTimeZone: ''
  ///        ));
  ///
  ///   return DataSource(appointments);
  /// }
  ///  ```
  DateTime endTime;

  /// Defines the appointment as all day or not.
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
  /// class DataSource extends CalendarDataSource
  /// {
  ///  DataSource(this.source);
  ///  List<Appointment> source;
  ///
  ///  @override
  ///  List<dynamic> get appointments => source;
  /// }
  ///
  /// DataSource _getCalendarDataSource() {
  ///    List<Appointment> appointments = <Appointment>[];
  ///    appointments.add(
  ///        Appointment(
  ///          startTime: DateTime.now(),
  ///          endTime: DateTime.now().add(
  ///              Duration(hours: 2)),
  ///          isAllDay: true,
  ///          subject: 'Meeting',
  ///          color: Colors.blue,
  ///          startTimeZone: '',
  ///          endTimeZone: ''
  ///        ));
  ///
  ///   return DataSource(appointments);
  /// }
  ///  ```
  bool isAllDay = false;

  /// Defines the subject of calendar appointment.
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
  /// class DataSource extends CalendarDataSource
  /// {
  ///  DataSource(this.source);
  ///  List<Appointment> source;
  ///
  ///  @override
  ///  List<dynamic> get appointments => source;
  /// }
  ///
  /// DataSource _getCalendarDataSource() {
  ///    List<Appointment> appointments = <Appointment>[];
  ///    appointments.add(
  ///        Appointment(
  ///          startTime: DateTime.now(),
  ///          endTime: DateTime.now().add(
  ///              Duration(hours: 2)),
  ///          isAllDay: true,
  ///          subject: 'Meeting',
  ///          color: Colors.blue,
  ///          startTimeZone: '',
  ///          endTimeZone: ''
  ///        ));
  ///
  ///   return DataSource(appointments);
  /// }
  ///  ```
  String subject;

  /// Defines the color of calendar appointment.
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
  /// class DataSource extends CalendarDataSource
  /// {
  ///  DataSource(this.source);
  ///  List<Appointment> source;
  ///
  ///  @override
  ///  List<dynamic> get appointments => source;
  /// }
  ///
  /// DataSource _getCalendarDataSource() {
  ///    List<Appointment> appointments = <Appointment>[];
  ///    appointments.add(
  ///        Appointment(
  ///          startTime: DateTime.now(),
  ///          endTime: DateTime.now().add(
  ///              Duration(hours: 2)),
  ///          isAllDay: true,
  ///          subject: 'Meeting',
  ///          color: Colors.blue,
  ///          startTimeZone: '',
  ///          endTimeZone: ''
  ///        ));
  ///
  ///   return DataSource(appointments);
  /// }
  ///  ```
  Color color;

  /// Defines the start date time zone of calendar appointment.
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
  /// class DataSource extends CalendarDataSource
  /// {
  ///  DataSource(this.source);
  ///  List<Appointment> source;
  ///
  ///  @override
  ///  List<dynamic> get appointments => source;
  /// }
  ///
  /// DataSource _getCalendarDataSource() {
  ///    List<Appointment> appointments = <Appointment>[];
  ///    appointments.add(
  ///        Appointment(
  ///          startTime: DateTime.now(),
  ///          endTime: DateTime.now().add(
  ///              Duration(hours: 2)),
  ///          isAllDay: true,
  ///          subject: 'Meeting',
  ///          color: Colors.blue,
  ///          startTimeZone: '',
  ///          endTimeZone: ''
  ///        ));
  ///
  ///   return DataSource(appointments);
  /// }
  ///  ```
  String startTimeZone;

  /// Defines the end date time zone of calendar appointment.
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
  /// class DataSource extends CalendarDataSource
  /// {
  ///  DataSource(this.source);
  ///  List<Appointment> source;
  ///
  ///  @override
  ///  List<dynamic> get appointments => source;
  /// }
  ///
  /// DataSource _getCalendarDataSource() {
  ///    List<Appointment> appointments = <Appointment>[];
  ///    appointments.add(
  ///        Appointment(
  ///          startTime: DateTime.now(),
  ///          endTime: DateTime.now().add(
  ///              Duration(hours: 2)),
  ///          isAllDay: true,
  ///          subject: 'Meeting',
  ///          color: Colors.blue,
  ///          startTimeZone: '',
  ///          endTimeZone: ''
  ///        ));
  ///
  ///   return DataSource(appointments);
  /// }
  ///  ```
  String endTimeZone;

  /// Defines the recurrence rule of the appointment.
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
  /// class DataSource extends CalendarDataSource
  /// {
  ///  DataSource(this.source);
  ///  List<Appointment> source;
  ///
  ///  @override
  ///  List<dynamic> get appointments => source;
  /// }
  ///
  /// DataSource _getCalendarDataSource() {
  ///    List<Appointment> appointments = <Appointment>[];
  ///    RecurrenceProperties recurrence = new RecurrenceProperties();
  ///    recurrence.recurrenceType = RecurrenceType.daily;
  ///    recurrence.interval = 2;
  ///    recurrence.recurrenceRange = RecurrenceRange.count;
  ///    recurrence.recurrenceCount = 10;
  ///    appointments.add(
  ///        Appointment(
  ///          startTime: DateTime.now(),
  ///          endTime: DateTime.now().add(
  ///              Duration(hours: 2)),
  ///          isAllDay: true,
  ///          subject: 'Meeting',
  ///          color: Colors.blue,
  ///          startTimeZone: '',
  ///          endTimeZone: '',
  ///          recurrenceRule: RecurrenceHelper.rRuleGenerator(recurrence, DateTime.now(), DateTime.now().add(
  ///              Duration(hours: 2)))
  ///        ));
  ///
  ///   return DataSource(appointments);
  /// }
  ///  ```
  String recurrenceRule;

  /// Defines the recurrence exception dates of the appointment.
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
  /// class DataSource extends CalendarDataSource
  /// {
  ///  DataSource(this.source);
  ///  List<Appointment> source;
  ///
  ///  @override
  ///  List<dynamic> get appointments => source;
  /// }
  ///
  /// DataSource _getCalendarDataSource() {
  ///    List<Appointment> appointments = <Appointment>[];
  ///    RecurrenceProperties recurrence = new RecurrenceProperties();
  ///    recurrence.recurrenceType = RecurrenceType.daily;
  ///    recurrence.interval = 2;
  ///    recurrence.recurrenceRange = RecurrenceRange.noEndDate;
  ///    recurrence.recurrenceCount = 10;
  ///    appointments.add(
  ///        Appointment(
  ///            startTime: DateTime.now(),
  ///            endTime: DateTime.now().add(
  ///                Duration(hours: 2)),
  ///            isAllDay: true,
  ///            subject: 'Meeting',
  ///            color: Colors.blue,
  ///            startTimeZone: '',
  ///            notes: '',
  ///            location: '',
  ///            endTimeZone: '',
  ///            recurrenceRule: RecurrenceHelper.rRuleGenerator(
  ///                recurrence, DateTime.now(), DateTime.now().add(
  ///                Duration(hours: 2))),
  ///            recurrenceExceptionDates: [
  ///              DateTime.now().add(Duration(days: 2))
  ///            ]
  ///        ));
  ///
  ///    return DataSource(appointments);
  ///  }
  ///  ```
  List<DateTime> recurrenceExceptionDates;

  /// Defines the notes of the appointment.
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
  /// class DataSource extends CalendarDataSource
  /// {
  ///  DataSource(this.source);
  ///  List<Appointment> source;
  ///
  ///  @override
  ///  List<dynamic> get appointments => source;
  /// }
  ///
  /// DataSource _getCalendarDataSource() {
  ///    List<Appointment> appointments = <Appointment>[];
  ///    RecurrenceProperties recurrence = new RecurrenceProperties();
  ///    recurrence.recurrenceType = RecurrenceType.daily;
  ///    recurrence.interval = 2;
  ///    recurrence.recurrenceRange = RecurrenceRange.noEndDate;
  ///    recurrence.recurrenceCount = 10;
  ///    appointments.add(
  ///        Appointment(
  ///            startTime: DateTime.now(),
  ///            endTime: DateTime.now().add(
  ///                Duration(hours: 2)),
  ///            isAllDay: true,
  ///            subject: 'Meeting',
  ///            color: Colors.blue,
  ///            startTimeZone: '',
  ///            notes: '',
  ///            location: '',
  ///            endTimeZone: '',
  ///            recurrenceRule: RecurrenceHelper.rRuleGenerator(
  ///                recurrence, DateTime.now(), DateTime.now().add(
  ///                Duration(hours: 2))),
  ///            recurrenceExceptionDates: [
  ///              DateTime.now().add(Duration(days: 2))
  ///            ]
  ///        ));
  ///
  ///    return DataSource(appointments);
  ///  }
  ///  ```
  String notes;

  /// Defines the location of the appointment.
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
  /// class DataSource extends CalendarDataSource
  /// {
  ///  DataSource(this.source);
  ///  List<Appointment> source;
  ///
  ///  @override
  ///  List<dynamic> get appointments => source;
  /// }
  ///
  /// DataSource _getCalendarDataSource() {
  ///    List<Appointment> appointments = <Appointment>[];
  ///    RecurrenceProperties recurrence = new RecurrenceProperties();
  ///    recurrence.recurrenceType = RecurrenceType.daily;
  ///    recurrence.interval = 2;
  ///    recurrence.recurrenceRange = RecurrenceRange.noEndDate;
  ///    recurrence.recurrenceCount = 10;
  ///    appointments.add(
  ///        Appointment(
  ///            startTime: DateTime.now(),
  ///            endTime: DateTime.now().add(
  ///                Duration(hours: 2)),
  ///            isAllDay: true,
  ///            subject: 'Meeting',
  ///            color: Colors.blue,
  ///            startTimeZone: '',
  ///            notes: '',
  ///            location: '',
  ///            endTimeZone: '',
  ///            recurrenceRule: RecurrenceHelper.rRuleGenerator(
  ///                recurrence, DateTime.now(), DateTime.now().add(
  ///                Duration(hours: 2))),
  ///            recurrenceExceptionDates: [
  ///              DateTime.now().add(Duration(days: 2))
  ///            ]
  ///        ));
  ///
  ///    return DataSource(appointments);
  ///  }
  ///  ```
  String location;

  //Used for referring items in ItemsSource of Schedule.
  Object _data;

  // ignore: prefer_final_fields
  DateTime _actualStartTime;

  // ignore: prefer_final_fields
  DateTime _actualEndTime;

  // ignore: prefer_final_fields
  bool _isSpanned = false;
}

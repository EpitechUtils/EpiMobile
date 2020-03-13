part of calendar;

/// Contains properties which is used to create the appointment recurrence.
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
class RecurrenceProperties {
  RecurrenceProperties(
      {RecurrenceType recurrenceType,
      int recurrenceCount,
      DateTime startDate,
      DateTime endDate,
      int interval,
      RecurrenceRange recurrenceRange,
      List<WeekDays> weekDays,
      int week,
      int dayOfMonth,
      int dayOfWeek,
      int month})
      : recurrenceType = recurrenceType ?? RecurrenceType.daily,
        recurrenceCount = recurrenceCount ?? 1,
        startDate = startDate ?? DateTime.now(),
        endDate = endDate ?? DateTime.now().add(const Duration(days: 1)),
        interval = interval ?? 1,
        recurrenceRange = recurrenceRange ?? RecurrenceRange.noEndDate,
        weekDays = weekDays ?? <WeekDays>[],
        week = week ?? -1,
        dayOfMonth = dayOfMonth ?? 1,
        dayOfWeek = dayOfWeek ?? 1,
        month = month ?? 1;

  /// Defines the recurrence type of the appointment.
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
  RecurrenceType recurrenceType;

  /// Defines the recurrence count of the appointment.
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
  int recurrenceCount;

  /// Defines the start date of the recurrence appointment.
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
  ///    recurrence.startDate = DateTime.now().add(Duration(days: 1));
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
  DateTime startDate;

  /// Defines the end date of the recurrence appointment when recurrence range as end time.
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
  ///    recurrence.endDate = DateTime.now().add(Duration(days: 10));
  ///    recurrence.recurrenceRange = RecurrenceRange.endDate;
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
  DateTime endDate;

  /// Defines the interval between the repeated appointment.
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
  ///    recurrence.endDate = DateTime.now().add(Duration(days: 10));
  ///    recurrence.recurrenceRange = RecurrenceRange.endDate;
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
  int interval;

  /// Defines the recurrence range of the appointment.
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
  ///    recurrence.endDate = DateTime.now().add(Duration(days: 10));
  ///    recurrence.recurrenceRange = RecurrenceRange.endDate;
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
  RecurrenceRange recurrenceRange;

  /// Defines the recurrence week days of the appointment when recurrence type as week.
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
  ///    List<WeekDays> days = List<WeekDays>();
  ///    days.add(WeekDays.monday);
  ///    days.add(WeekDays.wednesday);
  ///    days.add(WeekDays.friday);
  ///    days.add(WeekDays.saturday);
  ///    recurrence.weekDays = days;
  ///    recurrence.recurrenceType = RecurrenceType.weekly;
  ///    recurrence.endDate = DateTime.now().add(Duration(days: 10));
  ///    recurrence.recurrenceRange = RecurrenceRange.endDate;
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
  List<WeekDays> weekDays;

  /// Defines the week of the appointment when recurrence type as month or year.
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
  ///    recurrence.week = 4;
  ///    recurrence.recurrenceType = RecurrenceType.monthly;
  ///    recurrence.interval = 1;
  ///    recurrence.recurrenceRange = RecurrenceRange.noEndDate;
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
  int week;

  /// Defines the day of month of the appointment when recurrence type as month or year.
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
  ///    recurrence.recurrenceType = RecurrenceType.monthly;
  ///    recurrence.dayOfMonth = 15;
  ///    recurrence.interval = 1;
  ///    recurrence.recurrenceRange = RecurrenceRange.noEndDate;
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
  int dayOfMonth;

  /// Defines the day of week of the appointment when recurrence type as month or year.
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
  ///    recurrence.dayOfWeek = 7;
  ///    recurrence.week = 4;
  ///    recurrence.recurrenceType = RecurrenceType.monthly;
  ///    recurrence.interval = 1;
  ///   recurrence.recurrenceRange = RecurrenceRange.noEndDate;
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
  int dayOfWeek;

  /// Defines the month of the appointment when recurrence type as year.
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
  ///    recurrence.recurrenceType = RecurrenceType.yearly;
  ///    recurrence.dayOfMonth = 15;
  ///    recurrence.month = 12;
  ///    recurrence.interval = 1;
  ///   recurrence.recurrenceRange = RecurrenceRange.noEndDate;
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
  int month;
}

part of calendar;

/// Contains options to customize the month view of calendar
///
/// ```dart
///Widget build(BuildContext context) {
///    return Container(
///      child: SfCalendar(
///        view: CalendarView.Month,
///        monthViewSettings: MonthViewSettings(
///            dayFormat: 'EEE',
///            numberOfWeeksInView: 4,
///            appointmentDisplayCount: 2,
///            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
///            showAgenda: false,
///            navigationDirection: MonthNavigationDirection.horizontal),
///      ),
///    );
///  }
/// ```
class MonthViewSettings {
  MonthViewSettings(
      {this.appointmentDisplayCount = 4,
      this.numberOfWeeksInView = 6,
      this.appointmentDisplayMode = MonthAppointmentDisplayMode.indicator,
      this.showAgenda = false,
      this.navigationDirection = MonthNavigationDirection.horizontal,
      this.dayFormat = 'EE',
      this.agendaItemHeight = 50,
      double agendaViewHeight,
      MonthCellStyle monthCellStyle,
      AgendaStyle agendaStyle})
      : monthCellStyle = monthCellStyle ?? MonthCellStyle(),
        agendaStyle = agendaStyle ?? AgendaStyle(),
        agendaViewHeight = agendaViewHeight ?? -1;

  /// Day format for the month view header in calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.Month,
  ///        dataSource: _getCalendarDataSource(),
  ///        monthViewSettings: MonthViewSettings(
  ///            dayFormat: 'EEE',
  ///            numberOfWeeksInView: 4,
  ///            appointmentDisplayCount: 2,
  ///            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///            showAgenda: false,
  ///            navigationDirection: MonthNavigationDirection.horizontal,
  ///            monthCellStyle
  ///                : MonthCellStyle(textStyle: TextStyle(fontStyle: FontStyle.
  ///            normal, fontSize: 15, color: Colors.black),
  ///                todayTextStyle: TextStyle(fontStyle: FontStyle.italic,
  ///                    fontSize: 17,
  ///                    color: Colors.red),
  ///                trailingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                leadingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                backgroundColor: Colors.red,
  ///                todayBackgroundColor: Colors.blue,
  ///                leadingDatesBackgroundColor: Colors.grey,
  ///                trailingDatesBackgroundColor: Colors.grey)),
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
  ///  DataSource _getCalendarDataSource() {
  ///    List<Appointment> appointments = <Appointment>[];
  ///    appointments.add(Appointment(
  ///      startTime: DateTime.now(),
  ///      endTime: DateTime.now().add(Duration(hours: 2)),
  ///      isAllDay: true,
  ///      subject: 'Meeting',
  ///      color: Colors.blue,
  ///      startTimeZone: '',
  ///      endTimeZone: '',
  ///    ));
  ///
  ///    return DataSource(appointments);
  ///  }
  ///
  final String dayFormat;

  /// Appointment view height in month agenda view.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  /// return Container(
  ///    child: SfCalendar(
  ///      view: CalendarView.Month,
  ///      monthViewSettings: MonthViewSettings(
  ///          dayFormat: 'EEE',
  ///          numberOfWeeksInView: 4,
  ///          appointmentDisplayCount: 2,
  ///          agendaItemHeight: 50,
  ///          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///          showAgenda: false,
  ///          navigationDirection: MonthNavigationDirection.horizontal,
  ///          agendaStyle: AgendaStyle(
  ///              backgroundColor: Colors.transparent,
  ///             appointmentTextStyle: TextStyle(
  ///                  color: Colors.white,
  ///                  fontSize: 13,
  ///                  fontStyle: FontStyle.italic
  ///              ),
  ///              dayTextStyle: TextStyle(color: Colors.red,
  ///                  fontSize: 13,
  ///                  fontStyle: FontStyle.italic),
  ///              dateTextStyle: TextStyle(color: Colors.red,
  ///                  fontSize: 25,
  ///                  fontWeight: FontWeight.bold,
  ///                  fontStyle: FontStyle.normal)
  ///         )),
  ///      ),
  ///    );
  /// }
  /// ```
  final double agendaItemHeight;

  /// Contains options to customize the month cell of month view
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.Month,
  ///        dataSource: _getCalendarDataSource(),
  ///        monthViewSettings: MonthViewSettings(
  ///            dayFormat: 'EEE',
  ///            numberOfWeeksInView: 4,
  ///            appointmentDisplayCount: 2,
  ///            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///            showAgenda: false,
  ///            navigationDirection: MonthNavigationDirection.horizontal,
  ///            monthCellStyle
  ///                : MonthCellStyle(textStyle: TextStyle(fontStyle: FontStyle.
  ///            normal, fontSize: 15, color: Colors.black),
  ///                todayTextStyle: TextStyle(fontStyle: FontStyle.italic,
  ///                    fontSize: 17,
  ///                    color: Colors.red),
  ///                trailingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                leadingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                backgroundColor: Colors.red,
  ///                todayBackgroundColor: Colors.blue,
  ///                leadingDatesBackgroundColor: Colors.grey,
  ///                trailingDatesBackgroundColor: Colors.grey)),
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
  ///  DataSource _getCalendarDataSource() {
  ///    List<Appointment> appointments = <Appointment>[];
  ///    appointments.add(Appointment(
  ///      startTime: DateTime.now(),
  ///      endTime: DateTime.now().add(Duration(hours: 2)),
  ///      isAllDay: true,
  ///      subject: 'Meeting',
  ///      color: Colors.blue,
  ///      startTimeZone: '',
  ///      endTimeZone: '',
  ///    ));
  ///
  ///    return DataSource(appointments);
  ///  }
  ///
  final MonthCellStyle monthCellStyle;

  /// Options to customize the agenda view in month view
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  /// return Container(
  ///    child: SfCalendar(
  ///      view: CalendarView.Month,
  ///      monthViewSettings: MonthViewSettings(
  ///          dayFormat: 'EEE',
  ///          numberOfWeeksInView: 4,
  ///          appointmentDisplayCount: 2,
  ///          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///          showAgenda: false,
  ///          navigationDirection: MonthNavigationDirection.horizontal,
  ///          agendaStyle: AgendaStyle(
  ///              backgroundColor: Colors.transparent,
  ///             appointmentTextStyle: TextStyle(
  ///                  color: Colors.white,
  ///                  fontSize: 13,
  ///                  fontStyle: FontStyle.italic
  ///              ),
  ///              dayTextStyle: TextStyle(color: Colors.red,
  ///                  fontSize: 13,
  ///                  fontStyle: FontStyle.italic),
  ///              dateTextStyle: TextStyle(color: Colors.red,
  ///                  fontSize: 25,
  ///                  fontWeight: FontWeight.bold,
  ///                  fontStyle: FontStyle.normal)
  ///         )),
  ///      ),
  ///    );
  /// }
  /// ```

  final AgendaStyle agendaStyle;

  /// Number of weeks to to display in month view
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.Month,
  ///        monthViewSettings: MonthViewSettings(
  ///            dayFormat: 'EEE',
  ///            numberOfWeeksInView: 4,
  ///            appointmentDisplayCount: 2,
  ///            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///            showAgenda: false,
  ///            navigationDirection: MonthNavigationDirection.horizontal),
  ///      ),
  ///    );
  ///  }
  /// ```
  final int numberOfWeeksInView;

  /// Appointment display count in a month cell
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.Month,
  ///        monthViewSettings: MonthViewSettings(
  ///            dayFormat: 'EEE',
  ///            numberOfWeeksInView: 4,
  ///            appointmentDisplayCount: 2,
  ///            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///            showAgenda: false,
  ///            navigationDirection: MonthNavigationDirection.horizontal),
  ///      ),
  ///    );
  ///  }
  /// ```
  final int appointmentDisplayCount;

  /// Appointment display mode for month view of calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.Month,
  ///        monthViewSettings: MonthViewSettings(
  ///            dayFormat: 'EEE',
  ///            numberOfWeeksInView: 4,
  ///            appointmentDisplayCount: 2,
  ///            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///            showAgenda: false,
  ///            navigationDirection: MonthNavigationDirection.horizontal),
  ///      ),
  ///    );
  ///  }
  /// ```
  final MonthAppointmentDisplayMode appointmentDisplayMode;

  /// Enables or disables the agenda view in month view of calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.Month,
  ///        monthViewSettings: MonthViewSettings(
  ///            dayFormat: 'EEE',
  ///            numberOfWeeksInView: 4,
  ///            appointmentDisplayCount: 2,
  ///            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///            showAgenda: true,
  ///            navigationDirection: MonthNavigationDirection.horizontal),
  ///      ),
  ///    );
  ///  }
  /// ```
  final bool showAgenda;

  /// The height of the agenda view in month view of calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.Month,
  ///        monthViewSettings: MonthViewSettings(
  ///            dayFormat: 'EEE',
  ///            numberOfWeeksInView: 4,
  ///            appointmentDisplayCount: 2,
  ///            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///            showAgenda: true,
  ///            agendaViewHeight: 120,
  ///            navigationDirection: MonthNavigationDirection.horizontal),
  ///      ),
  ///    );
  ///  }
  /// ```
  final double agendaViewHeight;

  /// The navigation direction of month view in calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.Month,
  ///        monthViewSettings: MonthViewSettings(
  ///            dayFormat: 'EEE',
  ///            numberOfWeeksInView: 4,
  ///            appointmentDisplayCount: 2,
  ///            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///            showAgenda: false,
  ///            navigationDirection: MonthNavigationDirection.horizontal),
  ///      ),
  ///    );
  ///  }
  /// ```
  final MonthNavigationDirection navigationDirection;

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final MonthViewSettings otherStyle = other;
    return otherStyle.dayFormat == dayFormat &&
        otherStyle.monthCellStyle == monthCellStyle &&
        otherStyle.agendaStyle == agendaStyle &&
        otherStyle.numberOfWeeksInView == numberOfWeeksInView &&
        otherStyle.appointmentDisplayCount == appointmentDisplayCount &&
        otherStyle.appointmentDisplayMode == appointmentDisplayMode &&
        otherStyle.agendaItemHeight == agendaItemHeight &&
        otherStyle.showAgenda == showAgenda &&
        otherStyle.agendaViewHeight == agendaViewHeight &&
        otherStyle.navigationDirection == navigationDirection;
  }

  @override
  int get hashCode {
    return hashValues(
      dayFormat,
      monthCellStyle,
      agendaStyle,
      numberOfWeeksInView,
      appointmentDisplayCount,
      appointmentDisplayMode,
      showAgenda,
      agendaViewHeight,
      agendaItemHeight,
      navigationDirection,
    );
  }
}

/// Options to customize the agenda view in month view
///
/// ```dart
/// Widget build(BuildContext context) {
/// return Container(
///    child: SfCalendar(
///      view: CalendarView.Month,
///      monthViewSettings: MonthViewSettings(
///          dayFormat: 'EEE',
///          numberOfWeeksInView: 4,
///          appointmentDisplayCount: 2,
///          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
///          showAgenda: true,
///          navigationDirection: MonthNavigationDirection.horizontal,
///          agendaStyle: AgendaStyle(
///              backgroundColor: Colors.transparent,
///             appointmentTextStyle: TextStyle(
///                  color: Colors.white,
///                  fontSize: 13,
///                  fontStyle: FontStyle.italic
///              ),
///              dayTextStyle: TextStyle(color: Colors.red,
///                  fontSize: 13,
///                  fontStyle: FontStyle.italic),
///              dateTextStyle: TextStyle(color: Colors.red,
///                  fontSize: 25,
///                  fontWeight: FontWeight.bold,
///                  fontStyle: FontStyle.normal)
///         )),
///      ),
///    );
/// }
/// ```

class AgendaStyle {
  AgendaStyle(
      {this.appointmentTextStyle,
      this.dayTextStyle,
      this.dateTextStyle,
      this.backgroundColor = Colors.transparent});

  /// Text size for appointment in agenda view of month view
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  /// return Container(
  ///    child: SfCalendar(
  ///      view: CalendarView.Month,
  ///      monthViewSettings: MonthViewSettings(
  ///          dayFormat: 'EEE',
  ///          numberOfWeeksInView: 4,
  ///          appointmentDisplayCount: 2,
  ///          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///          showAgenda: true,
  ///          navigationDirection: MonthNavigationDirection.horizontal,
  ///          agendaStyle: AgendaStyle(
  ///              backgroundColor: Colors.transparent,
  ///             appointmentTextStyle: TextStyle(
  ///                  color: Colors.white,
  ///                  fontSize: 13,
  ///                  fontStyle: FontStyle.italic
  ///              ),
  ///              dayTextStyle: TextStyle(color: Colors.red,
  ///                  fontSize: 13,
  ///                  fontStyle: FontStyle.italic),
  ///              dateTextStyle: TextStyle(color: Colors.red,
  ///                  fontSize: 25,
  ///                  fontWeight: FontWeight.bold,
  ///                  fontStyle: FontStyle.normal)
  ///         )),
  ///      ),
  ///    );
  /// }
  /// ```
  final TextStyle appointmentTextStyle;

  /// The day label size in agenda view of month view
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  /// return Container(
  ///    child: SfCalendar(
  ///      view: CalendarView.Month,
  ///      monthViewSettings: MonthViewSettings(
  ///          dayFormat: 'EEE',
  ///          numberOfWeeksInView: 4,
  ///          appointmentDisplayCount: 2,
  ///          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///          showAgenda: true,
  ///          navigationDirection: MonthNavigationDirection.horizontal,
  ///          agendaStyle: AgendaStyle(
  ///              backgroundColor: Colors.transparent,
  ///             appointmentTextStyle: TextStyle(
  ///                  color: Colors.white,
  ///                  fontSize: 13,
  ///                  fontStyle: FontStyle.italic
  ///              ),
  ///              dayTextStyle: TextStyle(color: Colors.red,
  ///                  fontSize: 13,
  ///                  fontStyle: FontStyle.italic),
  ///              dateTextStyle: TextStyle(color: Colors.red,
  ///                  fontSize: 25,
  ///                  fontWeight: FontWeight.bold,
  ///                  fontStyle: FontStyle.normal)
  ///         )),
  ///      ),
  ///    );
  /// }
  /// ```
  final TextStyle dayTextStyle;

  /// The date label size for agenda view of month view
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  /// return Container(
  ///    child: SfCalendar(
  ///      view: CalendarView.Month,
  ///      monthViewSettings: MonthViewSettings(
  ///          dayFormat: 'EEE',
  ///          numberOfWeeksInView: 4,
  ///          appointmentDisplayCount: 2,
  ///          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///          showAgenda: true,
  ///          navigationDirection: MonthNavigationDirection.horizontal,
  ///          agendaStyle: AgendaStyle(
  ///              backgroundColor: Colors.transparent,
  ///             appointmentTextStyle: TextStyle(
  ///                  color: Colors.white,
  ///                  fontSize: 13,
  ///                  fontStyle: FontStyle.italic
  ///              ),
  ///              dayTextStyle: TextStyle(color: Colors.red,
  ///                  fontSize: 13,
  ///                  fontStyle: FontStyle.italic),
  ///              dateTextStyle: TextStyle(color: Colors.red,
  ///                  fontSize: 25,
  ///                  fontWeight: FontWeight.bold,
  ///                  fontStyle: FontStyle.normal)
  ///         )),
  ///      ),
  ///    );
  /// }
  /// ```
  final TextStyle dateTextStyle;

  /// The background color for the agenda view
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  /// return Container(
  ///    child: SfCalendar(
  ///      view: CalendarView.Month,
  ///      monthViewSettings: MonthViewSettings(
  ///          dayFormat: 'EEE',
  ///          numberOfWeeksInView: 4,
  ///          appointmentDisplayCount: 2,
  ///          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///          showAgenda: true,
  ///          navigationDirection: MonthNavigationDirection.horizontal,
  ///          agendaStyle: AgendaStyle(
  ///              backgroundColor: Colors.transparent,
  ///             appointmentTextStyle: TextStyle(
  ///                  color: Colors.white,
  ///                  fontSize: 13,
  ///                  fontStyle: FontStyle.italic
  ///              ),
  ///              dayTextStyle: TextStyle(color: Colors.red,
  ///                  fontSize: 13,
  ///                  fontStyle: FontStyle.italic),
  ///              dateTextStyle: TextStyle(color: Colors.red,
  ///                  fontSize: 25,
  ///                  fontWeight: FontWeight.bold,
  ///                  fontStyle: FontStyle.normal)
  ///         )),
  ///      ),
  ///    );
  /// }
  ///```
  final Color backgroundColor;

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AgendaStyle otherStyle = other;
    return otherStyle.appointmentTextStyle == appointmentTextStyle &&
        otherStyle.dayTextStyle == dayTextStyle &&
        otherStyle.dateTextStyle == dateTextStyle &&
        otherStyle.backgroundColor == backgroundColor;
  }

  @override
  int get hashCode {
    return hashValues(
      appointmentTextStyle,
      dayTextStyle,
      dateTextStyle,
      backgroundColor,
    );
  }
}

/// Contains options to customize the month cell of month view
///
/// ```dart
///Widget build(BuildContext context) {
///    return Container(
///      child: SfCalendar(
///        view: CalendarView.Month,
///        dataSource: _getCalendarDataSource(),
///        monthViewSettings: MonthViewSettings(
///            dayFormat: 'EEE',
///            numberOfWeeksInView: 4,
///            appointmentDisplayCount: 2,
///            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
///            showAgenda: false,
///            navigationDirection: MonthNavigationDirection.horizontal,
///            monthCellStyle
///                : MonthCellStyle(textStyle: TextStyle(fontStyle: FontStyle.
///            normal, fontSize: 15, color: Colors.black),
///                todayTextStyle: TextStyle(fontStyle: FontStyle.italic,
///                    fontSize: 17,
///                    color: Colors.red),
///                trailingDatesTextStyle: TextStyle(
///                    fontStyle: FontStyle.normal,
///                    fontSize: 15,
///                    color: Colors.black),
///                leadingDatesTextStyle: TextStyle(
///                    fontStyle: FontStyle.normal,
///                    fontSize: 15,
///                    color: Colors.black),
///                backgroundColor: Colors.red,
///                todayBackgroundColor: Colors.blue,
///                leadingDatesBackgroundColor: Colors.grey,
///                trailingDatesBackgroundColor: Colors.grey)),
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
///  DataSource _getCalendarDataSource() {
///    List<Appointment> appointments = <Appointment>[];
///    appointments.add(Appointment(
///      startTime: DateTime.now(),
///      endTime: DateTime.now().add(Duration(hours: 2)),
///      isAllDay: true,
///      subject: 'Meeting',
///      color: Colors.blue,
///      startTimeZone: '',
///      endTimeZone: '',
///    ));
///
///    return DataSource(appointments);
///  }
///
class MonthCellStyle {
  MonthCellStyle({
    this.backgroundColor = Colors.transparent,
    this.todayBackgroundColor = Colors.transparent,
    this.trailingDatesBackgroundColor = Colors.transparent,
    this.leadingDatesBackgroundColor = Colors.transparent,
    this.textStyle,
    TextStyle todayTextStyle,
    this.trailingDatesTextStyle,
    this.leadingDatesTextStyle,
  }) : todayTextStyle = todayTextStyle ??
            const TextStyle(
                fontSize: 13,
                fontFamily: 'Roboto',
                color: Color.fromARGB(255, 255, 255, 255));

  /// Text style for the month cell in month view
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.Month,
  ///        monthViewSettings: MonthViewSettings(
  ///            dayFormat: 'EEE',
  ///            numberOfWeeksInView: 4,
  ///            appointmentDisplayCount: 2,
  ///            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///            showAgenda: false,
  ///            navigationDirection: MonthNavigationDirection.horizontal,
  ///            monthCellStyle
  ///                : MonthCellStyle(textStyle: TextStyle(fontStyle: FontStyle.
  ///            normal, fontSize: 15, color: Colors.black),
  ///                todayTextStyle: TextStyle(fontStyle: FontStyle.italic,
  ///                    fontSize: 17,
  ///                    color: Colors.red),
  ///                trailingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                leadingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                backgroundColor: Colors.red,
  ///                todayBackgroundColor: Colors.blue,
  ///                leadingDatesBackgroundColor: Colors.grey,
  ///                trailingDatesBackgroundColor: Colors.grey)),
  ///      ),
  ///    );
  ///  }
  /// ```
  final TextStyle textStyle;

  /// Text style for the today month cell in month view
  ///
  /// Text style for the month cell in month view
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.Month,
  ///        monthViewSettings: MonthViewSettings(
  ///            dayFormat: 'EEE',
  ///            numberOfWeeksInView: 4,
  ///            appointmentDisplayCount: 2,
  ///            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///            showAgenda: false,
  ///            navigationDirection: MonthNavigationDirection.horizontal,
  ///            monthCellStyle
  ///                : MonthCellStyle(textStyle: TextStyle(fontStyle: FontStyle.
  ///            normal, fontSize: 15, color: Colors.black),
  ///                todayTextStyle: TextStyle(fontStyle: FontStyle.italic,
  ///                    fontSize: 17,
  ///                    color: Colors.red),
  ///                trailingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                leadingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                backgroundColor: Colors.red,
  ///                todayBackgroundColor: Colors.blue,
  ///                leadingDatesBackgroundColor: Colors.grey,
  ///                trailingDatesBackgroundColor: Colors.grey)),
  ///      ),
  ///    );
  ///  }
  /// ```
  final TextStyle todayTextStyle;

  /// Text style for previous month cells in month view
  ///
  /// Text style for the month cell in month view
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.Month,
  ///        monthViewSettings: MonthViewSettings(
  ///            dayFormat: 'EEE',
  ///            numberOfWeeksInView: 4,
  ///            appointmentDisplayCount: 2,
  ///            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///            showAgenda: false,
  ///            navigationDirection: MonthNavigationDirection.horizontal,
  ///            monthCellStyle
  ///                : MonthCellStyle(textStyle: TextStyle(fontStyle: FontStyle.
  ///            normal, fontSize: 15, color: Colors.black),
  ///                todayTextStyle: TextStyle(fontStyle: FontStyle.italic,
  ///                    fontSize: 17,
  ///                    color: Colors.red),
  ///                trailingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                leadingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                backgroundColor: Colors.red,
  ///                todayBackgroundColor: Colors.blue,
  ///                leadingDatesBackgroundColor: Colors.grey,
  ///                trailingDatesBackgroundColor: Colors.grey)),
  ///      ),
  ///    );
  ///  }
  /// ```
  final TextStyle trailingDatesTextStyle;

  /// Text style for next month cells in month view
  ///
  /// Text style for the month cell in month view
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.Month,
  ///        monthViewSettings: MonthViewSettings(
  ///            dayFormat: 'EEE',
  ///            numberOfWeeksInView: 4,
  ///            appointmentDisplayCount: 2,
  ///            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///            showAgenda: false,
  ///            navigationDirection: MonthNavigationDirection.horizontal,
  ///            monthCellStyle
  ///                : MonthCellStyle(textStyle: TextStyle(fontStyle: FontStyle.
  ///            normal, fontSize: 15, color: Colors.black),
  ///                todayTextStyle: TextStyle(fontStyle: FontStyle.italic,
  ///                    fontSize: 17,
  ///                    color: Colors.red),
  ///                trailingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                leadingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                backgroundColor: Colors.red,
  ///                todayBackgroundColor: Colors.blue,
  ///                leadingDatesBackgroundColor: Colors.grey,
  ///                trailingDatesBackgroundColor: Colors.grey)),
  ///      ),
  ///    );
  ///  }
  /// ```
  final TextStyle leadingDatesTextStyle;

  /// Background color for month cells in month view
  ///
  /// Text style for the month cell in month view
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.Month,
  ///        monthViewSettings: MonthViewSettings(
  ///            dayFormat: 'EEE',
  ///            numberOfWeeksInView: 4,
  ///            appointmentDisplayCount: 2,
  ///            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///            showAgenda: false,
  ///            navigationDirection: MonthNavigationDirection.horizontal,
  ///            monthCellStyle
  ///                : MonthCellStyle(textStyle: TextStyle(fontStyle: FontStyle.
  ///            normal, fontSize: 15, color: Colors.black),
  ///                todayTextStyle: TextStyle(fontStyle: FontStyle.italic,
  ///                    fontSize: 17,
  ///                    color: Colors.red),
  ///                trailingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                leadingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                backgroundColor: Colors.red,
  ///                todayBackgroundColor: Colors.blue,
  ///                leadingDatesBackgroundColor: Colors.grey,
  ///                trailingDatesBackgroundColor: Colors.grey)),
  ///      ),
  ///    );
  ///  }
  /// ```
  final Color backgroundColor;

  /// Today cell background color for month view
  ///
  /// Text style for the month cell in month view
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.Month,
  ///        monthViewSettings: MonthViewSettings(
  ///            dayFormat: 'EEE',
  ///            numberOfWeeksInView: 4,
  ///            appointmentDisplayCount: 2,
  ///            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///            showAgenda: false,
  ///            navigationDirection: MonthNavigationDirection.horizontal,
  ///            monthCellStyle
  ///                : MonthCellStyle(textStyle: TextStyle(fontStyle: FontStyle.
  ///            normal, fontSize: 15, color: Colors.black),
  ///                todayTextStyle: TextStyle(fontStyle: FontStyle.italic,
  ///                    fontSize: 17,
  ///                    color: Colors.red),
  ///                trailingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                leadingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                backgroundColor: Colors.red,
  ///                todayBackgroundColor: Colors.blue,
  ///                leadingDatesBackgroundColor: Colors.grey,
  ///                trailingDatesBackgroundColor: Colors.grey)),
  ///      ),
  ///    );
  ///  }
  /// ```
  final Color todayBackgroundColor;

  /// Background color for previous month cells in month view
  ///
  /// Text style for the month cell in month view
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.Month,
  ///        monthViewSettings: MonthViewSettings(
  ///            dayFormat: 'EEE',
  ///            numberOfWeeksInView: 4,
  ///            appointmentDisplayCount: 2,
  ///            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///            showAgenda: false,
  ///            navigationDirection: MonthNavigationDirection.horizontal,
  ///            monthCellStyle
  ///                : MonthCellStyle(textStyle: TextStyle(fontStyle: FontStyle.
  ///            normal, fontSize: 15, color: Colors.black),
  ///                todayTextStyle: TextStyle(fontStyle: FontStyle.italic,
  ///                    fontSize: 17,
  ///                    color: Colors.red),
  ///                trailingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                leadingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                backgroundColor: Colors.red,
  ///                todayBackgroundColor: Colors.blue,
  ///                leadingDatesBackgroundColor: Colors.grey,
  ///                trailingDatesBackgroundColor: Colors.grey)),
  ///      ),
  ///    );
  ///  }
  /// ```
  final Color trailingDatesBackgroundColor;

  /// Background color for next month cells in month view
  ///
  /// Text style for the month cell in month view
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.Month,
  ///        monthViewSettings: MonthViewSettings(
  ///            dayFormat: 'EEE',
  ///            numberOfWeeksInView: 4,
  ///            appointmentDisplayCount: 2,
  ///            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
  ///            showAgenda: false,
  ///            navigationDirection: MonthNavigationDirection.horizontal,
  ///            monthCellStyle
  ///                : MonthCellStyle(textStyle: TextStyle(fontStyle: FontStyle.
  ///            normal, fontSize: 15, color: Colors.black),
  ///                todayTextStyle: TextStyle(fontStyle: FontStyle.italic,
  ///                    fontSize: 17,
  ///                    color: Colors.red),
  ///                trailingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                leadingDatesTextStyle: TextStyle(
  ///                    fontStyle: FontStyle.normal,
  ///                    fontSize: 15,
  ///                    color: Colors.black),
  ///                backgroundColor: Colors.red,
  ///                todayBackgroundColor: Colors.blue,
  ///                leadingDatesBackgroundColor: Colors.grey,
  ///                trailingDatesBackgroundColor: Colors.grey)),
  ///      ),
  ///    );
  ///  }
  /// ```
  final Color leadingDatesBackgroundColor;

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final MonthCellStyle otherStyle = other;
    return otherStyle.textStyle == textStyle &&
        otherStyle.todayTextStyle == todayTextStyle &&
        otherStyle.trailingDatesTextStyle == trailingDatesTextStyle &&
        otherStyle.leadingDatesTextStyle == leadingDatesTextStyle &&
        otherStyle.backgroundColor == backgroundColor &&
        otherStyle.todayBackgroundColor == todayBackgroundColor &&
        otherStyle.trailingDatesBackgroundColor ==
            trailingDatesBackgroundColor &&
        otherStyle.leadingDatesBackgroundColor == leadingDatesBackgroundColor;
  }

  @override
  int get hashCode {
    return hashValues(
      textStyle,
      todayTextStyle,
      trailingDatesTextStyle,
      leadingDatesTextStyle,
      backgroundColor,
      todayBackgroundColor,
      trailingDatesBackgroundColor,
      leadingDatesBackgroundColor,
    );
  }
}

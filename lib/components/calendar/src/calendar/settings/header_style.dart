part of calendar;

/// Contains options to customize the header view of calendar
///
/// ```dart
///Widget build(BuildContext context) {
///  return Container(
///  child: SfCalendar(
///      view: CalendarView.week,
///      headerStyle: CalendarHeaderStyle(
///          textStyle: TextStyle(color: Colors.red, fontSize: 20),
///          textAlign: TextAlign.center,
///          backgroundColor: Colors.blue),
///    ),
///  );
///}
/// ```
class CalendarHeaderStyle {
  CalendarHeaderStyle(
      {this.textAlign = TextAlign.left,
      this.backgroundColor = Colors.transparent,
      this.textStyle});

  /// Text style to customize the text in the header view of calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///  return Container(
  ///  child: SfCalendar(
  ///      view: CalendarView.week,
  ///      headerStyle: CalendarHeaderStyle(
  ///          textStyle: TextStyle(color: Colors.red, fontSize: 20),
  ///          textAlign: TextAlign.center,
  ///          backgroundColor: Colors.blue),
  ///    ),
  ///  );
  ///}
  /// ```
  final TextStyle textStyle;

  /// To align the text in the header view of calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///  return Container(
  ///  child: SfCalendar(
  ///      view: CalendarView.week,
  ///      headerStyle: CalendarHeaderStyle(
  ///          textStyle: TextStyle(color: Colors.red, fontSize: 20),
  ///          textAlign: TextAlign.center,
  ///          backgroundColor: Colors.blue),
  ///    ),
  ///  );
  ///}
  /// ```
  final TextAlign textAlign;

  /// To customize the background color of the header view in calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///  return Container(
  ///  child: SfCalendar(
  ///      view: CalendarView.week,
  ///      headerStyle: CalendarHeaderStyle(
  ///          textStyle: TextStyle(color: Colors.red, fontSize: 20),
  ///          textAlign: TextAlign.center,
  ///          backgroundColor: Colors.blue),
  ///    ),
  ///  );
  ///}
  /// ```
  final Color backgroundColor;

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final CalendarHeaderStyle otherStyle = other;
    return otherStyle.textStyle == textStyle &&
        otherStyle.textAlign == textAlign &&
        otherStyle.backgroundColor == backgroundColor;
  }

  @override
  int get hashCode {
    return hashValues(
      textStyle,
      textAlign,
      backgroundColor,
    );
  }
}

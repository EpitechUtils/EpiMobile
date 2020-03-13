part of calendar;

/// Contains options to customize the view header view of calendar
///
/// ```dart
///Widget build(BuildContext context) {
///    return Container(
///      child: SfCalendar(
///        view: CalendarView.week,
///        viewHeaderStyle: ViewHeaderStyle(
///            backgroundColor: Colors.blue,
///            dayTextStyle: TextStyle(color: Colors.grey, fontSize: 20),
///            dateTextStyle: TextStyle(color: Colors.grey, fontSize: 25)),
///      ),
///    );
///  }
/// ```
class ViewHeaderStyle {
  ViewHeaderStyle(
      {this.backgroundColor = Colors.transparent,
      this.dateTextStyle,
      this.dayTextStyle});

  /// The background color for the view header view in calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.week,
  ///        viewHeaderStyle: ViewHeaderStyle(
  ///            backgroundColor: Colors.blue,
  ///            dayTextStyle: TextStyle(color: Colors.grey, fontSize: 20),
  ///            dateTextStyle: TextStyle(color: Colors.grey, fontSize: 25)),
  ///      ),
  ///    );
  ///  }
  /// ```
  final Color backgroundColor;

  /// The text style for the date text in view header of calendar
  /// This property doesn't apply for the view header of month view in calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.week,
  ///        viewHeaderStyle: ViewHeaderStyle(
  ///            backgroundColor: Colors.blue,
  ///            dayTextStyle: TextStyle(color: Colors.grey, fontSize: 20),
  ///            dateTextStyle: TextStyle(color: Colors.grey, fontSize: 25)),
  ///      ),
  ///    );
  ///  }
  /// ```
  final TextStyle dateTextStyle;

  /// The text style for day text in view header of calendar
  /// This property doesn't apply for the view header of month view in calendar
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///      child: SfCalendar(
  ///        view: CalendarView.week,
  ///        viewHeaderStyle: ViewHeaderStyle(
  ///            backgroundColor: Colors.blue,
  ///            dayTextStyle: TextStyle(color: Colors.grey, fontSize: 20),
  ///            dateTextStyle: TextStyle(color: Colors.grey, fontSize: 25)),
  ///      ),
  ///    );
  ///  }
  /// ```
  final TextStyle dayTextStyle;

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ViewHeaderStyle otherStyle = other;
    return otherStyle.backgroundColor == backgroundColor &&
        otherStyle.dayTextStyle == dayTextStyle &&
        otherStyle.dateTextStyle == dateTextStyle;
  }

  @override
  int get hashCode {
    return hashValues(
      backgroundColor,
      dayTextStyle,
      dateTextStyle,
    );
  }
}

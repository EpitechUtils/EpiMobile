part of calendar;

/// holds the view changed event arguments
class ViewChangedDetails {
  List<DateTime> visibleDates;
}

/// holds the calendar tapped event arguments
class CalendarTapDetails {
  List<dynamic> appointments;
  DateTime date;
  CalendarElement targetElement;
}

/// args to update the required properties from calendar state to it's children's
class _UpdateCalendarStateDetails {
  DateTime _currentDate;
  List<DateTime> _currentViewVisibleDates;
  List<dynamic> _visibleAppointments;
  DateTime _selectedDate;
  double _allDayPanelHeight;
  List<_AppointmentView> _allDayAppointmentViewCollection;
  List<dynamic> _appointments;

  // ignore: prefer_final_fields
  bool _isAppointmentTapped = false;
}

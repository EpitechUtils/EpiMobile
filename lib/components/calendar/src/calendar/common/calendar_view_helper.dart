part of calendar;

bool _isDarkTheme(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  return theme != null &&
      theme.brightness != null &&
      theme.brightness == Brightness.dark;
}

/// Returns the time interval value based on the given start time, end time and
/// time interval value of time slot view settings, the time interval will be
/// auto adjust if the given time interval doesn't cover the given start and end
/// time values, i.e: if the startHour set as 10 and endHour set as 20 and the
/// timeInterval value given as 180 means we cannot divide the 10 hours into
/// 3  hours, hence the time interval will be auto adjusted to 200
/// based on the given properties.
int _getTimeInterval(TimeSlotViewSettings settings) {
  double defaultLinesCount = 24;
  double totalMinutes = 0;

  if (settings.startHour >= 0 &&
      settings.endHour >= settings.startHour &&
      settings.endHour <= 24) {
    defaultLinesCount = settings.endHour - settings.startHour;
  }

  totalMinutes = defaultLinesCount * 60;

  if (settings.timeInterval.inMinutes >= 0 &&
      settings.timeInterval.inMinutes <= totalMinutes &&
      totalMinutes.round() % settings.timeInterval.inMinutes.round() == 0) {
    return settings.timeInterval.inMinutes;
  } else if (settings.timeInterval.inMinutes >= 0 &&
      settings.timeInterval.inMinutes <= totalMinutes) {
    return _getNearestValue(settings.timeInterval.inMinutes, totalMinutes);
  } else {
    return 60;
  }
}

/// Returns the horizontal lines count for a single day in day/week/workweek and time line view
double _getHorizontalLinesCount(TimeSlotViewSettings settings) {
  double defaultLinesCount = 24;
  double totalMinutes = 0;
  final int timeInterval = _getTimeInterval(settings);

  if (settings.startHour >= 0 &&
      settings.endHour >= settings.startHour &&
      settings.endHour <= 24) {
    defaultLinesCount = settings.endHour - settings.startHour;
  }

  totalMinutes = defaultLinesCount * 60;

  return totalMinutes / timeInterval;
}

int _getNearestValue(int timeInterval, double totalMinutes) {
  timeInterval++;
  if (totalMinutes.round() % timeInterval.round() == 0) {
    return timeInterval;
  }

  return _getNearestValue(timeInterval, totalMinutes);
}

bool _isWithInVisibleDateRange(
    List<DateTime> visibleDates, DateTime selectedDate) {
  final DateTime firstDate = visibleDates[0];
  final DateTime lastDate = visibleDates[visibleDates.length - 1];
  if (selectedDate != null) {
    assert(firstDate != null && lastDate != null);
    {
      if (_isSameDate(firstDate, selectedDate) ||
          _isSameDate(lastDate, selectedDate))
        return true;
      else
        return selectedDate.isAfter(firstDate) &&
            selectedDate.isBefore(lastDate);
    }
  } else
    return false;
}

bool _isSameDate(DateTime date1, DateTime date2) {
  if (date1 == null || date2 == null) {
    return false;
  }

  return date1.month == date2.month &&
      date1.year == date2.year &&
      date1.day == date2.day;
}

// returns the single view width from the time line view for time line
double _getSingleViewWidthForTimeLineView(_CalendarViewState viewState) {
  return (viewState._scrollController.position.maxScrollExtent +
          viewState._scrollController.position.viewportDimension) /
      viewState.widget._visibleDates.length;
}

double _getTimeLabelWidth(double _timeLabelViewWidth, CalendarView _view) {
  if (_timeLabelViewWidth != -1) {
    return _timeLabelViewWidth;
  }

  if (_isTimelineView(_view)) {
    return 30;
  } else if (_view != CalendarView.month) {
    return 50;
  }

  return 0;
}

double _getViewHeaderHeight(double _viewHeaderHeight, CalendarView _view) {
  if (_viewHeaderHeight != -1) {
    return _viewHeaderHeight;
  }

  final bool _isTimeline = _isTimelineView(_view);
  if (_view != CalendarView.month && !_isTimeline) {
    if (_view == CalendarView.day) {
      return 60;
    }

    return 55;
  } else if (_isTimeline) {
    return 30;
  } else {
    return 25;
  }
}

bool _shouldRaiseViewChangedCallback(ViewChangedCallback _onViewChanged) {
  return _onViewChanged != null;
}

bool _shouldRaiseCalendarTapCallback(CalendarTapCallback onTap) {
  return onTap != null;
}

// method that raise the calendar tapped call back with the given parameters
void _raiseCalendarTapCallback(SfCalendar calendar,
    {DateTime date, List<dynamic> appointments, CalendarElement element}) {
  final CalendarTapDetails calendarTapDetails = CalendarTapDetails();
  calendarTapDetails.date = date;
  calendarTapDetails.appointments = appointments;
  calendarTapDetails.targetElement = element;
  calendar.onTap(calendarTapDetails);
}

// method that raises the visible dates changed call back with the given parameters
void _raiseViewChangedCallback(SfCalendar calendar,
    {List<DateTime> visibleDates}) {
  final ViewChangedDetails viewChangedDetails = ViewChangedDetails();
  viewChangedDetails.visibleDates = visibleDates;
  calendar.onViewChanged(viewChangedDetails);
}

bool _isAutoTimeIntervalHeight(SfCalendar calendar) {
  return calendar.timeSlotViewSettings.timeIntervalHeight == -1;
}

double _getTimeIntervalHeight(SfCalendar calendar, double _width,
    double _height, int _visibleDatesCount, double _allDayHeight) {
  double _timeIntervalHeight = calendar.timeSlotViewSettings.timeIntervalHeight;
  double _viewHeaderHeight =
      _getViewHeaderHeight(calendar.viewHeaderHeight, calendar.view);

  if (calendar.view == CalendarView.day) {
    _allDayHeight = _kAllDayLayoutHeight;
    _viewHeaderHeight = 0;
  } else {
    _allDayHeight = _allDayHeight > _kAllDayLayoutHeight
        ? _kAllDayLayoutHeight
        : _allDayHeight;
  }

  if (!_isTimelineView(calendar.view)) {
    if (_isAutoTimeIntervalHeight(calendar)) {
      _timeIntervalHeight = (_height - _allDayHeight - _viewHeaderHeight) /
          _getHorizontalLinesCount(calendar.timeSlotViewSettings);
    }
  } else {
    if (_isAutoTimeIntervalHeight(calendar)) {
      if (calendar.view == CalendarView.day) {
        _timeIntervalHeight =
            _width / _getHorizontalLinesCount(calendar.timeSlotViewSettings);
      } else if (calendar.view != CalendarView.month) {
        final dynamic _horizontalLinesCount =
            _getHorizontalLinesCount(calendar.timeSlotViewSettings);
        _timeIntervalHeight =
            _width / (_horizontalLinesCount * _visibleDatesCount);
        if (!_isValidWidth(
            _width, calendar, _visibleDatesCount, _horizontalLinesCount)) {
          // we have used 40 as a default time interval height for time line view
          // if the time interval height set for auto time interval height
          _timeIntervalHeight = 40;
        }
      }
    }
  }

  return _timeIntervalHeight;
}

// checks whether the width can afford the line count or else creates a scrollable width
bool _isValidWidth(double _screenWidth, SfCalendar calendar,
    int _visibleDatesCount, double _horizontalLinesCount) {
  const dynamic offSetValue = 10;
  final dynamic tempWidth =
      _visibleDatesCount * offSetValue * _horizontalLinesCount;

  if (tempWidth < _screenWidth) {
    return true;
  }

  return false;
}

bool _isTimelineView(CalendarView view) {
  return view == CalendarView.timelineDay ||
      view == CalendarView.timelineWeek ||
      view == CalendarView.timelineWorkWeek;
}

// converts the given schedule appointment collection to their custom appointment collection
List<dynamic> _getCustomAppointments(List<Appointment> _appointments) {
  final List<dynamic> _customAppointments = <dynamic>[];
  if (_appointments != null) {
    for (int i = 0; i < _appointments.length; i++) {
      _customAppointments.add(_appointments[i]._data);
    }

    return _customAppointments;
  }

  return null;
}

/*bool _isSameTimeSlot(DateTime date1, DateTime date2) {
  if (date1 == null || date2 == null) {
    return false;
  }

  return date1.month == date2.month && date1.year == date2.year &&
      date1.day == date2.day && date1.hour == date2.hour &&
      date1.minute == date2.minute && date1.second == date2.second;
}*/

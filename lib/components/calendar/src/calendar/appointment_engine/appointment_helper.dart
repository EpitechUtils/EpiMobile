part of calendar;

DateTime _convertToStartTime(DateTime date) {
  return DateTime(date.year, date.month, date.day, 0, 0, 0);
}

DateTime _convertToEndTime(DateTime date) {
  return DateTime(date.year, date.month, date.day, 23, 59, 59);
}

//// Check whether the data source has calendar appointment type or not.
bool _isCalendarAppointment(List<dynamic> dataSource) {
  if (dataSource == null ||
      dataSource.isEmpty ||
      dataSource[0].runtimeType.toString() == 'Appointment') {
    return true;
  }

  return false;
}

bool _isSpanned(Appointment appointment) {
  return !(appointment._actualEndTime.day == appointment._actualStartTime.day &&
          appointment._actualEndTime.month ==
              appointment._actualStartTime.month &&
          appointment._actualEndTime.year ==
              appointment._actualStartTime.year) &&
      appointment._actualEndTime
              .difference(appointment._actualStartTime)
              .inDays >
          0;
}

TextSpan _getRecurrenceIcon(Color color, double textSize) {
  return TextSpan(
      text: String.fromCharCode(59491),
      style: TextStyle(
        color: color,
        fontSize: textSize,
        fontFamily: 'MaterialIcons',
      ));
}

List<Appointment> _getSelectedDateAppointments(
    List<Appointment> appointments, String timeZone, DateTime date) {
  final List<Appointment> appointmentCollection = <Appointment>[];
  if (appointments == null || appointments.isEmpty || date == null) {
    return <Appointment>[];
  }

  final DateTime startDate = _convertToStartTime(date);
  final DateTime endDate = _convertToEndTime(date);
  int count = 0;
  if (appointments != null) {
    count = appointments.length;
  }

  for (int j = 0; j < count; j++) {
    final Appointment appointment = appointments[j];
    appointment._actualStartTime = _convertTimeToAppointmentTimeZone(
        appointment.startTime, appointment.startTimeZone, timeZone);
    appointment._actualEndTime = _convertTimeToAppointmentTimeZone(
        appointment.endTime, appointment.endTimeZone, timeZone);

    if (appointment.recurrenceRule == null ||
        appointment.recurrenceRule == '') {
      if (_isAppointmentWithinVisibleDateRange(
          appointment, startDate, endDate)) {
        appointmentCollection.add(appointment);
      }

      continue;
    }

    _getRecurrenceAppointments(
        appointment, appointmentCollection, startDate, endDate, timeZone);
  }

  return appointmentCollection;
}

Appointment _copy(Appointment appointment) {
  final Appointment _copyAppointment = Appointment();
  _copyAppointment.startTime = appointment.startTime;
  _copyAppointment.endTime = appointment.endTime;
  _copyAppointment.isAllDay = appointment.isAllDay;
  _copyAppointment.subject = appointment.subject;
  _copyAppointment.color = appointment.color;
  _copyAppointment._actualStartTime = appointment._actualStartTime;
  _copyAppointment._actualEndTime = appointment._actualEndTime;
  _copyAppointment.startTimeZone = appointment.startTimeZone;
  _copyAppointment.endTimeZone = appointment.endTimeZone;
  _copyAppointment.recurrenceRule = appointment.recurrenceRule;
  _copyAppointment.recurrenceExceptionDates =
      appointment.recurrenceExceptionDates;
  _copyAppointment.notes = appointment.notes;
  _copyAppointment.location = appointment.location;
  _copyAppointment._isSpanned = appointment._isSpanned;
  _copyAppointment._data = appointment._data;
  return _copyAppointment;
}

List<Appointment> _getVisibleSelectedDateAppointments(
    SfCalendar calendar, DateTime date, List<dynamic> _visibleAppointments) {
  final List<Appointment> appointmentCollection = <Appointment>[];
  if (date == null || _visibleAppointments == null) {
    return appointmentCollection;
  }

  final DateTime startDate = _convertToStartTime(date);
  final DateTime endDate = _convertToEndTime(date);

  for (int j = 0; j < _visibleAppointments.length; j++) {
    final Appointment appointment = _visibleAppointments[j];
    if (_isAppointmentWithinVisibleDateRange(appointment, startDate, endDate)) {
      appointmentCollection.add(appointment);
    }
  }

  return appointmentCollection;
}

bool _isAppointmentWithinVisibleDateRange(
    Appointment appointment, DateTime visibleStart, DateTime visibleEnd) {
  final DateTime appStartTime = appointment._actualStartTime;
  final DateTime appEndTime = appointment._actualEndTime;
  if (appStartTime.isAfter(visibleStart)) {
    if (appStartTime.isBefore(visibleEnd)) {
      return true;
    }
  } else if (appStartTime.day == visibleStart.day &&
      appStartTime.month == visibleStart.month &&
      appStartTime.year == visibleStart.year) {
    return true;
  } else if (appEndTime.isAfter(visibleStart)) {
    return true;
  }

  return false;
}

bool _isAppointmentInVisibleDateRange(
    Appointment appointment, DateTime visibleStart, DateTime visibleEnd) {
  final DateTime appStartTime = appointment._actualStartTime;
  final DateTime appEndTime = appointment._actualEndTime;
  if ((appStartTime.isAfter(visibleStart) ||
          (appStartTime.day == visibleStart.day &&
              appStartTime.month == visibleStart.month &&
              appStartTime.year == visibleStart.year)) &&
      (appStartTime.isBefore(visibleEnd) ||
          (appStartTime.day == visibleEnd.day &&
              appStartTime.month == visibleEnd.month &&
              appStartTime.year == visibleEnd.year)) &&
      (appEndTime.isAfter(visibleStart) ||
          (appEndTime.day == visibleStart.day &&
              appEndTime.month == visibleStart.month &&
              appEndTime.year == visibleStart.year)) &&
      (appEndTime.isBefore(visibleEnd) ||
          (appEndTime.day == visibleEnd.day &&
              appEndTime.month == visibleEnd.month &&
              appEndTime.year == visibleEnd.year))) {
    return true;
  }

  return false;
}

bool _isAppointmentStartDateWithinVisibleDateRange(
    DateTime appointmentStartDate, DateTime visibleStart, DateTime visibleEnd) {
  if (appointmentStartDate.isAfter(visibleStart)) {
    if (appointmentStartDate.isBefore(visibleEnd)) {
      return true;
    }
  } else if (appointmentStartDate.day == visibleStart.day &&
      appointmentStartDate.month == visibleStart.month &&
      appointmentStartDate.year == visibleStart.year) {
    return true;
  }

  return false;
}

bool _isAppointmentEndDateWithinVisibleDateRange(
    DateTime appointmentEndDate, DateTime visibleStart, DateTime visibleEnd) {
  if (appointmentEndDate.isAfter(visibleStart)) {
    if (appointmentEndDate.isBefore(visibleEnd)) {
      return true;
    }
  } else if (appointmentEndDate.day == visibleEnd.day &&
      appointmentEndDate.month == visibleEnd.month &&
      appointmentEndDate.year == visibleEnd.year) {
    return true;
  }

  return false;
}

Location _timeZoneInfoToOlsonTimeZone(String windowsTimeZoneId) {
  final Map<String, String> olsonWindowsTimes = <String, String>{};
  olsonWindowsTimes['AUS Central Standard Time'] = 'Australia/Darwin';
  olsonWindowsTimes['AUS Eastern Standard Time'] = 'Australia/Sydney';
  olsonWindowsTimes['Afghanistan Standard Time'] = 'Asia/Kabul';
  olsonWindowsTimes['Alaskan Standard Time'] = 'America/Anchorage';
  olsonWindowsTimes['Arab Standard Time'] = 'Asia/Riyadh';
  olsonWindowsTimes['Arabian Standard Time'] = 'Indian/Reunion';
  olsonWindowsTimes['Arabic Standard Time'] = 'Asia/Baghdad';
  olsonWindowsTimes['Argentina Standard Time'] =
      'America/Argentina/Buenos_Aires';
  olsonWindowsTimes['Atlantic Standard Time'] = 'America/Halifax';
  olsonWindowsTimes['Azerbaijan Standard Time'] = 'Asia/Baku';
  olsonWindowsTimes['Azores Standard Time'] = 'Atlantic/Azores';
  olsonWindowsTimes['Bahia Standard Time'] = 'America/Bahia';
  olsonWindowsTimes['Bangladesh Standard Time'] = 'Asia/Dhaka';
  olsonWindowsTimes['Belarus Standard Time'] = 'Europe/Minsk';
  olsonWindowsTimes['Canada Central Standard Time'] = 'America/Regina';
  olsonWindowsTimes['Cape Verde Standard Time'] = 'Atlantic/Cape_Verde';
  olsonWindowsTimes['Caucasus Standard Time'] = 'Asia/Yerevan';
  olsonWindowsTimes['Cen. Australia Standard Time'] = 'Australia/Adelaide';
  olsonWindowsTimes['Central America Standard Time'] = 'America/Guatemala';
  olsonWindowsTimes['Central Asia Standard Time'] = 'Asia/Almaty';
  olsonWindowsTimes['Central Brazilian Standard Time'] = 'America/Cuiaba';
  olsonWindowsTimes['Central Europe Standard Time'] = 'Europe/Budapest';
  olsonWindowsTimes['Central European Standard Time'] = 'Europe/Warsaw';
  olsonWindowsTimes['Central Pacific Standard Time'] = 'Pacific/Guadalcanal';
  olsonWindowsTimes['Central Standard Time'] = 'America/Chicago';
  olsonWindowsTimes['China Standard Time'] = 'Asia/Shanghai';
  olsonWindowsTimes['Dateline Standard Time'] = 'Etc/GMT+12';
  olsonWindowsTimes['E. Africa Standard Time'] = 'Africa/Nairobi';
  olsonWindowsTimes['E. Australia Standard Time'] = 'Australia/Brisbane';
  olsonWindowsTimes['E. South America Standard Time'] = 'America/Sao_Paulo';
  olsonWindowsTimes['Eastern Standard Time'] = 'America/New_York';
  olsonWindowsTimes['Egypt Standard Time'] = 'Africa/Cairo';
  olsonWindowsTimes['Ekaterinburg Standard Time'] = 'Asia/Yekaterinburg';
  olsonWindowsTimes['FLE Standard Time'] = 'Europe/Kiev';
  olsonWindowsTimes['Fiji Standard Time'] = 'Pacific/Fiji';
  olsonWindowsTimes['GMT Standard Time'] = 'Europe/London';
  olsonWindowsTimes['GTB Standard Time'] = 'Europe/Bucharest';
  olsonWindowsTimes['Georgian Standard Time'] = 'Asia/Tbilisi';
  olsonWindowsTimes['Greenland Standard Time'] = 'America/Godthab';
  olsonWindowsTimes['Greenwich Standard Time'] = 'Atlantic/Reykjavik';
  olsonWindowsTimes['Hawaiian Standard Time'] = 'Pacific/Honolulu';
  olsonWindowsTimes['India Standard Time'] = 'Asia/Kolkata';
  olsonWindowsTimes['Iran Standard Time'] = 'Asia/Tehran';
  olsonWindowsTimes['Israel Standard Time'] = 'Asia/Jerusalem';
  olsonWindowsTimes['Jordan Standard Time'] = 'Asia/Amman';
  olsonWindowsTimes['Kaliningrad Standard Time'] = 'Europe/Kaliningrad';
  olsonWindowsTimes['Korea Standard Time'] = 'Asia/Seoul';
  olsonWindowsTimes['Libya Standard Time'] = 'Africa/Tripoli';
  olsonWindowsTimes['Line Islands Standard Time'] = 'Pacific/Kiritimati';
  olsonWindowsTimes['Magadan Standard Time'] = 'Asia/Magadan';
  olsonWindowsTimes['Mauritius Standard Time'] = 'Indian/Mauritius';
  olsonWindowsTimes['Middle East Standard Time'] = 'Asia/Beirut';
  olsonWindowsTimes['Montevideo Standard Time'] = 'America/Montevideo';
  olsonWindowsTimes['Morocco Standard Time'] = 'Africa/Casablanca';
  olsonWindowsTimes['Mountain Standard Time'] = 'America/Denver';
  olsonWindowsTimes['Mountain Standard Time (Mexico)'] = 'America/Chihuahua';
  olsonWindowsTimes['Myanmar Standard Time'] = 'Asia/Rangoon';
  olsonWindowsTimes['N. Central Asia Standard Time'] = 'Asia/Novosibirsk';
  olsonWindowsTimes['Namibia Standard Time'] = 'Africa/Windhoek';
  olsonWindowsTimes['Nepal Standard Time'] = 'Asia/Kathmandu';
  olsonWindowsTimes['New Zealand Standard Time'] = 'Pacific/Auckland';
  olsonWindowsTimes['Newfoundland Standard Time'] = 'America/St_Johns';
  olsonWindowsTimes['North Asia East Standard Time'] = 'Asia/Irkutsk';
  olsonWindowsTimes['North Asia Standard Time'] = 'Asia/Krasnoyarsk';
  olsonWindowsTimes['Pacific SA Standard Time'] = 'America/Santiago';
  olsonWindowsTimes['Pacific Standard Time'] = 'America/Los_Angeles';
  olsonWindowsTimes['Pacific Standard Time (Mexico)'] = 'America/Santa_Isabel';
  olsonWindowsTimes['Pakistan Standard Time'] = 'Asia/Karachi';
  olsonWindowsTimes['Paraguay Standard Time'] = 'America/Asuncion';
  olsonWindowsTimes['Romance Standard Time'] = 'Europe/Paris';
  olsonWindowsTimes['Russia Time Zone 10'] = 'Asia/Srednekolymsk';
  olsonWindowsTimes['Russia Time Zone 11'] = 'Asia/Kamchatka';
  olsonWindowsTimes['Russia Time Zone 3'] = 'Europe/Samara';
  olsonWindowsTimes['Russian Standard Time'] = 'Europe/Moscow';
  olsonWindowsTimes['SA Eastern Standard Time'] = 'America/Cayenne';
  olsonWindowsTimes['SA Pacific Standard Time'] = 'America/Bogota';
  olsonWindowsTimes['SA Western Standard Time'] = 'America/La_Paz';
  olsonWindowsTimes['SE Asia Standard Time'] = 'Asia/Bangkok';
  olsonWindowsTimes['Samoa Standard Time'] = 'Pacific/Apia';
  olsonWindowsTimes['Singapore Standard Time'] = 'Asia/Singapore';
  olsonWindowsTimes['South Africa Standard Time'] = 'Africa/Johannesburg';
  olsonWindowsTimes['Sri Lanka Standard Time'] = 'Asia/Colombo';
  olsonWindowsTimes['Syria Standard Time'] = 'Asia/Damascus';
  olsonWindowsTimes['Taipei Standard Time'] = 'Asia/Taipei';
  olsonWindowsTimes['Tasmania Standard Time'] = 'Australia/Hobart';
  olsonWindowsTimes['Tokyo Standard Time'] = 'Asia/Tokyo';
  olsonWindowsTimes['Tonga Standard Time'] = 'Pacific/Tongatapu';
  olsonWindowsTimes['Turkey Standard Time'] = 'Europe/Istanbul';
  olsonWindowsTimes['US Eastern Standard Time'] =
      'America/Indiana/Indianapolis';
  olsonWindowsTimes['US Mountain Standard Time'] = 'America/Phoenix';
  olsonWindowsTimes['UTC'] = 'America/Danmarkshavn';
  olsonWindowsTimes['UTC+12'] = 'Pacific/Tarawa';
  olsonWindowsTimes['UTC-02'] = 'America/Noronha';
  olsonWindowsTimes['UTC-11'] = 'Pacific/Midway';
  olsonWindowsTimes['Ulaanbaatar Standard Time'] = 'Asia/Ulaanbaatar';
  olsonWindowsTimes['Venezuela Standard Time'] = 'America/Caracas';
  olsonWindowsTimes['Vladivostok Standard Time'] = 'Asia/Vladivostok';
  olsonWindowsTimes['W. Australia Standard Time'] = 'Australia/Perth';
  olsonWindowsTimes['W. Central Africa Standard Time'] = 'Africa/Lagos';
  olsonWindowsTimes['W. Europe Standard Time'] = 'Europe/Berlin';
  olsonWindowsTimes['West Asia Standard Time'] = 'Asia/Tashkent';
  olsonWindowsTimes['West Pacific Standard Time'] = 'Pacific/Port_Moresby';
  olsonWindowsTimes['Yakutsk Standard Time'] = 'Asia/Yakutsk';

  if (olsonWindowsTimes.containsKey(windowsTimeZoneId)) {
    final String timeZone = olsonWindowsTimes[windowsTimeZoneId];
    return getLocation(timeZone);
  } else {
    return null;
  }
}

bool _isDateTimeEqual(DateTime date1, DateTime date2) {
  if (date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day &&
      date1.hour == date2.hour &&
      date1.minute == date2.minute) {
    return true;
  }

  return false;
}

bool _isDateEqual(DateTime date1, DateTime date2) {
  if (date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day) {
    return true;
  }

  return false;
}

double _timeToPosition(
    SfCalendar calendar, DateTime date, double _timeIntervalHeight) {
  final double singleIntervalHeightForAnHour =
      ((60 / _getTimeInterval(calendar.timeSlotViewSettings)) *
              _timeIntervalHeight)
          .toDouble();
  final int hour = date.hour;
  final int minute = date.minute;
  final int seconds = date.second;
  double startHour = 0;
  if (calendar.timeSlotViewSettings != null) {
    startHour = calendar.timeSlotViewSettings.startHour;
  }

  return ((hour + (minute / 60).toDouble() + (seconds / 3600).toDouble()) *
          singleIntervalHeightForAnHour) -
      (startHour * singleIntervalHeightForAnHour).toDouble();
}

double _getAppointmentHeightFromDuration(
    Duration minimumDuration, SfCalendar calendar, double _timeIntervalHeight) {
  if (minimumDuration == null || minimumDuration.inMinutes <= 0) {
    return 0;
  }

  final double hourHeight =
      ((60 / _getTimeInterval(calendar.timeSlotViewSettings)) *
              _timeIntervalHeight)
          .toDouble();
  return minimumDuration.inMinutes * (hourHeight / 60);
}

double _getAppointmentMinHeight(
    SfCalendar calendar, _AppointmentView appView, double _timeIntervalHeight) {
  double minHeight;

  // Appointment Default Bottom Position without considering MinHeight
  final double defaultAppHeight = _timeToPosition(
          calendar, appView.appointment._actualEndTime, _timeIntervalHeight) -
      _timeToPosition(
          calendar, appView.appointment._actualStartTime, _timeIntervalHeight);

  minHeight = _getAppointmentHeightFromDuration(
      calendar.timeSlotViewSettings.minimumAppointmentDuration,
      calendar,
      _timeIntervalHeight);

  // Appointment Default Bottom Position - Default value as double.NaN
  if (minHeight == 0) {
    return defaultAppHeight;
  } else if ((minHeight < defaultAppHeight) ||
      (_timeIntervalHeight < defaultAppHeight)) {
    // Appointment Minimum Height is smaller than default Appointment Height
    // Appointment default Height is greater than TimeIntervalHeight
    return defaultAppHeight;
  } else if (minHeight > _timeIntervalHeight) {
    // Appointment Minimum Height is greater than Interval Height
    return _timeIntervalHeight;
  } else {
    // Appointment with proper MinHeight and within Interval
    return minHeight; //appView.Appointment.MinHeight;
  }
}

bool _isIntersectingAppointmentInDayView(
    SfCalendar calendar,
    Appointment currentApp,
    _AppointmentView appView,
    Appointment appointment,
    bool isAllDay,
    double _timeIntervalHeight) {
  if (currentApp == appointment) {
    return false;
  }

  if (currentApp._actualStartTime.isBefore(appointment._actualEndTime) &&
      currentApp._actualStartTime.isAfter(appointment._actualStartTime)) {
    return true;
  }

  if (currentApp._actualEndTime.isAfter(appointment._actualStartTime) &&
      currentApp._actualEndTime.isBefore(appointment._actualEndTime)) {
    return true;
  }

  if (currentApp._actualEndTime.isAfter(appointment._actualEndTime) &&
      currentApp._actualStartTime.isBefore(appointment._actualStartTime)) {
    return true;
  }

  if (_isDateTimeEqual(
          currentApp._actualStartTime, appointment._actualStartTime) ||
      _isDateTimeEqual(currentApp._actualEndTime, appointment._actualEndTime)) {
    return true;
  }

  if (isAllDay) {
    return false;
  }

  // Intersecting appointments by comparing appointments MinHeight instead of Start and EndTime
  if (calendar.timeSlotViewSettings.minimumAppointmentDuration != null &&
      calendar.timeSlotViewSettings.minimumAppointmentDuration.inMinutes > 0) {
    // Comparing appointments rendered in different dates
    if (!_isDateEqual(
        currentApp._actualStartTime, appointment._actualStartTime)) {
      return false;
    }

    // Comparing appointments rendered in the same date
    final double appTopPos = _timeToPosition(
        calendar, appointment._actualStartTime, _timeIntervalHeight);
    final double currentAppTopPos = _timeToPosition(
        calendar, currentApp._actualStartTime, _timeIntervalHeight);
    final double appHeight =
        _getAppointmentMinHeight(calendar, appView, _timeIntervalHeight);
    // Height difference between previous and current appointment from top position
    final double heightDiff = currentAppTopPos - appTopPos;
    if (appTopPos != currentAppTopPos && appHeight > heightDiff) {
      return true;
    }
  }

  return false;
}

_AppointmentView _getAppointmentOnPosition(
    _AppointmentView currentView, List<_AppointmentView> views) {
  if (currentView == null ||
      currentView.appointment == null ||
      views == null ||
      views.isEmpty) {
    return null;
  }

  for (_AppointmentView view in views) {
    if (view.position == currentView.position && view != currentView) {
      return view;
    }
  }

  return null;
}

bool _iterateAppointment(Appointment app, SfCalendar calendar, bool isAllDay) {
  final bool _isTimeline = _isTimelineView(calendar.view);
  if (isAllDay) {
    if (!_isTimeline && app.isAllDay) {
      app._actualEndTime = _convertToEndTime(app._actualEndTime);
      app._actualStartTime = _convertToStartTime(app._actualStartTime);
      return true;
    } else if (!_isTimeline && _isSpanned(app)) {
      return true;
    }

    return false;
  }

  if ((app.isAllDay || _isSpanned(app)) && !_isTimeline) {
    return false;
  }

  if (_isTimeline && app.isAllDay) {
    app._actualEndTime = _convertToEndTime(app._actualEndTime);
    app._actualStartTime = _convertToStartTime(app._actualStartTime);
  }

  return true;
}

int _orderAppointmentsDescending(bool value, bool value1) {
  int boolValue1 = -1;
  int boolValue2 = -1;
  if (value) {
    boolValue1 = 1;
  }

  if (value1) {
    boolValue2 = 1;
  }

  return boolValue1.compareTo(boolValue2);
}

int _orderAppointmentsAscending(bool value, bool value1) {
  int boolValue1 = 1;
  int boolValue2 = 1;
  if (value) {
    boolValue1 = -1;
  }

  if (value1) {
    boolValue2 = -1;
  }

  return boolValue1.compareTo(boolValue2);
}

void _setAppointmentPositionAndMaxPosition(
    Object parent,
    SfCalendar calendar,
    List<Appointment> visibleAppointments,
    bool isAllDay,
    double _timeIntervalHeight) {
  if (visibleAppointments == null) {
    return;
  }

  final List<Appointment> normalAppointments = visibleAppointments
      .where((Appointment app) => _iterateAppointment(app, calendar, isAllDay))
      .toList();
  normalAppointments.sort((Appointment app1, Appointment app2) =>
      app1._actualStartTime.compareTo(app2._actualStartTime));
  if (!_isTimelineView(calendar.view)) {
    normalAppointments.sort((Appointment app1, Appointment app2) =>
        _orderAppointmentsDescending(app1._isSpanned, app2._isSpanned));
    normalAppointments.sort((Appointment app1, Appointment app2) =>
        _orderAppointmentsDescending(app1.isAllDay, app2.isAllDay));
  } else {
    normalAppointments.sort((Appointment app1, Appointment app2) =>
        _orderAppointmentsAscending(app1._isSpanned, app2._isSpanned));
    normalAppointments.sort((Appointment app1, Appointment app2) =>
        _orderAppointmentsAscending(app1.isAllDay, app2.isAllDay));
  }

  final Map<int, List<_AppointmentView>> dict = <int, List<_AppointmentView>>{};
  final List<_AppointmentView> processedViews = <_AppointmentView>[];
  int maxColsCount = 1;

  for (int count = 0; count < normalAppointments.length; count++) {
    final Appointment currentAppointment = normalAppointments[count];
    //Where this condition was not needed to iOS, because we have get the appointment for specific date. In Android we pass the visible date range.
    if ((calendar.view == CalendarView.workWeek ||
            calendar.view == CalendarView.timelineWorkWeek) &&
        calendar.timeSlotViewSettings.nonWorkingDays
            .contains(currentAppointment._actualStartTime.weekday) &&
        calendar.timeSlotViewSettings.nonWorkingDays
            .contains(currentAppointment._actualEndTime.weekday)) {
      continue;
    }

    List<_AppointmentView> intersectingApps;
    _AppointmentView currentAppView;
    if (parent is _AppointmentPainter) {
      currentAppView = _getAppointmentView(currentAppointment, parent);
    } else {
      final _SfCalendarState state = parent;
      currentAppView = state._getAppointmentView(currentAppointment);
    }

    for (int position = 0; position < maxColsCount; position++) {
      bool isIntersecting = false;
      for (int j = 0; j < processedViews.length; j++) {
        final _AppointmentView previousApp = processedViews[j];

        if (previousApp.position != position) {
          continue;
        }

        if (_isIntersectingAppointmentInDayView(
            calendar,
            currentAppointment,
            previousApp,
            previousApp.appointment,
            isAllDay,
            _timeIntervalHeight)) {
          isIntersecting = true;

          if (intersectingApps == null) {
            final List<int> keyList = dict.keys.toList();
            for (int keyCount = 0; keyCount < keyList.length; keyCount++) {
              final int key = keyList[keyCount];
              if (dict[key].contains(previousApp)) {
                intersectingApps = dict[key];
                break;
              }
            }

            if (intersectingApps == null) {
              intersectingApps = <_AppointmentView>[];
              dict[dict.keys.length] = intersectingApps;
            }

            break;
          }
        }
      }

      if (!isIntersecting && currentAppView.position == -1) {
        currentAppView.position = position;
      }
    }

    processedViews.add(currentAppView);
    if (currentAppView.position == -1) {
      int position = 0;
      if (intersectingApps == null) {
        intersectingApps = <_AppointmentView>[];
        dict[dict.keys.length] = intersectingApps;
      } else if (intersectingApps.isNotEmpty) {
        position = intersectingApps
            .reduce((_AppointmentView currentAppview,
                    _AppointmentView nextAppview) =>
                currentAppview.maxPositions > nextAppview.maxPositions
                    ? currentAppview
                    : nextAppview)
            .maxPositions;
      }

      intersectingApps.add(currentAppView);
      for (int appin = 0; appin < intersectingApps.length; appin++) {
        intersectingApps[appin].maxPositions = position + 1;
      }

      currentAppView.position = position;
      if (maxColsCount <= position) {
        maxColsCount = position + 1;
      }
    } else {
      int maxPosition = 1;
      if (intersectingApps == null) {
        intersectingApps = <_AppointmentView>[];
        dict[dict.keys.length] = intersectingApps;
      } else if (intersectingApps.isNotEmpty) {
        maxPosition = intersectingApps
            .reduce((_AppointmentView currentAppview,
                    _AppointmentView nextAppview) =>
                currentAppview.maxPositions > nextAppview.maxPositions
                    ? currentAppview
                    : nextAppview)
            .maxPositions;

        if (currentAppView.position == maxPosition) {
          maxPosition++;
        }
      }

      intersectingApps.add(currentAppView);
      for (int appin = 0; appin < intersectingApps.length; appin++) {
        intersectingApps[appin].maxPositions = maxPosition;
      }

      if (maxColsCount <= maxPosition) {
        maxColsCount = maxPosition + 1;
      }
    }

    intersectingApps = null;
  }

  dict.clear();
}

DateTime _convertTimeToAppointmentTimeZone(
    DateTime date, String appTimeZoneId, String calendarTimeZoneId) {
  if ((appTimeZoneId == null || appTimeZoneId == '') &&
      (calendarTimeZoneId == null || calendarTimeZoneId == '')) {
    return date;
  }

  DateTime convertedDate = date;
  if (appTimeZoneId != null && appTimeZoneId != '') {
    //// Convert the date to appointment time zone
    if (appTimeZoneId == 'Dateline Standard Time') {
      convertedDate = (date.toUtc()).subtract(const Duration(hours: 12));
    } else {
      convertedDate =
          TZDateTime.from(date, _timeZoneInfoToOlsonTimeZone(appTimeZoneId));
    }

    //// Above mentioned converted date hold the date value which is equal to original date, but the time zone value changed.
    //// E.g., Nov 3- 9.00 AM IST equal to Nov 2- 10.30 PM EST
    //// So convert the Appointment time zone date to current time zone date.
    convertedDate = DateTime(
        date.year - (convertedDate.year - date.year),
        date.month - (convertedDate.month - date.month),
        date.day - (convertedDate.day - date.day),
        date.hour - (convertedDate.hour - date.hour),
        date.minute - (convertedDate.minute - date.minute),
        date.second);
  }

  if (calendarTimeZoneId != null && calendarTimeZoneId != '') {
    convertedDate ??= date;

    DateTime actualConvertedDate;
    //// Convert the converted date with calendar time zone
    if (calendarTimeZoneId == 'Dateline Standard Time') {
      actualConvertedDate =
          (convertedDate.toUtc()).subtract(const Duration(hours: 12));
    } else {
      actualConvertedDate = TZDateTime.from(
          convertedDate, _timeZoneInfoToOlsonTimeZone(calendarTimeZoneId));
    }

    //// Above mentioned actual converted date hold the date value which is equal to converted date, but the time zone value changed.
    //// So convert the schedule time zone date to current time zone date for rendering the appointment.
    return DateTime(
        convertedDate.year + (actualConvertedDate.year - convertedDate.year),
        convertedDate.month + (actualConvertedDate.month - convertedDate.month),
        convertedDate.day + (actualConvertedDate.day - convertedDate.day),
        convertedDate.hour + (actualConvertedDate.hour - convertedDate.hour),
        convertedDate.minute +
            (actualConvertedDate.minute - convertedDate.minute),
        convertedDate.second);
  }

  return convertedDate;
}

List<Appointment> _getVisibleAppointments(
    DateTime visibleStartDate,
    DateTime visibleEndDate,
    List<Appointment> appointments,
    String calendarTimeZone,
    bool isTimelineView) {
  final List<Appointment> appointmentColl = <Appointment>[];
  if (visibleStartDate == null ||
      visibleEndDate == null ||
      appointments == null) {
    return appointmentColl;
  }

  final DateTime startDate = _convertToStartTime(visibleStartDate);
  final DateTime endDate = _convertToEndTime(visibleEndDate);
  int count = 0;
  if (appointments != null) {
    count = appointments.length;
  }

  for (int j = 0; j < count; j++) {
    final Appointment appointment = appointments[j];
    appointment._actualStartTime = _convertTimeToAppointmentTimeZone(
        appointment.startTime, appointment.startTimeZone, calendarTimeZone);
    appointment._actualEndTime = _convertTimeToAppointmentTimeZone(
        appointment.endTime, appointment.endTimeZone, calendarTimeZone);

    if (appointment.recurrenceRule == null ||
        appointment.recurrenceRule == '') {
      if (_isAppointmentWithinVisibleDateRange(
          appointment, startDate, endDate)) {
        final DateTime appStartTime = appointment._actualStartTime;
        final DateTime appEndTime = appointment._actualEndTime;

        if (!(appStartTime.day == appEndTime.day &&
                appStartTime.year == appEndTime.year &&
                appStartTime.month == appEndTime.month) &&
            appStartTime.isBefore(appEndTime) &&
            (appEndTime.difference(appStartTime)).inDays == 0 &&
            !appointment.isAllDay &&
            !isTimelineView) {
          for (int i = 0; i < 2; i++) {
            final Appointment spannedAppointment = _copy(appointment);
            if (i == 0) {
              spannedAppointment._actualEndTime = DateTime(appStartTime.year,
                  appStartTime.month, appStartTime.day, 23, 59, 59);
            } else {
              spannedAppointment._actualStartTime = DateTime(
                  appEndTime.year, appEndTime.month, appEndTime.day, 0, 0, 0);
            }

            spannedAppointment.startTime = spannedAppointment.isAllDay
                ? appointment._actualStartTime
                : _convertTimeToAppointmentTimeZone(
                    appointment._actualStartTime,
                    appointment.startTimeZone,
                    calendarTimeZone);
            spannedAppointment.endTime = spannedAppointment.isAllDay
                ? appointment._actualEndTime
                : _convertTimeToAppointmentTimeZone(appointment._actualEndTime,
                    appointment.endTimeZone, calendarTimeZone);

            // Adding Spanned Appointment only when the Appointment range within the VisibleDate
            if (_isAppointmentWithinVisibleDateRange(
                spannedAppointment, startDate, endDate)) {
              appointmentColl.add(spannedAppointment);
            }
          }
        } else if (!(appStartTime.day == appEndTime.day &&
                appStartTime.year == appEndTime.year &&
                appStartTime.month == appEndTime.month) &&
            appStartTime.isBefore(appEndTime) &&
            isTimelineView) {
          //// Check the spanned appointment with in current visible dates. example visible date 21 to 27 and
          //// the appointment start and end date as 23 and 25.
          if (_isAppointmentInVisibleDateRange(
              appointment, startDate, endDate)) {
            appointment._isSpanned = _isSpanned(appointment);
            appointmentColl.add(appointment);
          } else if (_isAppointmentStartDateWithinVisibleDateRange(
              appointment._actualStartTime, startDate, endDate)) {
            //// Check the spanned appointment start date with in current visible dates.
            //// example visible date 21 to 27 and the appointment start and end date as 23 and 28.
            for (int i = 0; i < 2; i++) {
              final Appointment spannedAppointment = _copy(appointment);
              if (i == 0) {
                spannedAppointment._actualEndTime = DateTime(
                    endDate.year, endDate.month, endDate.day, 23, 59, 59);
              } else {
                spannedAppointment._actualStartTime =
                    DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);
              }

              spannedAppointment.startTime = spannedAppointment.isAllDay
                  ? appointment._actualStartTime
                  : _convertTimeToAppointmentTimeZone(
                      appointment._actualStartTime,
                      appointment.startTimeZone,
                      calendarTimeZone);
              spannedAppointment.endTime = spannedAppointment.isAllDay
                  ? appointment._actualEndTime
                  : _convertTimeToAppointmentTimeZone(
                      appointment._actualEndTime,
                      appointment.endTimeZone,
                      calendarTimeZone);

              // Adding Spanned Appointment only when the Appointment range within the VisibleDate
              if (_isAppointmentInVisibleDateRange(
                  spannedAppointment, startDate, endDate)) {
                spannedAppointment._isSpanned = _isSpanned(spannedAppointment);
                appointmentColl.add(spannedAppointment);
              }
            }
          } else if (_isAppointmentEndDateWithinVisibleDateRange(
              appointment._actualEndTime, startDate, endDate)) {
            //// Check the spanned appointment end date with in current visible dates. example visible date 21 to 27 and
            //// the appointment start and end date as 18 and 24.
            for (int i = 0; i < 2; i++) {
              final Appointment spannedAppointment = _copy(appointment);
              if (i == 0) {
                spannedAppointment._actualStartTime =
                    appointment._actualStartTime;
                final DateTime date = startDate.add(const Duration(days: -1));
                spannedAppointment._actualEndTime =
                    DateTime(date.year, date.month, date.day, 23, 59, 59);
              } else {
                spannedAppointment._actualStartTime = DateTime(
                    startDate.year, startDate.month, startDate.day, 0, 0, 0);
              }

              spannedAppointment.startTime = spannedAppointment.isAllDay
                  ? appointment._actualStartTime
                  : _convertTimeToAppointmentTimeZone(
                      appointment._actualStartTime,
                      appointment.startTimeZone,
                      calendarTimeZone);
              spannedAppointment.endTime = spannedAppointment.isAllDay
                  ? appointment._actualEndTime
                  : _convertTimeToAppointmentTimeZone(
                      appointment._actualEndTime,
                      appointment.endTimeZone,
                      calendarTimeZone);

              // Adding Spanned Appointment only when the Appointment range within the VisibleDate
              if (_isAppointmentInVisibleDateRange(
                  spannedAppointment, startDate, endDate)) {
                spannedAppointment._isSpanned = _isSpanned(spannedAppointment);
                appointmentColl.add(spannedAppointment);
              }
            }
          } else if (!_isAppointmentEndDateWithinVisibleDateRange(
                  appointment._actualEndTime, startDate, endDate) &&
              !_isAppointmentStartDateWithinVisibleDateRange(
                  appointment._actualStartTime, startDate, endDate)) {
            //// Check the spanned appointment start and end date not in current visible dates. example visible date 21 to 27 and
            //// the appointment start and end date as 18 and 28.
            for (int i = 0; i < 3; i++) {
              final Appointment spannedAppointment = _copy(appointment);
              if (i == 0) {
                final DateTime date = startDate.add(const Duration(days: -1));
                spannedAppointment._actualEndTime =
                    DateTime(date.year, date.month, date.day, 23, 59, 59);
              } else if (i == 1) {
                spannedAppointment._actualStartTime = DateTime(
                    startDate.year, startDate.month, startDate.day, 0, 0, 0);
                spannedAppointment._actualEndTime = DateTime(
                    endDate.year, endDate.month, endDate.day, 23, 59, 59);
              } else {
                final DateTime date = endDate.add(const Duration(days: 1));
                spannedAppointment._actualStartTime =
                    DateTime(date.year, date.month, date.day, 0, 0, 0);
              }

              spannedAppointment.startTime = spannedAppointment.isAllDay
                  ? appointment._actualStartTime
                  : _convertTimeToAppointmentTimeZone(
                      appointment._actualStartTime,
                      appointment.startTimeZone,
                      calendarTimeZone);
              spannedAppointment.endTime = spannedAppointment.isAllDay
                  ? appointment._actualEndTime
                  : _convertTimeToAppointmentTimeZone(
                      appointment._actualEndTime,
                      appointment.endTimeZone,
                      calendarTimeZone);

              // Adding Spanned Appointment only when the Appointment range within the VisibleDate
              if (_isAppointmentInVisibleDateRange(
                  spannedAppointment, startDate, endDate)) {
                spannedAppointment._isSpanned = _isSpanned(spannedAppointment);
                appointmentColl.add(spannedAppointment);
              }
            }
          } else {
            appointment._isSpanned = _isSpanned(appointment);
            appointmentColl.add(appointment);
          }
        } else {
          appointmentColl.add(appointment);
        }
      }

      continue;
    }

    _getRecurrenceAppointments(
        appointment, appointmentColl, startDate, endDate, calendarTimeZone);
  }

  return appointmentColl;
}

Appointment _cloneRecurrenceAppointment(Appointment appointment,
    int recurrenceIndex, DateTime recursiveDate, String calendarTimeZone) {
  final Appointment occurrenceAppointment = _copy(appointment);
//// Recursive DataContext has been set based on custom data for AppointmentTemplate added.
  occurrenceAppointment._actualStartTime = recursiveDate;
  occurrenceAppointment.startTime = occurrenceAppointment.isAllDay
      ? occurrenceAppointment._actualStartTime
      : _convertTimeToAppointmentTimeZone(
          occurrenceAppointment._actualStartTime,
          occurrenceAppointment.startTimeZone,
          calendarTimeZone);

  final int minutes = appointment._actualEndTime
      .difference(appointment._actualStartTime)
      .inMinutes;
  occurrenceAppointment._actualEndTime =
      occurrenceAppointment._actualStartTime.add(Duration(minutes: minutes));
  occurrenceAppointment.endTime = occurrenceAppointment.isAllDay
      ? occurrenceAppointment._actualEndTime
      : _convertTimeToAppointmentTimeZone(occurrenceAppointment._actualEndTime,
          occurrenceAppointment.endTimeZone, calendarTimeZone);
  occurrenceAppointment._isSpanned = _isSpanned(occurrenceAppointment) &&
      (occurrenceAppointment.endTime
              .difference(occurrenceAppointment.startTime)
              .inDays >
          0);

  return occurrenceAppointment;
}

List<Appointment> _generateCalendarAppointments(
    CalendarDataSource calendarData, SfCalendar calendar,
    [List<dynamic> appointments]) {
  if (calendarData == null) {
    return null;
  }

  final List<dynamic> dataSource = appointments ?? calendarData.appointments;
  if (dataSource == null) {
    return null;
  }

  final List<Appointment> calendarAppointmentCollection = <Appointment>[];
  if (dataSource.isNotEmpty &&
      dataSource[0].runtimeType.toString() == 'Appointment') {
    for (int i = 0; i < dataSource.length; i++) {
      final Appointment item = dataSource[i];
      final DateTime appStartTime = item.startTime;
      final DateTime appEndTime = item.endTime;
      item._data = item;
      item._actualStartTime = !item.isAllDay
          ? _convertTimeToAppointmentTimeZone(
              item.startTime, item.startTimeZone, calendar.timeZone)
          : item.startTime;
      item._actualEndTime = !item.isAllDay
          ? _convertTimeToAppointmentTimeZone(
              item.endTime, item.endTimeZone, calendar.timeZone)
          : item.endTime;
      _updateTimeForInvalidEndTime(item, calendar.timeZone);
      calendarAppointmentCollection.add(item);

      item._isSpanned =
          _isSpanned(item) && (appEndTime.difference(appStartTime).inDays > 0);
    }
  } else {
    for (int i = 0; i < dataSource.length; i++) {
      final dynamic item = dataSource[i];
      final Appointment app = _createAppointment(item, calendar);

      final DateTime appStartTime = app.startTime;
      final DateTime appEndTime = app.endTime;
      app._isSpanned =
          _isSpanned(app) && (appEndTime.difference(appStartTime).inDays > 0);
      calendarAppointmentCollection.add(app);
    }
  }

  return calendarAppointmentCollection;
}

Appointment _createAppointment(Object appointmentObject, SfCalendar calendar) {
  final Appointment app = Appointment();
  final int index = calendar.dataSource.appointments.indexOf(appointmentObject);
  app.startTime = calendar.dataSource.getStartTime(index);
  app.endTime = calendar.dataSource.getEndTime(index);
  app.subject = calendar.dataSource.getSubject(index);
  app.isAllDay = calendar.dataSource.isAllDay(index);
  app.color = calendar.dataSource.getColor(index);
  app.notes = calendar.dataSource.getNotes(index);
  app.location = calendar.dataSource.getLocation(index);
  app.startTimeZone = calendar.dataSource.getStartTimeZone(index);
  app.endTimeZone = calendar.dataSource.getEndTimeZone(index);
  app.recurrenceRule = calendar.dataSource.getRecurrenceRule(index);
  app.recurrenceExceptionDates =
      calendar.dataSource.getRecurrenceExceptionDates(index);
  app._data = appointmentObject;
  app._actualStartTime = !app.isAllDay
      ? _convertTimeToAppointmentTimeZone(
          app.startTime, app.startTimeZone, calendar.timeZone)
      : app.startTime;
  app._actualEndTime = !app.isAllDay
      ? _convertTimeToAppointmentTimeZone(
          app.endTime, app.endTimeZone, calendar.timeZone)
      : app.endTime;
  _updateTimeForInvalidEndTime(app, calendar.timeZone);
  return app;
}

void _updateTimeForInvalidEndTime(
    Appointment appointment, String scheduleTimeZone) {
  if (appointment._actualEndTime.isBefore(appointment._actualStartTime) &&
      !appointment.isAllDay) {
    appointment.endTime = _convertTimeToAppointmentTimeZone(
        appointment._actualStartTime.add(const Duration(minutes: 30)),
        appointment.endTimeZone,
        scheduleTimeZone);
    appointment._actualEndTime = !appointment.isAllDay
        ? _convertTimeToAppointmentTimeZone(
            appointment.endTime, appointment.endTimeZone, scheduleTimeZone)
        : appointment.endTime;
  }
}

void _getRecurrenceAppointments(
    Appointment appointment,
    List<Appointment> appointments,
    DateTime visibleStartDate,
    DateTime visibleEndDate,
    String scheduleTimeZone) {
  final DateTime appStartTime = appointment._actualStartTime;
  dynamic recurrenceIndex = 0;
  if (appStartTime.isAfter(visibleEndDate)) {
    return;
  }

  String rule = appointment.recurrenceRule;
  if (!rule.contains('COUNT') && !rule.contains('UNTIL')) {
    final DateFormat formatter = DateFormat('yyyyMMdd');
    final String newSubString = ';UNTIL=' + formatter.format(visibleEndDate);
    rule = rule + newSubString;
  }

  List<DateTime> recursiveDates;
  DateTime endDate;
  final dynamic ruleSeparator = <String>['=', ';', ','];
  final List<String> rrule =
      _splitRule(appointment.recurrenceRule, ruleSeparator);
  if (appointment.recurrenceRule.contains('UNTIL')) {
    final dynamic untilValue = rrule[rrule.indexOf('UNTIL') + 1];
    //DateFormat formatter = DateFormat("yyyyMMdd");
    // endDate = DateTime.ParseExact(untilValue, "yyyyMMdd", CultureInfo.CurrentCulture);
    endDate = DateTime.parse(untilValue);
    endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
  } else if (appointment.recurrenceRule.contains('COUNT')) {
    recursiveDates = _getRecurrenceDateTimeCollection(
        appointment.recurrenceRule, appointment._actualStartTime);
    endDate = recursiveDates.last;

    endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
  }

  if ((appointment.recurrenceRule.contains('UNTIL') ||
          appointment.recurrenceRule.contains('COUNT')) &&
      !(appStartTime.isBefore(visibleEndDate) &&
          visibleStartDate.isBefore(endDate))) {
    return;
  }

  recursiveDates = _getRecurrenceDateTimeCollection(
      rule, appointment._actualStartTime,
      specificStartDate: visibleStartDate, specificEndDate: visibleEndDate);

  for (int j = 0; j < recursiveDates.length; j++) {
    final DateTime recursiveDate = recursiveDates[j];
    if (appointment.recurrenceExceptionDates != null) {
      bool isDateContains = false;
      for (int i = 0; i < appointment.recurrenceExceptionDates.length; i++) {
        final DateTime date = _convertTimeToAppointmentTimeZone(
            appointment.recurrenceExceptionDates[i], '', scheduleTimeZone);
        if (date.year == recursiveDate.year &&
            date.month == recursiveDate.month &&
            date.day == recursiveDate.day) {
          isDateContains = true;
          break;
        }
      }
      if (isDateContains) {
        continue;
      }
    }

    final Appointment occurrenceAppointment = _cloneRecurrenceAppointment(
        appointment, recurrenceIndex, recursiveDate, scheduleTimeZone);
    recurrenceIndex++;
    appointments.add(occurrenceAppointment);
  }
}

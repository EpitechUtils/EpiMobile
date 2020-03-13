part of calendar;

_AppointmentView _getAppointmentView(
    Appointment appointment, _AppointmentPainter _appointmentPainter) {
  _AppointmentView appointmentRenderer;
  for (int i = 0; i < _appointmentPainter._appointmentCollection.length; i++) {
    final _AppointmentView view = _appointmentPainter._appointmentCollection[i];
    if (view.appointment == null) {
      appointmentRenderer = view;
      break;
    }
  }

  if (appointmentRenderer == null) {
    appointmentRenderer = _AppointmentView();
    appointmentRenderer.appointment = appointment;
    appointmentRenderer.canReuse = false;
    _appointmentPainter._appointmentCollection.add(appointmentRenderer);
  }

  appointmentRenderer.appointment = appointment;
  appointmentRenderer.canReuse = false;
  return appointmentRenderer;
}

void _createVisibleAppointments(_AppointmentPainter _appointmentPainter) {
  for (int i = 0; i < _appointmentPainter._appointmentCollection.length; i++) {
    final _AppointmentView appointmentView =
        _appointmentPainter._appointmentCollection[i];
    appointmentView.endIndex = -1;
    appointmentView.startIndex = -1;
    appointmentView.isSpanned = false;
    appointmentView.position = -1;
    appointmentView.maxPositions = 0;
    appointmentView.canReuse = true;
  }

  if (_appointmentPainter._visibleAppointments == null) {
    return;
  }

  for (int i = 0; i < _appointmentPainter._visibleAppointments.length; i++) {
    final Appointment appointment = _appointmentPainter._visibleAppointments[i];
    if (!appointment._isSpanned &&
        appointment._actualStartTime.day == appointment._actualEndTime.day &&
        appointment._actualStartTime.month ==
            appointment._actualEndTime.month) {
      final _AppointmentView appointmentView =
          _createAppointmentView(_appointmentPainter);
      appointmentView.appointment = appointment;
      appointmentView.canReuse = false;
      appointmentView.startIndex =
          _getDateIndex(appointment._actualStartTime, _appointmentPainter);
      if (appointmentView.startIndex == -1) {
        appointmentView.startIndex = 0;
      }

      appointmentView.endIndex =
          _getDateIndex(appointment._actualEndTime, _appointmentPainter);
      if (appointmentView.endIndex == -1) {
        appointmentView.endIndex = 41;
      }

      if (!_appointmentPainter._appointmentCollection
          .contains(appointmentView)) {
        _appointmentPainter._appointmentCollection.add(appointmentView);
      }
    } else {
      final _AppointmentView appointmentView =
          _createAppointmentView(_appointmentPainter);
      appointmentView.appointment = appointment;
      appointmentView.canReuse = false;
      appointmentView.startIndex =
          _getDateIndex(appointment._actualStartTime, _appointmentPainter);
      if (appointmentView.startIndex == -1) {
        appointmentView.startIndex = 0;
      }

      appointmentView.endIndex =
          _getDateIndex(appointment._actualEndTime, _appointmentPainter);
      if (appointmentView.endIndex == -1) {
        appointmentView.endIndex = 41;
      }

      _createAppointmentInfoForSpannedAppointment(
          appointmentView, _appointmentPainter);
    }
  }
}

void _createAppointmentInfoForSpannedAppointment(
    _AppointmentView appointmentView, _AppointmentPainter _appointmentPainter) {
  if (appointmentView.startIndex ~/ 7 != appointmentView.endIndex ~/ 7) {
    final int endIndex = appointmentView.endIndex;
    appointmentView.endIndex =
        ((((appointmentView.startIndex ~/ 7) + 1) * 7) - 1).toInt();
    appointmentView.isSpanned = true;
    if (_appointmentPainter._appointmentCollection != null &&
        !_appointmentPainter._appointmentCollection.contains(appointmentView)) {
      _appointmentPainter._appointmentCollection.add(appointmentView);
    }

    final _AppointmentView appointmentView1 =
        _createAppointmentView(_appointmentPainter);
    appointmentView1.appointment = appointmentView.appointment;
    appointmentView1.canReuse = false;
    appointmentView1.startIndex = appointmentView.endIndex + 1;
    appointmentView1.endIndex = endIndex;
    _createAppointmentInfoForSpannedAppointment(
        appointmentView1, _appointmentPainter);
  } else {
    appointmentView.isSpanned = true;
    if (!_appointmentPainter._appointmentCollection.contains(appointmentView)) {
      _appointmentPainter._appointmentCollection.add(appointmentView);
    }
  }
}

int _orderAppointmentViewBySpanned(
    _AppointmentView _appointmentView1, _AppointmentView _appointmentView2) {
  final int boolValue1 = _appointmentView1.isSpanned ? -1 : 1;
  final int boolValue2 = _appointmentView2.isSpanned ? -1 : 1;

  if (boolValue1 == boolValue2 &&
      _appointmentView2.startIndex == _appointmentView1.startIndex) {
    return (_appointmentView2.endIndex - _appointmentView2.startIndex)
        .compareTo(_appointmentView1.endIndex - _appointmentView1.startIndex);
  }

  return boolValue1.compareTo(boolValue2);
}

void _setAppointmentPosition(List<_AppointmentView> appointmentViewCollection,
    _AppointmentView appointmentView, int viewIndex) {
  for (int j = 0; j < appointmentViewCollection.length; j++) {
    //// Break when the collection reaches current appointment
    if (j >= viewIndex) {
      break;
    }

    final _AppointmentView prevAppointmentView = appointmentViewCollection[j];
    if (!_isInterceptAppointments(appointmentView, prevAppointmentView)) {
      continue;
    }

    if (appointmentView.position == prevAppointmentView.position) {
      appointmentView.position = appointmentView.position + 1;
      appointmentView.maxPositions = appointmentView.position;
      prevAppointmentView.maxPositions = appointmentView.position;
      _setAppointmentPosition(
          appointmentViewCollection, appointmentView, viewIndex);
      break;
    }
  }
}

bool _isInterceptAppointments(
    _AppointmentView appointmentView1, _AppointmentView appointmentView2) {
  if (appointmentView1.startIndex <= appointmentView2.startIndex &&
          appointmentView1.endIndex >= appointmentView2.startIndex ||
      appointmentView2.startIndex <= appointmentView1.startIndex &&
          appointmentView2.endIndex >= appointmentView1.startIndex) {
    return true;
  }

  if (appointmentView1.startIndex <= appointmentView2.endIndex &&
          appointmentView1.endIndex >= appointmentView2.endIndex ||
      appointmentView2.startIndex <= appointmentView1.endIndex &&
          appointmentView2.endIndex >= appointmentView1.endIndex) {
    return true;
  }

  return false;
}

void _updateAppointmentPosition(_AppointmentPainter _appointmentPainter) {
  _appointmentPainter._appointmentCollection
      .sort((_AppointmentView app1, _AppointmentView app2) {
    if (app1.appointment?._actualStartTime != null &&
        app2.appointment?._actualStartTime != null) {
      return app1.appointment._actualStartTime
          .compareTo(app2.appointment._actualStartTime);
    }

    return 0;
  });
  _appointmentPainter._appointmentCollection.sort(
      (_AppointmentView app1, _AppointmentView app2) =>
          _orderAppointmentViewBySpanned(app1, app2));

  for (int j = 0; j < _appointmentPainter._appointmentCollection.length; j++) {
    final _AppointmentView appointmentView =
        _appointmentPainter._appointmentCollection[j];
    appointmentView.position = 1;
    appointmentView.maxPositions = 1;
    _setAppointmentPosition(
        _appointmentPainter._appointmentCollection, appointmentView, j);
  }
}

int _getDateIndex(DateTime date, _AppointmentPainter _appointmentPainter) {
  DateTime dateTime = _appointmentPainter
      ._visibleDates[_appointmentPainter._visibleDates.length - 7];
  int row = 0;
  for (int i = _appointmentPainter._visibleDates.length - 7; i >= 0; i -= 7) {
    DateTime currentDate = _appointmentPainter._visibleDates[i];
    currentDate = DateTime(currentDate.year, currentDate.month, currentDate.day,
        currentDate.hour, currentDate.minute, currentDate.second);
    if (currentDate.isBefore(date) ||
        (currentDate.day == date.day &&
            currentDate.month == date.month &&
            currentDate.year == date.year)) {
      dateTime = currentDate;
      row = i ~/ 7;
      break;
    }
  }

  final DateTime endDateTime = dateTime.add(const Duration(days: 6));
  int currentViewIndex = 0;
  while (dateTime.isBefore(endDateTime) ||
      (dateTime.day == endDateTime.day &&
          dateTime.month == endDateTime.month &&
          dateTime.year == endDateTime.year)) {
    if (dateTime.day == date.day &&
        dateTime.month == date.month &&
        dateTime.year == date.year) {
      return ((row * 7) + currentViewIndex).toInt();
    }

    currentViewIndex++;
    dateTime = dateTime.add(const Duration(days: 1));
  }

  return -1;
}

_AppointmentView _createAppointmentView(
    _AppointmentPainter _appointmentPainter) {
  _AppointmentView appointmentView;
  for (int i = 0; i < _appointmentPainter._appointmentCollection.length; i++) {
    final _AppointmentView view = _appointmentPainter._appointmentCollection[i];
    if (view.canReuse) {
      appointmentView = view;
      break;
    }
  }

  appointmentView = appointmentView ?? _AppointmentView();

  appointmentView.endIndex = -1;
  appointmentView.startIndex = -1;
  appointmentView.position = -1;
  appointmentView.maxPositions = 0;
  appointmentView.isSpanned = false;
  appointmentView.appointment = null;
  appointmentView.canReuse = true;
  return appointmentView;
}

void _updateAppointment(_AppointmentPainter _appointmentPainter) {
  _createVisibleAppointments(_appointmentPainter);
  if (_appointmentPainter._visibleAppointments != null &&
      _appointmentPainter._visibleAppointments.isNotEmpty) {
    _updateAppointmentPosition(_appointmentPainter);
  }
}

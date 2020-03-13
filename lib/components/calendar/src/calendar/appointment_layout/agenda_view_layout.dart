part of calendar;

class _AgendaViewPainter extends CustomPainter {
  _AgendaViewPainter(this._monthViewSettings, this._selectedDate,
      this._timeZone, this._appointments);

  final MonthViewSettings _monthViewSettings;
  final DateTime _selectedDate;
  final String _timeZone;
  final List<Appointment> _appointments;
  Paint _rectPainter;
  TextPainter _textPainter;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    _rectPainter = _rectPainter ?? Paint();
    _rectPainter.isAntiAlias = true;
    double yPosition = 5;
    const double xPosition = 5;
    const int padding = 5;
    List<Appointment> agendaAppointments;
    if (_selectedDate != null) {
      agendaAppointments =
          _getSelectedDateAppointments(_appointments, _timeZone, _selectedDate);
    }

    if (_selectedDate == null ||
        agendaAppointments == null ||
        agendaAppointments.isEmpty) {
      final TextSpan span = TextSpan(
        text: _selectedDate == null ? 'No selected date' : 'No events',
        style:
            TextStyle(color: Colors.grey, fontSize: 15, fontFamily: 'Roboto'),
      );
      _textPainter = _textPainter ?? TextPainter();
      _textPainter.text = span;
      _textPainter.maxLines = 1;
      _textPainter.textDirection = TextDirection.ltr;
      _textPainter.textAlign = TextAlign.left;
      _textPainter.textWidthBasis = TextWidthBasis.longestLine;

      _textPainter.layout(minWidth: 0, maxWidth: size.width - 10);
      _textPainter.paint(canvas, Offset(xPosition, yPosition + padding));
      return;
    }

    agendaAppointments.sort((Appointment app1, Appointment app2) =>
        app1._actualStartTime.compareTo(app2._actualStartTime));
    agendaAppointments.sort((Appointment app1, Appointment app2) =>
        _orderAppointmentsAscending(app1.isAllDay, app2.isAllDay));
    TextStyle appointmentTextStyle =
        _monthViewSettings.agendaStyle.appointmentTextStyle;
    appointmentTextStyle ??=
        TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Roboto');
    //// Draw Appointments
    for (int i = 0; i < agendaAppointments.length; i++) {
      final Appointment _appointment = agendaAppointments[i];
      _rectPainter.color = _appointment.color;
      final double appointmentHeight = _appointment.isAllDay
          ? _monthViewSettings.agendaItemHeight / 2
          : _monthViewSettings.agendaItemHeight;
      final Rect rect = Rect.fromLTWH(xPosition, yPosition,
          size.width - xPosition - padding, appointmentHeight);
      final Radius cornerRadius = Radius.circular(
          (appointmentHeight * 0.1) > 5 ? 5 : (appointmentHeight * 0.1));
      canvas.drawRRect(
          RRect.fromRectAndRadius(rect, cornerRadius), _rectPainter);

      TextSpan span =
          TextSpan(text: _appointment.subject, style: appointmentTextStyle);
      final TextPainter painter = TextPainter(
          text: span,
          maxLines: 1,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.left,
          textWidthBasis: TextWidthBasis.longestLine);

      //// Draw Appointments except All day appointment
      if (!_appointment.isAllDay) {
        painter.layout(
            minWidth: 0, maxWidth: size.width - (2 * padding) - xPosition);
        painter.paint(
            canvas,
            Offset(xPosition + padding,
                yPosition + (appointmentHeight / 2) - painter.height));

        final String format = _isSameDate(
                _appointment._actualStartTime, _appointment._actualEndTime)
            ? 'hh:mm a'
            : 'MMM dd, hh:mm a';
        span = TextSpan(
            text: DateFormat(format).format(_appointment._actualStartTime) +
                ' - ' +
                DateFormat(format).format(_appointment._actualEndTime),
            style: appointmentTextStyle);
        painter.text = span;

        painter.layout(
            minWidth: 0, maxWidth: size.width - (2 * padding) - xPosition);
        painter.paint(canvas,
            Offset(xPosition + padding, yPosition + (appointmentHeight / 2)));
      } else {
        //// Draw All day appointment
        painter.layout(minWidth: 0, maxWidth: size.width - 10 - xPosition);
        painter.paint(
            canvas,
            Offset(xPosition + 5,
                yPosition + ((appointmentHeight - painter.height) / 2)));
      }

      if (_appointment.recurrenceRule != null &&
          _appointment.recurrenceRule.isNotEmpty) {
        double textSize = appointmentTextStyle.fontSize;
        if (rect.width < textSize || rect.height < textSize) {
          textSize = rect.width > rect.height ? rect.height : rect.width;
        }

        final TextSpan icon =
            _getRecurrenceIcon(appointmentTextStyle.color, textSize);
        painter.text = icon;
        painter.layout(
            minWidth: 0, maxWidth: size.width - (2 * padding) - xPosition);
        canvas.drawRRect(
            RRect.fromRectAndRadius(
                Rect.fromLTRB(rect.right - textSize - 8, rect.top, rect.right,
                    rect.bottom),
                cornerRadius),
            _rectPainter);
        // Value 8 added as a right side padding for the recurrence icon in the agenda view
        painter.paint(
            canvas,
            Offset(rect.right - textSize - 8,
                rect.top + (rect.height - painter.height) / 2));
      }

      yPosition += appointmentHeight + padding;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _AgendaDateTimePainter extends CustomPainter {
  _AgendaDateTimePainter(this._selectedDate, this._monthViewSettings,
      this._isDark, this._todayHighlightColor);

  final DateTime _selectedDate;
  final MonthViewSettings _monthViewSettings;
  final bool _isDark;
  final Color _todayHighlightColor;
  Paint _linePainter;
  TextPainter _textPainter;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    _linePainter = _linePainter ?? Paint();
    _linePainter.isAntiAlias = true;
    const double padding = 5;
    if (_selectedDate == null) {
      return;
    }

    final bool isToday = _isSameDate(_selectedDate, DateTime.now());
    TextStyle dayTextStyle = _monthViewSettings.agendaStyle.dayTextStyle;
    TextStyle dateTextStyle = _monthViewSettings.agendaStyle.dateTextStyle;
    final Color selectedDayTextColor = isToday
        ? _todayHighlightColor
        : dayTextStyle != null
            ? dayTextStyle.color
            : _isDark ? Colors.white70 : Colors.black54;
    final Color selectedDateTextColor = isToday
        ? Colors.white
        : dateTextStyle != null
            ? dateTextStyle.color
            : _isDark ? Colors.white : Colors.black;
    dayTextStyle = dayTextStyle != null
        ? dayTextStyle.copyWith(color: selectedDayTextColor)
        : TextStyle(
            color: selectedDayTextColor,
            fontWeight: FontWeight.w500,
            fontSize: 10,
            fontFamily: 'Roboto');
    dateTextStyle = dateTextStyle != null
        ? dateTextStyle.copyWith(color: selectedDateTextColor)
        : TextStyle(
            color: selectedDateTextColor,
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.normal);

    //// Draw Weekday
    TextSpan span = TextSpan(
        text: DateFormat('EEE').format(_selectedDate).toUpperCase().toString(),
        style: dayTextStyle);
    _textPainter = _textPainter ?? TextPainter();
    _textPainter.text = span;
    _textPainter.maxLines = 1;
    _textPainter.textDirection = TextDirection.ltr;
    _textPainter.textAlign = TextAlign.left;
    _textPainter.textWidthBasis = TextWidthBasis.parent;

    _textPainter.layout(minWidth: 0, maxWidth: size.width);
    _textPainter.paint(
        canvas,
        Offset(
            padding + ((size.width - (2 * padding) - _textPainter.width) / 2),
            padding));

    final double weekDayHeight = padding + _textPainter.height;
    //// Draw Date
    span = TextSpan(text: _selectedDate.day.toString(), style: dateTextStyle);
    _textPainter = _textPainter ?? TextPainter();
    _textPainter.text = span;
    _textPainter.maxLines = 1;
    _textPainter.textDirection = TextDirection.ltr;
    _textPainter.textAlign = TextAlign.left;
    _textPainter.textWidthBasis = TextWidthBasis.parent;

    _textPainter.layout(minWidth: 0, maxWidth: size.width);
    final double xPosition =
        padding + ((size.width - (2 * padding) - _textPainter.width) / 2);
    double yPosition = weekDayHeight;
    if (isToday) {
      yPosition = weekDayHeight + padding;
      _linePainter.color = _todayHighlightColor;
      canvas.drawCircle(
          Offset(xPosition + (_textPainter.width / 2),
              yPosition + (_textPainter.height / 2)),
          _textPainter.width > _textPainter.height
              ? (_textPainter.width / 2) + padding
              : (_textPainter.height / 2) + padding,
          _linePainter);
    }

    _textPainter.paint(canvas, Offset(xPosition, yPosition));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

part of calendar;

class _AllDayAppointmentPainter extends CustomPainter {
  _AllDayAppointmentPainter(
      this._calendar,
      this._visibleDates,
      this._visibleAppointment,
      this._timeLabelWidth,
      this._allDayPainterHeight,
      this._isExpandable,
      this._isExpanding,
      this._isDark,
      this._repaintNotifier,
      {this.updateCalendarState})
      : super(repaint: _repaintNotifier);

  final SfCalendar _calendar;
  final List<DateTime> _visibleDates;
  final List<Appointment> _visibleAppointment;
  final ValueNotifier<_AppointmentView> _repaintNotifier;
  final _UpdateCalendarState updateCalendarState;
  final double _timeLabelWidth;
  final double _allDayPainterHeight;
  final bool _isDark;

  //// is expandable variable used to indicate whether the all day layout expandable or not.
  final bool _isExpandable;

  //// is expanding variable used to identify the animation currently running or not.
  //// It is used to restrict the expander icon show on initial animation.
  final bool _isExpanding;
  double cellWidth, cellHeight;
  Paint _rectPainter;
  TextPainter _textPainter;
  Paint _linePainter;
  TextPainter _expanderTextPainter;
  BoxPainter _boxPainter;
  final _UpdateCalendarStateDetails _updateCalendarStateDetails =
      _UpdateCalendarStateDetails();

  @override
  void paint(Canvas canvas, Size size) {
    _updateCalendarStateDetails._allDayAppointmentViewCollection = null;
    _updateCalendarStateDetails._currentViewVisibleDates = null;
    updateCalendarState(_updateCalendarStateDetails);
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    _rectPainter = _rectPainter ?? Paint();
    _updateCalendarStateDetails._allDayAppointmentViewCollection =
        _updateCalendarStateDetails._allDayAppointmentViewCollection ??
            <_AppointmentView>[];

    if (_calendar.view == CalendarView.day) {
      _linePainter ??= Paint();
      _linePainter.strokeWidth = 0.5;
      _linePainter.strokeCap = StrokeCap.round;
      _linePainter.color = _calendar.cellBorderColor != null
          ? _calendar.cellBorderColor
          : _isDark ? Colors.white70 : Colors.black.withOpacity(0.16);
      //// Decrease the x position by 0.5 because draw the end point of the view
      /// draws half of the line to current view and hides another half.
      canvas.drawLine(Offset(_timeLabelWidth - 0.5, 0),
          Offset(_timeLabelWidth - 0.5, size.height), _linePainter);
    }

    if (_visibleDates != _updateCalendarStateDetails._currentViewVisibleDates) {
      return;
    }

    _rectPainter.isAntiAlias = true;
    cellWidth = (size.width - _timeLabelWidth) / _visibleDates.length;
    cellHeight = size.height;
    const double textPadding = 3;
    int maxPosition = 0;
    if (_updateCalendarStateDetails
        ._allDayAppointmentViewCollection.isNotEmpty) {
      maxPosition = _updateCalendarStateDetails._allDayAppointmentViewCollection
          .reduce(
              (_AppointmentView currentAppview, _AppointmentView nextAppview) =>
                  currentAppview.maxPositions > nextAppview.maxPositions
                      ? currentAppview
                      : nextAppview)
          .maxPositions;
    }

    if (maxPosition == -1) {
      maxPosition = 0;
    }

    final int _position = _allDayPainterHeight ~/ _kAllDayAppointmentHeight;
    for (int i = 0;
        i < _updateCalendarStateDetails._allDayAppointmentViewCollection.length;
        i++) {
      final _AppointmentView _appointmentView =
          _updateCalendarStateDetails._allDayAppointmentViewCollection[i];
      if (_appointmentView.canReuse) {
        continue;
      }

      final Appointment _appointment = _appointmentView.appointment;
      final RRect rect = RRect.fromRectAndRadius(
          Rect.fromLTRB(
              _timeLabelWidth + (_appointmentView.startIndex * cellWidth),
              (_kAllDayAppointmentHeight * _appointmentView.position)
                  .toDouble(),
              (_appointmentView.endIndex * cellWidth) +
                  _timeLabelWidth -
                  textPadding,
              ((_kAllDayAppointmentHeight * _appointmentView.position) +
                      _kAllDayAppointmentHeight -
                      1)
                  .toDouble()),
          const Radius.circular((_kAllDayAppointmentHeight * 0.1) > 2
              ? 2
              : (_kAllDayAppointmentHeight * 0.1)));

      _appointmentView.appointmentRect = rect;
      if (rect.left < _timeLabelWidth - 1 ||
          rect.right > size.width + 1 ||
          (rect.bottom > _allDayPainterHeight - _kAllDayAppointmentHeight &&
              maxPosition > _position)) {
        continue;
      }

      _rectPainter.color = _appointment.color;
      canvas.drawRRect(rect, _rectPainter);
      final TextSpan span = TextSpan(
        text: _appointment.subject,
        style: _calendar.appointmentTextStyle,
      );
      _textPainter = _textPainter ??
          TextPainter(
              textDirection: TextDirection.ltr,
              maxLines: 1,
              textAlign: TextAlign.left,
              textWidthBasis: TextWidthBasis.longestLine);
      _textPainter.text = span;

      _textPainter.layout(
          minWidth: 0,
          maxWidth:
              rect.width - textPadding >= 0 ? rect.width - textPadding : 0);
      if (_textPainter.maxLines == 1 && _textPainter.height > rect.height) {
        continue;
      }

      _textPainter.paint(
          canvas,
          Offset(rect.left + textPadding,
              rect.top + (rect.height - _textPainter.height) / 2));
      if (_appointment.recurrenceRule != null &&
          _appointment.recurrenceRule.isNotEmpty) {
        double textSize = _calendar.appointmentTextStyle.fontSize;
        if (rect.width < textSize || rect.height < textSize) {
          textSize = rect.width > rect.height ? rect.height : rect.width;
        }

        final TextSpan icon =
            _getRecurrenceIcon(_calendar.appointmentTextStyle.color, textSize);
        _textPainter.text = icon;
        _textPainter.layout(
            minWidth: 0,
            maxWidth:
                rect.width - textPadding >= 0 ? rect.width - textPadding : 0);
        canvas.drawRRect(
            RRect.fromRectAndRadius(
                Rect.fromLTRB(
                    rect.right - textSize, rect.top, rect.right, rect.bottom),
                rect.brRadius),
            _rectPainter);
        _textPainter.paint(
            canvas,
            Offset(rect.right - textSize - 1,
                rect.top + (rect.height - _textPainter.height) / 2));
      }

      if (_repaintNotifier.value != null &&
          _repaintNotifier.value.appointment != null &&
          _repaintNotifier.value.appointment == _appointmentView.appointment) {
        Decoration _selectionDecoration = _calendar.selectionDecoration;
        _selectionDecoration ??= BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
              color: const Color.fromARGB(255, 68, 140, 255), width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(1)),
          shape: BoxShape.rectangle,
        );

        Rect rect = _appointmentView.appointmentRect.outerRect;
        rect = Rect.fromLTRB(rect.left, rect.top, rect.right, rect.bottom);
        _boxPainter = _selectionDecoration.createBoxPainter();
        _boxPainter.paint(canvas, Offset(rect.left, rect.top),
            ImageConfiguration(size: rect.size));
      }
    }

    if (_isExpandable && maxPosition > _position && !_isExpanding) {
      TextStyle textStyle = _calendar.viewHeaderStyle.dayTextStyle;
      textStyle ??= TextStyle(
          color: _isDark ? Colors.white : Colors.black87,
          fontSize: 11,
          fontWeight: FontWeight.w400,
          fontFamily: 'Roboto');
      _textPainter = _textPainter ??
          TextPainter(
              textDirection: TextDirection.ltr,
              maxLines: 1,
              textAlign: TextAlign.left,
              textWidthBasis: TextWidthBasis.longestLine);

      double startXPosition = _timeLabelWidth;
      double endXPosition = _timeLabelWidth + cellWidth;
      final double endYPosition =
          _allDayPainterHeight - _kAllDayAppointmentHeight;
      for (int i = 0; i < _visibleDates.length; i++) {
        int count = 0;
        final int leftPosition = startXPosition.toInt();
        final int rightPostion = endXPosition.toInt();
        for (_AppointmentView view
            in _updateCalendarStateDetails._allDayAppointmentViewCollection) {
          if (view.appointment == null) {
            continue;
          }

          final int rectLeftPosition = view.appointmentRect.left.toInt();
          final int rectRightPosition = view.appointmentRect.right.toInt();
          if (((rectLeftPosition >= leftPosition &&
                      rectLeftPosition < rightPostion) ||
                  (rectRightPosition > leftPosition &&
                      rectRightPosition < rightPostion) ||
                  (rectLeftPosition <= leftPosition &&
                      rectRightPosition > rightPostion)) &&
              view.appointmentRect.top >= endYPosition) {
            count++;
          }
        }

        if (count == 0) {
          startXPosition += cellWidth;
          endXPosition += cellWidth;
          continue;
        }

        final TextSpan span = TextSpan(
          text: '+ ' + count.toString(),
          style: textStyle,
        );
        _textPainter.text = span;
        _textPainter.layout(
            minWidth: 0,
            maxWidth:
                cellWidth - textPadding >= 0 ? cellWidth - textPadding : 0);

        _textPainter.paint(
            canvas,
            Offset(
                _timeLabelWidth + (i * cellWidth) + textPadding,
                endYPosition +
                    ((_kAllDayAppointmentHeight - _textPainter.height) / 2)));
        startXPosition += cellWidth;
        endXPosition += cellWidth;
      }
    }

    if (_isExpandable) {
      final TextSpan icon = TextSpan(
          text: String.fromCharCode(maxPosition <= _position ? 0xe5ce : 0xe5cf),
          style: TextStyle(
            color: _calendar.viewHeaderStyle != null &&
                    _calendar.viewHeaderStyle.dayTextStyle != null &&
                    _calendar.viewHeaderStyle.dayTextStyle.color != null
                ? _calendar.viewHeaderStyle.dayTextStyle.color
                : _isDark ? Colors.white70 : Colors.black54,
            fontSize: _calendar.viewHeaderStyle != null &&
                    _calendar.viewHeaderStyle.dayTextStyle != null &&
                    _calendar.viewHeaderStyle.dayTextStyle.fontSize != null
                ? _calendar.viewHeaderStyle.dayTextStyle.fontSize * 2
                : _kAllDayAppointmentHeight + 5,
            fontFamily: 'MaterialIcons',
          ));
      _expanderTextPainter ??= TextPainter(
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.left,
          maxLines: 1);
      _expanderTextPainter.text = icon;
      _expanderTextPainter.layout(minWidth: 0, maxWidth: _timeLabelWidth);
      _expanderTextPainter.paint(
          canvas,
          Offset(
              (_timeLabelWidth - _expanderTextPainter.width) / 2,
              _allDayPainterHeight -
                  _kAllDayAppointmentHeight +
                  (_kAllDayAppointmentHeight - _expanderTextPainter.height) /
                      2));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final _AllDayAppointmentPainter oldWidget = oldDelegate;
    return oldWidget._visibleDates != _visibleDates ||
        oldWidget._allDayPainterHeight != _allDayPainterHeight ||
        oldWidget._visibleAppointment != _visibleAppointment ||
        oldWidget._calendar.cellBorderColor != _calendar.cellBorderColor ||
        oldWidget._isDark != _isDark;
  }
}

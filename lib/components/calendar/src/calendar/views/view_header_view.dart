part of calendar;

class _ViewHeaderViewPainter extends CustomPainter {
  _ViewHeaderViewPainter(
      this._visibleDates,
      this._view,
      this._viewHeaderStyle,
      this._timeSlotViewSettings,
      this._timeLabelWidth,
      this._viewHeaderHeight,
      this._monthViewSettings,
      this._isDark,
      this._todayHighlightColor,
      this._cellBorderColor);

  final CalendarView _view;
  final ViewHeaderStyle _viewHeaderStyle;
  final TimeSlotViewSettings _timeSlotViewSettings;
  final MonthViewSettings _monthViewSettings;
  final List<DateTime> _visibleDates;
  final double _timeLabelWidth;
  final double _viewHeaderHeight;
  final bool _isDark;
  final Color _todayHighlightColor;
  final Color _cellBorderColor;
  DateTime _currentDate;
  String _dayText, _dateText;
  double _xPosition, _yPosition;
  Paint _circlePainter;
  Paint _linePainter;
  TextPainter _dayTextPainter, _dateTextPainter;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    double _width = size.width;
    _width = _getViewHeaderWidth(_width);

    TextStyle _viewHeaderDayStyle = _viewHeaderStyle.dayTextStyle;
    TextStyle _viewHeaderDateStyle = _viewHeaderStyle.dateTextStyle;

    /// Initializes the default text style for the texts in view header of calendar.
    _viewHeaderDayStyle ??= TextStyle(
        color: _isDark ? Colors.white : Colors.black87,
        fontSize: 11,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto');
    _viewHeaderDateStyle ??= TextStyle(
        color: _isDark ? Colors.white : Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto');

    final DateTime today = DateTime.now();
    final double _labelWidth = _view == CalendarView.day && _timeLabelWidth < 50
        ? 50
        : _timeLabelWidth;
    TextStyle dayTextStyle = _viewHeaderDayStyle;
    TextStyle dateTextStyle = _viewHeaderDateStyle;
    if (_view != CalendarView.month) {
      const double topPadding = 5;
      if (_view == CalendarView.day) {
        _width = _labelWidth;
        _linePainter ??= Paint();
        _linePainter.strokeWidth = 0.5;
        _linePainter.strokeCap = StrokeCap.round;
        _linePainter.color = _cellBorderColor != null
            ? _cellBorderColor
            : _isDark ? Colors.white70 : Colors.black.withOpacity(0.16);
        //// Decrease the x position by 0.5 because draw the end point of the view
        /// draws half of the line to current view and hides another half.
        if (_timeLabelWidth == _labelWidth) {
          canvas.drawLine(Offset(_labelWidth - 0.5, 0),
              Offset(_labelWidth - 0.5, size.height), _linePainter);
        }
      }

      _xPosition = _view == CalendarView.day ? 0 : _timeLabelWidth;
      _yPosition = 2;
      final double cellWidth = _width / _visibleDates.length;
      for (int i = 0; i < _visibleDates.length; i++) {
        _currentDate = _visibleDates[i];
        _dayText = DateFormat(_timeSlotViewSettings.dayFormat)
            .format(_currentDate)
            .toString()
            .toUpperCase();

        _updateViewHeaderFormat();

        _dateText = DateFormat(_timeSlotViewSettings.dateFormat)
            .format(_currentDate)
            .toString();
        final bool _isToday = _isSameDate(_currentDate, today);
        if (_isToday) {
          dayTextStyle =
              _viewHeaderDayStyle.copyWith(color: _todayHighlightColor);
          dateTextStyle = _viewHeaderDateStyle.copyWith(color: Colors.white);
        } else {
          dayTextStyle = _viewHeaderDayStyle;
          dateTextStyle = _viewHeaderDateStyle;
        }

        _updateDayTextPainter(dayTextStyle, _width);

        final TextSpan dateTextSpan = TextSpan(
          text: _dateText,
          style: dateTextStyle,
        );

        _dateTextPainter = _dateTextPainter ?? TextPainter();
        _dateTextPainter.text = dateTextSpan;
        _dateTextPainter.textDirection = TextDirection.ltr;
        _dateTextPainter.textAlign = TextAlign.left;
        _dateTextPainter.textWidthBasis = TextWidthBasis.longestLine;

        _dateTextPainter.layout(minWidth: 0, maxWidth: _width);

        /// To calculate the day start position by width and day painter
        final double dayXPosition = (cellWidth - _dayTextPainter.width) / 2;

        /// To calculate the date start position by width and date painter
        final double dateXPosition = (cellWidth - _dateTextPainter.width) / 2;

        _yPosition = size.height / 2 -
            (_dayTextPainter.height + topPadding + _dateTextPainter.height) / 2;

        _dayTextPainter.paint(
            canvas, Offset(_xPosition + dayXPosition, _yPosition));
        if (_isToday) {
          _drawTodayCircle(
              canvas,
              _xPosition + dateXPosition,
              _yPosition + topPadding + _dayTextPainter.height,
              _dateTextPainter);
        }

        _dateTextPainter.paint(
            canvas,
            Offset(_xPosition + dateXPosition,
                _yPosition + topPadding + _dayTextPainter.height));

        _xPosition += cellWidth;
      }
    } else {
      _xPosition = 0;
      _yPosition = 0;
      bool _hasToday = false;
      for (int i = 0; i < 7; i++) {
        _currentDate = _visibleDates[i];
        _dayText = DateFormat(_monthViewSettings.dayFormat)
            .format(_currentDate)
            .toString()
            .toUpperCase();

        _updateViewHeaderFormat();

        _hasToday = _monthViewSettings.numberOfWeeksInView > 0 &&
                _monthViewSettings.numberOfWeeksInView < 6
            ? true
            : _visibleDates[_visibleDates.length ~/ 2].month == today.month
                ? true
                : false;

        if (_hasToday &&
            _isWithInVisibleDateRange(_visibleDates, today) &&
            _currentDate.weekday == today.weekday) {
          dayTextStyle =
              _viewHeaderDayStyle.copyWith(color: _todayHighlightColor);
        } else {
          dayTextStyle = _viewHeaderDayStyle;
        }

        _updateDayTextPainter(dayTextStyle, _width);

        if (_yPosition == 0) {
          _yPosition = (_viewHeaderHeight - _dayTextPainter.height) / 2;
        }

        _dayTextPainter.paint(
            canvas,
            Offset(_xPosition + (_width / 2 - _dayTextPainter.width / 2),
                _yPosition));
        _xPosition += _width;
      }
    }
  }

  void _updateViewHeaderFormat() {
    if (_view != CalendarView.day && _view != CalendarView.month) {
      //// EE format value shows the week days as S, M, T, W, T, F, S.
      if (_timeSlotViewSettings.dayFormat == 'EE') {
        _dayText = _dayText[0];
      }
    } else if (_view == CalendarView.month) {
      //// EE format value shows the week days as S, M, T, W, T, F, S.
      if (_monthViewSettings.dayFormat == 'EE') {
        _dayText = _dayText[0];
      }
    }
  }

  void _updateDayTextPainter(TextStyle dayTextStyle, double _width) {
    final TextSpan dayTextSpan = TextSpan(
      text: _dayText,
      style: dayTextStyle,
    );

    _dayTextPainter = _dayTextPainter ?? TextPainter();
    _dayTextPainter.text = dayTextSpan;
    _dayTextPainter.textDirection = TextDirection.ltr;
    _dayTextPainter.textAlign = TextAlign.left;
    _dayTextPainter.textWidthBasis = TextWidthBasis.longestLine;

    _dayTextPainter.layout(minWidth: 0, maxWidth: _width);
  }

  double _getViewHeaderWidth(double _width) {
    if (_view != CalendarView.month) {
      if (_view == null || _view == CalendarView.day) {
        _width = _timeLabelWidth;
      } else {
        _width -= _timeLabelWidth;
      }
    } else {
      _width = _width / 7;
    }
    return _width;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final _ViewHeaderViewPainter oldWidget = oldDelegate;
    return oldWidget._visibleDates != _visibleDates ||
        oldWidget._viewHeaderStyle != _viewHeaderStyle ||
        oldWidget._viewHeaderHeight != _viewHeaderHeight ||
        oldWidget._todayHighlightColor != _todayHighlightColor ||
        oldWidget._timeSlotViewSettings != _timeSlotViewSettings ||
        oldWidget._monthViewSettings != _monthViewSettings ||
        oldWidget._cellBorderColor != _cellBorderColor ||
        oldWidget._isDark != _isDark;
  }

  //// draw today highlight circle in view header.
  void _drawTodayCircle(
      Canvas canvas, double x, double y, TextPainter dateTextPainter) {
    _circlePainter = _circlePainter ?? Paint();
    _circlePainter.color = _todayHighlightColor;
    const double _circlePadding = 3;
    final double painterWidth = dateTextPainter.width / 2;
    final double painterHeight = dateTextPainter.height / 2;
    final double radius =
        painterHeight > painterWidth ? painterHeight : painterWidth;
    canvas.drawCircle(Offset(x + painterWidth, y + painterHeight),
        radius + _circlePadding, _circlePainter);
  }
}

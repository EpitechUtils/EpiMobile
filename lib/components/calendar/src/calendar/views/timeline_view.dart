part of calendar;

class _TimelineView extends CustomPainter {
  _TimelineView(
      this._horizontalLinesCountPerView,
      this._visibleDates,
      this._timeLabelWidth,
      this._timeSlotViewSettings,
      this._timeIntervalHeight,
      this._cellBorderColor,
      this._isDark);

  final double _horizontalLinesCountPerView;
  final List<DateTime> _visibleDates;
  final double _timeLabelWidth;
  final TimeSlotViewSettings _timeSlotViewSettings;
  final double _timeIntervalHeight;
  final Color _cellBorderColor;
  final bool _isDark;
  double _x1, _x2, _y1, _y2;
  Paint _linePainter;
  TextPainter _textPainter;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    _x1 = 0;
    _x2 = size.width;
    _y1 = _timeIntervalHeight;
    _y2 = _timeIntervalHeight;
    _linePainter = _linePainter ?? Paint();
    _linePainter.strokeWidth = 0.5;
    _linePainter.strokeCap = StrokeCap.round;
    _linePainter.color = _cellBorderColor != null
        ? _cellBorderColor
        : _isDark ? Colors.white70 : Colors.black.withOpacity(0.16);
    _x1 = 0;
    _x2 = size.width;
    _y1 = _timeLabelWidth;
    _y2 = _timeLabelWidth;

    final Offset _start = Offset(_x1, _y1);
    final Offset _end = Offset(_x2, _y2);
    canvas.drawLine(_start, _end, _linePainter);

    _x1 = 0;
    _x2 = 0;
    _y2 = size.height;
    final List<Offset> points = <Offset>[];
    for (int i = 0;
        i < _horizontalLinesCountPerView * _visibleDates.length;
        i++) {
      _y1 = _timeLabelWidth;
      if (i % _horizontalLinesCountPerView == 0) {
        _y1 = 0;
        _drawTimeLabels(canvas, size, _x1);
      }
      points.add(Offset(_x1, _y1));
      points.add(Offset(_x2, _y2));

      _x1 += _timeIntervalHeight;
      _x2 += _timeIntervalHeight;
    }

    canvas.drawPoints(PointMode.lines, points, _linePainter);
  }

  void _drawTimeLabels(Canvas canvas, Size size, double xPosition) {
    final double _startHour = _timeSlotViewSettings.startHour;
    final int _timeInterval = _getTimeInterval(_timeSlotViewSettings);
    final String _timeFormat = _timeSlotViewSettings.timeFormat;

    _textPainter = _textPainter ?? TextPainter();
    _textPainter.textDirection = TextDirection.ltr;
    _textPainter.textAlign = TextAlign.left;
    _textPainter.textWidthBasis = TextWidthBasis.parent;
    TextStyle timeTextStyle = _timeSlotViewSettings.timeTextStyle;
    timeTextStyle ??= TextStyle(
        color: _isDark ? Colors.white38 : Colors.black54,
        fontWeight: FontWeight.w500,
        fontSize: 10);

    DateTime date = DateTime.now();
    for (int i = 0; i < _horizontalLinesCountPerView; i++) {
      final dynamic hour = (_startHour - _startHour.toInt()) * 60;
      final dynamic minute = (i * _timeInterval) + hour;
      date = DateTime(
          date.day, date.month, date.year, _startHour.toInt(), minute.toInt());
      final dynamic _time = DateFormat(_timeFormat).format(date).toString();
      final TextSpan span = TextSpan(
        text: _time,
        style: timeTextStyle,
      );

      _textPainter.text = span;
      _textPainter.layout(minWidth: 0, maxWidth: _timeIntervalHeight);
      if (_textPainter.height > _timeLabelWidth) {
        return;
      }

      _textPainter.paint(canvas,
          Offset(xPosition, _timeLabelWidth / 2 - _textPainter.height / 2));
      xPosition += _timeIntervalHeight;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final _TimelineView oldWidget = oldDelegate;
    return oldWidget._horizontalLinesCountPerView !=
            _horizontalLinesCountPerView ||
        oldWidget._timeLabelWidth != _timeLabelWidth ||
        oldWidget._visibleDates != _visibleDates ||
        oldWidget._cellBorderColor != _cellBorderColor ||
        oldWidget._timeSlotViewSettings != _timeSlotViewSettings ||
        oldWidget._isDark != _isDark;
  }
}

class _TimelineViewHeaderView extends CustomPainter {
  _TimelineViewHeaderView(
      this._visibleDates,
      this._calendarViewState,
      this._repaintNotifier,
      this._viewHeaderStyle,
      this._timeSlotViewSettings,
      this._viewHeaderHeight,
      this._isDark,
      this._todayHighlightColor)
      : super(repaint: _repaintNotifier);

  final List<DateTime> _visibleDates;
  final ViewHeaderStyle _viewHeaderStyle;
  final TimeSlotViewSettings _timeSlotViewSettings;
  final double _viewHeaderHeight;
  final Color _todayHighlightColor;
  final double _padding = 5;
  final ValueNotifier<bool> _repaintNotifier;
  final _CalendarViewState _calendarViewState;
  final bool _isDark;
  double _xPosition = 0;
  TextPainter dayTextPainter, dateTextPainter;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final DateTime _today = DateTime.now();
    final double childWidth = size.width / _visibleDates.length;
    final double scrolledPosition =
        _calendarViewState._timelineViewHeaderScrollController.offset;
    final int index = scrolledPosition ~/ childWidth;
    _xPosition = scrolledPosition;

    TextStyle _viewHeaderDayStyle = _viewHeaderStyle.dayTextStyle;
    TextStyle _viewHeaderDateStyle = _viewHeaderStyle.dateTextStyle;
    _viewHeaderDayStyle ??= TextStyle(
        color: _isDark ? Colors.white : Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto');
    _viewHeaderDateStyle ??= TextStyle(
        color: _isDark ? Colors.white : Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto');

    TextStyle _dayTextStyle = _viewHeaderDayStyle;
    TextStyle _dateTextStyle = _viewHeaderDateStyle;
    for (int i = 0; i < _visibleDates.length; i++) {
      if (i < index) {
        continue;
      }

      final DateTime _currentDate = _visibleDates[i];
      String dayFormat = 'EE';
      dayFormat = dayFormat == _timeSlotViewSettings.dayFormat
          ? 'EEEE'
          : _timeSlotViewSettings.dayFormat;

      final String dayText =
          DateFormat(dayFormat).format(_currentDate).toString();
      final String dateText = DateFormat(_timeSlotViewSettings.dateFormat)
          .format(_currentDate)
          .toString();

      if (_isSameDate(_currentDate, _today)) {
        _dayTextStyle =
            _viewHeaderDayStyle.copyWith(color: _todayHighlightColor);
        _dateTextStyle =
            _viewHeaderDateStyle.copyWith(color: _todayHighlightColor);
      } else {
        _dateTextStyle = _viewHeaderDateStyle;
        _dayTextStyle = _viewHeaderDayStyle;
      }

      final TextSpan dayTextSpan =
          TextSpan(text: dayText, style: _dayTextStyle);

      dayTextPainter = dayTextPainter ?? TextPainter();
      dayTextPainter.text = dayTextSpan;
      dayTextPainter.textDirection = TextDirection.ltr;
      dayTextPainter.textAlign = TextAlign.left;
      dayTextPainter.textWidthBasis = TextWidthBasis.longestLine;

      final TextSpan dateTextSpan =
          TextSpan(text: dateText, style: _dateTextStyle);

      dateTextPainter = dateTextPainter ?? TextPainter();
      dateTextPainter.text = dateTextSpan;
      dateTextPainter.textDirection = TextDirection.ltr;
      dateTextPainter.textAlign = TextAlign.left;
      dateTextPainter.textWidthBasis = TextWidthBasis.longestLine;

      dayTextPainter.layout(minWidth: 0, maxWidth: childWidth);
      dateTextPainter.layout(minWidth: 0, maxWidth: childWidth);
      if (dateTextPainter.width +
              _xPosition +
              (_padding * 2) +
              dayTextPainter.width >
          (i + 1) * childWidth) {
        _xPosition = ((i + 1) * childWidth) -
            (dateTextPainter.width + (_padding * 2) + dayTextPainter.width);
      }

      dateTextPainter.paint(
          canvas,
          Offset(_padding + _xPosition,
              _viewHeaderHeight / 2 - dateTextPainter.height / 2));
      dayTextPainter.paint(
          canvas,
          Offset(dateTextPainter.width + _xPosition + (_padding * 2),
              _viewHeaderHeight / 2 - dayTextPainter.height / 2));
      if (index == i) {
        _xPosition = (i + 1) * childWidth;
      } else {
        _xPosition += childWidth;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final _TimelineViewHeaderView oldWidget = oldDelegate;
    return oldWidget._visibleDates != _visibleDates ||
        oldWidget._xPosition != _xPosition ||
        oldWidget._viewHeaderStyle != _viewHeaderStyle ||
        oldWidget._timeSlotViewSettings != _timeSlotViewSettings ||
        oldWidget._viewHeaderHeight != _viewHeaderHeight ||
        oldWidget._todayHighlightColor != _todayHighlightColor ||
        oldWidget._isDark != _isDark;
  }
}

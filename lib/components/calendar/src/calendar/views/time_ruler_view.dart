part of calendar;

class _TimeRulerView extends CustomPainter {
  _TimeRulerView(this._horizontalLinesCount, this._timeIntervalHeight,
      this._timeSlotViewSettings, this._cellBorderColor, this._isDark);

  final double _horizontalLinesCount;
  final double _timeIntervalHeight;
  final TimeSlotViewSettings _timeSlotViewSettings;
  final bool _isDark;
  final Color _cellBorderColor;
  Paint _linePainter;
  TextPainter _textPainter;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final double _width = size.width;
    const double offset = 0.5;
    double y;
    DateTime date = DateTime.now();
    y = _timeIntervalHeight;
    _linePainter = _linePainter ?? Paint();
    _linePainter.strokeWidth = 0.5;
    _linePainter.strokeCap = StrokeCap.round;
    _linePainter.color = _cellBorderColor != null
        ? _cellBorderColor
        : _isDark ? Colors.white70 : Colors.black.withOpacity(0.16);

    //// Draw vertical time label line
    canvas.drawLine(Offset(_width - offset, 0),
        Offset(_width - offset, size.height), _linePainter);
    _textPainter = _textPainter ?? TextPainter();
    _textPainter.textDirection = TextDirection.ltr;
    _textPainter.textWidthBasis = TextWidthBasis.longestLine;

    TextStyle timeTextStyle = _timeSlotViewSettings.timeTextStyle;
    timeTextStyle ??= TextStyle(
        color: _isDark ? Colors.white38 : Colors.black54,
        fontWeight: FontWeight.w500,
        fontSize: 10);

    final dynamic hour = (_timeSlotViewSettings.startHour -
            _timeSlotViewSettings.startHour.toInt()) *
        60;
    double timeLabelPadding = 0;
    for (int i = 1; i <= _horizontalLinesCount; i++) {
      final dynamic minute =
          (i * _getTimeInterval(_timeSlotViewSettings)) + hour;
      date = DateTime(date.day, date.month, date.year,
          _timeSlotViewSettings.startHour.toInt(), minute.toInt());
      final dynamic _time =
          DateFormat(_timeSlotViewSettings.timeFormat).format(date).toString();
      final TextSpan span = TextSpan(
        text: _time,
        style: timeTextStyle,
      );

      _textPainter.text = span;
      _textPainter.layout(minWidth: 0, maxWidth: _width);
      timeLabelPadding = (_width - _textPainter.width) / 2;
      if (timeLabelPadding < 0) {
        timeLabelPadding = 0;
      }

      _textPainter.paint(
          canvas, Offset(timeLabelPadding, y - (_textPainter.height / 2)));

      final Offset _start = Offset(size.width - (timeLabelPadding / 2), y);
      final Offset _end = Offset(size.width, y);
      canvas.drawLine(_start, _end, _linePainter);

      y += _timeIntervalHeight;
      if (y == size.height) {
        break;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final _TimeRulerView oldWidget = oldDelegate;
    return oldWidget._timeSlotViewSettings != _timeSlotViewSettings ||
        oldWidget._cellBorderColor != _cellBorderColor ||
        oldWidget._isDark != _isDark;
  }
}

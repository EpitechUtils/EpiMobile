part of calendar;

class _MonthCellPainter extends CustomPainter {
  _MonthCellPainter(this._visibleDates, this._rowCount, this._monthCellStyle,
      this._isDark, this._todayHighlightColor, this._cellBorderColor);

  final int _rowCount;
  final MonthCellStyle _monthCellStyle;
  final List<DateTime> _visibleDates;
  final bool _isDark;
  final Color _todayHighlightColor;
  final Color _cellBorderColor;
  String _date;
  Paint _linePainter, _circlePainter;
  TextPainter _textPainter;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    double cellWidth, xPosition, yPosition, cellHeight;
    const int numberOfDaysInWeek = 7;
    cellWidth = size.width / numberOfDaysInWeek;
    cellHeight = size.height / _rowCount;
    xPosition = 0;
    yPosition = 5;
    _textPainter = _textPainter ?? TextPainter();
    _textPainter.textDirection = TextDirection.ltr;
    _textPainter.textAlign = TextAlign.center;
    _textPainter.textWidthBasis = TextWidthBasis.longestLine;
    TextStyle _textStyle = _monthCellStyle.textStyle;
    final DateTime _currentDate =
        _visibleDates[(_visibleDates.length / 2).truncate()];
    final DateTime _nextMonthDate = _getNextMonthDate(_currentDate);
    final DateTime _previousMonthDate = _getPreviousMonthDate(_currentDate);
    final DateTime _today = DateTime.now();
    bool _isCurrentDate;

    _linePainter = _linePainter ?? Paint();
    _linePainter.isAntiAlias = true;
    TextStyle currentMonthTextStyle = _monthCellStyle.textStyle;
    TextStyle previousMonthTextStyle = _monthCellStyle.trailingDatesTextStyle;
    TextStyle nextMonthTextStyle = _monthCellStyle.leadingDatesTextStyle;
    currentMonthTextStyle ??= TextStyle(
        fontSize: 13,
        fontFamily: 'Roboto',
        color: _isDark ? Colors.white : Colors.black87);
    previousMonthTextStyle ??= TextStyle(
        fontSize: 13,
        fontFamily: 'Roboto',
        color: _isDark ? Colors.white70 : Colors.black54);
    nextMonthTextStyle ??= TextStyle(
        fontSize: 13,
        fontFamily: 'Roboto',
        color: _isDark ? Colors.white70 : Colors.black54);

    const double linePadding = 0.5;
    for (int i = 0; i < _visibleDates.length; i++) {
      _isCurrentDate = false;
      if (_visibleDates[i].month == _nextMonthDate.month) {
        _textStyle = nextMonthTextStyle;
        _linePainter.color = _monthCellStyle.leadingDatesBackgroundColor;
      } else if (_visibleDates[i].month == _previousMonthDate.month) {
        _textStyle = previousMonthTextStyle;
        _linePainter.color = _monthCellStyle.trailingDatesBackgroundColor;
      } else {
        _textStyle = currentMonthTextStyle;
        _linePainter.color = _monthCellStyle.backgroundColor;
      }

      if (_visibleDates[i].month == _today.month &&
          _visibleDates[i].day == _today.day &&
          _visibleDates[i].year == _today.year) {
        _linePainter.color = _monthCellStyle.todayBackgroundColor;
        _textStyle = _monthCellStyle.todayTextStyle;
        _isCurrentDate = true;
      }

      _date = _visibleDates[i].day.toString();
      final TextSpan span = TextSpan(
        text: _date,
        style: _textStyle,
      );

      _textPainter.text = span;

      _textPainter.layout(minWidth: 0, maxWidth: cellWidth);

      canvas.drawRect(
          Rect.fromLTWH(xPosition, yPosition - 5, cellWidth, cellHeight),
          _linePainter);

      if (_isCurrentDate) {
        _circlePainter = _circlePainter ?? Paint();

        _circlePainter.color = _todayHighlightColor;
        _circlePainter.isAntiAlias = true;

        canvas.drawCircle(
            Offset(xPosition + cellWidth / 2,
                yPosition + _textStyle.fontSize * 0.6),
            _textStyle.fontSize * 0.75,
            _circlePainter);
      }

      _textPainter.paint(canvas, Offset(xPosition, yPosition));
      xPosition += cellWidth;
      if (xPosition.round() >= size.width.round()) {
        xPosition = 0;
        yPosition += cellHeight;
      }
    }

    yPosition = cellHeight;
    _linePainter.strokeWidth = 0.5;
    _linePainter.color = _cellBorderColor != null
        ? _cellBorderColor
        : (_isDark ? Colors.white70 : Colors.black.withOpacity(0.16));
    canvas.drawLine(const Offset(0, linePadding),
        Offset(size.width, linePadding), _linePainter);
    for (int i = 0; i < _rowCount - 1; i++) {
      canvas.drawLine(
          Offset(0, yPosition), Offset(size.width, yPosition), _linePainter);
      yPosition += cellHeight;
    }

    canvas.drawLine(Offset(0, size.height - linePadding),
        Offset(size.width, size.height - linePadding), _linePainter);
    xPosition = cellWidth;
    canvas.drawLine(const Offset(linePadding, 0),
        Offset(linePadding, size.height), _linePainter);
    for (int i = 0; i < 6; i++) {
      canvas.drawLine(
          Offset(xPosition, 0), Offset(xPosition, size.height), _linePainter);
      xPosition += cellWidth;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final _MonthCellPainter oldWidget = oldDelegate;
    return oldWidget._visibleDates != _visibleDates ||
        oldWidget._rowCount != _rowCount ||
        oldWidget._todayHighlightColor != _todayHighlightColor ||
        oldWidget._monthCellStyle != _monthCellStyle ||
        oldWidget._cellBorderColor != _cellBorderColor ||
        oldWidget._isDark != _isDark;
  }
}

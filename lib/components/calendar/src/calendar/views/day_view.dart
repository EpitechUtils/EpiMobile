part of calendar;

class _TimeSlotView extends CustomPainter {
  _TimeSlotView(
      this._visibleDates,
      this._horizontalLinesCount,
      this._timeIntervalHeight,
      this._timeLabelWidth,
      this._cellBorderColor,
      this._isDark);

  final List<DateTime> _visibleDates;
  final double _horizontalLinesCount;
  final double _timeIntervalHeight;
  final double _timeLabelWidth;
  final Color _cellBorderColor;
  final bool _isDark;
  double _cellWidth;
  Paint _linePainter;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final double _width = size.width - _timeLabelWidth;
    double x, y;
    y = _timeIntervalHeight;
    _linePainter = _linePainter ?? Paint();
    _linePainter.strokeWidth = 0.5;
    _linePainter.strokeCap = StrokeCap.round;
    _linePainter.color = _cellBorderColor != null
        ? _cellBorderColor
        : _isDark ? Colors.white70 : Colors.black.withOpacity(0.16);

    for (int i = 1; i <= _horizontalLinesCount; i++) {
      final Offset _start = Offset(_timeLabelWidth, y);
      final Offset _end = Offset(size.width, y);
      canvas.drawLine(_start, _end, _linePainter);

      y += _timeIntervalHeight;
      if (y == size.height) {
        break;
      }
    }

    _cellWidth = _width / _visibleDates.length;
    x = _timeLabelWidth + _cellWidth;
    for (int i = 0; i < _visibleDates.length - 1; i++) {
      final Offset _start = Offset(x, 0);
      final Offset _end = Offset(x, size.height);
      canvas.drawLine(_start, _end, _linePainter);
      x += _cellWidth;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final _TimeSlotView oldWidget = oldDelegate;
    return oldWidget._visibleDates != _visibleDates ||
        oldWidget._timeIntervalHeight != _timeIntervalHeight ||
        oldWidget._timeLabelWidth != _timeLabelWidth ||
        oldWidget._cellBorderColor != _cellBorderColor ||
        oldWidget._horizontalLinesCount != _horizontalLinesCount ||
        oldWidget._isDark != _isDark;
  }
}

part of calendar;

class _HeaderViewPainter extends CustomPainter {
  _HeaderViewPainter(this._visibleDates, this._headerStyle, this._currentDate,
      this._view, this._numberOfWeeksInView, this._isDark);

  final List<DateTime> _visibleDates;
  final CalendarHeaderStyle _headerStyle;
  final DateTime _currentDate;
  final CalendarView _view;
  final int _numberOfWeeksInView;
  final bool _isDark;
  String _headerText;
  TextPainter _textPainter;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    double _xPosition = 5.0;
    _textPainter = _textPainter ?? TextPainter();
    _textPainter.textDirection = TextDirection.ltr;
    _textPainter.textWidthBasis = TextWidthBasis.longestLine;

    if (_view == CalendarView.month &&
        _numberOfWeeksInView != 6 &&
        _visibleDates[0].month !=
            _visibleDates[_visibleDates.length - 1].month) {
      _headerText = DateFormat('MMM yyyy').format(_visibleDates[0]).toString() +
          ' - ' +
          DateFormat('MMM yyyy')
              .format(_visibleDates[_visibleDates.length - 1])
              .toString();
    } else if (!_isTimelineView(_view)) {
      _headerText = DateFormat('MMMM yyyy').format(_currentDate).toString();
    } else {
      String format = 'd MMM';
      if (_view == CalendarView.timelineDay) {
        format = 'MMM yyyy';
      }

      final DateTime startDate = _visibleDates[0];
      final DateTime endDate = _visibleDates[_visibleDates.length - 1];
      String startText = '';
      String endText = '';
      startText = DateFormat(format).format(startDate).toString();
      if (_view != CalendarView.timelineDay) {
        startText = startText + ' - ';
        format = 'd MMM yyyy';
        endText = DateFormat(format).format(endDate).toString();
      }

      _headerText = startText + endText;
    }

    TextStyle style = _headerStyle.textStyle;
    style ??= TextStyle(
        color: _isDark ? Colors.white : Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto');

    final TextSpan span = TextSpan(text: _headerText, style: style);
    _textPainter.text = span;

    if (_headerStyle.textAlign == TextAlign.justify) {
      _textPainter.textAlign = _headerStyle.textAlign;
    }

    _textPainter.layout(minWidth: 0, maxWidth: size.width - _xPosition);

    if (_headerStyle.textAlign == TextAlign.right ||
        _headerStyle.textAlign == TextAlign.end) {
      _xPosition = size.width - _textPainter.width;
    } else if (_headerStyle.textAlign == TextAlign.center) {
      _xPosition = size.width / 2 - _textPainter.width / 2;
    }

    _textPainter.paint(
        canvas, Offset(_xPosition, size.height / 2 - _textPainter.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final _HeaderViewPainter oldWidget = oldDelegate;
    return oldWidget._visibleDates != _visibleDates ||
        oldWidget._headerStyle != _headerStyle ||
        oldWidget._currentDate != _currentDate ||
        oldWidget._isDark != _isDark;
  }
}

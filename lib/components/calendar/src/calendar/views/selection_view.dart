part of calendar;

class _SelectionPainter extends CustomPainter {
  _SelectionPainter(
      this._calendar,
      this._visibleDates,
      this._selectedDate,
      this._selectionDecoration,
      this._timeIntervalHeight,
      this._repaintNotifier,
      {this.updateCalendarState})
      : super(repaint: _repaintNotifier);

  final SfCalendar _calendar;
  final List<DateTime> _visibleDates;
  Decoration _selectionDecoration;
  final double _timeIntervalHeight;
  final _UpdateCalendarState updateCalendarState;

  BoxPainter _boxPainter;
  DateTime _selectedDate;
  _AppointmentView _appointmentView;
  int _rowIndex, _columnIndex;
  double _cellWidth, _cellHeight, _xPosition, _yPosition;
  final int _numberOfDaysInWeek = 7;
  final ValueNotifier<bool> _repaintNotifier;
  final _UpdateCalendarStateDetails _updateCalendarStateDetails =
      _UpdateCalendarStateDetails();

  @override
  void paint(Canvas canvas, Size size) {
    _selectionDecoration ??= BoxDecoration(
      color: Colors.transparent,
      border:
          Border.all(color: const Color.fromARGB(255, 68, 140, 255), width: 2),
      borderRadius: const BorderRadius.all(Radius.circular(2)),
      shape: BoxShape.rectangle,
    );

    _updateCalendarStateDetails._currentViewVisibleDates = null;
    _updateCalendarStateDetails._selectedDate = null;
    updateCalendarState(_updateCalendarStateDetails);
    _selectedDate = _updateCalendarStateDetails._selectedDate;
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final double _timeLabelWidth = _getTimeLabelWidth(
        _calendar.timeSlotViewSettings.timeRulerSize, _calendar.view);
    double _width = size.width;
    final bool _isTimeline = _isTimelineView(_calendar.view);
    if (_calendar.view != CalendarView.month && !_isTimeline) {
      _width -= _timeLabelWidth;
    }
    if ((_selectedDate == null && _appointmentView == null) ||
        _visibleDates != _updateCalendarStateDetails._currentViewVisibleDates) {
      return;
    }

    if (!_isTimeline) {
      if (_calendar.view == CalendarView.month) {
        _cellWidth = _width / _numberOfDaysInWeek;
        _cellHeight =
            size.height / _calendar.monthViewSettings.numberOfWeeksInView;
      } else {
        _cellWidth = _width / _visibleDates.length;
        _cellHeight = _timeIntervalHeight;
      }
    } else {
      _cellWidth = _timeIntervalHeight;
      _cellHeight = size.height - _timeLabelWidth;
    }

    if (!_isTimeline) {
      if (_calendar.view == CalendarView.month) {
        if (_selectedDate != null) {
          if (_isWithInVisibleDateRange(_visibleDates, _selectedDate)) {
            for (int i = 0; i < _visibleDates.length; i++) {
              final DateTime date = _visibleDates[i];
              if (_isSameDate(date, _selectedDate)) {
                final int index = i;
                _columnIndex = (index / _numberOfDaysInWeek).truncate();
                _yPosition = _columnIndex * _cellHeight;
                _rowIndex = index % _numberOfDaysInWeek;
                _xPosition = _rowIndex * _cellWidth;
                _drawSlotSelection(_width, size.height, canvas);
                break;
              }
            }
          }
        }
      } else if (_calendar.view == CalendarView.day) {
        if (_appointmentView != null && _appointmentView.appointment != null) {
          _drawAppointmentSelection(canvas);
        } else if (_selectedDate != null) {
          if (_isSameDate(_visibleDates[0], _selectedDate)) {
            _xPosition = _timeLabelWidth;
            _yPosition =
                _timeToPosition(_calendar, _selectedDate, _timeIntervalHeight);
            _drawSlotSelection(_width + _timeLabelWidth, size.height, canvas);
          }
        }
      } else {
        if (_appointmentView != null && _appointmentView.appointment != null) {
          _drawAppointmentSelection(canvas);
        } else if (_selectedDate != null) {
          if (_isWithInVisibleDateRange(_visibleDates, _selectedDate)) {
            for (int i = 0; i < _visibleDates.length; i++) {
              if (_isSameDate(_selectedDate, _visibleDates[i])) {
                _rowIndex = i;
                _xPosition = _timeLabelWidth + _cellWidth * _rowIndex;
                _yPosition = _timeToPosition(
                    _calendar, _selectedDate, _timeIntervalHeight);
                _drawSlotSelection(
                    _width + _timeLabelWidth, size.height, canvas);
                break;
              }
            }
          }
        }
      }
    } else {
      if (_calendar.view == CalendarView.timelineDay) {
        if (_appointmentView != null && _appointmentView.appointment != null) {
          _drawAppointmentSelection(canvas);
        } else if (_selectedDate != null) {
          if (_isSameDate(_visibleDates[0], _selectedDate)) {
            _xPosition =
                _timeToPosition(_calendar, _selectedDate, _timeIntervalHeight);
            _yPosition = _getTimeLabelWidth(
                _calendar.timeSlotViewSettings.timeRulerSize, _calendar.view);
            _drawSlotSelection(_width, size.height, canvas);
          }
        }
      } else {
        if (_appointmentView != null && _appointmentView.appointment != null) {
          _drawAppointmentSelection(canvas);
        } else if (_selectedDate != null) {
          if (_isWithInVisibleDateRange(_visibleDates, _selectedDate)) {
            for (int i = 0; i < _visibleDates.length; i++) {
              if (_isSameDate(_selectedDate, _visibleDates[i])) {
                final double singleViewWidth = _width / _visibleDates.length;
                _rowIndex = i;
                _xPosition = (_rowIndex * singleViewWidth) +
                    _timeToPosition(
                        _calendar, _selectedDate, _timeIntervalHeight);
                _yPosition = _getTimeLabelWidth(
                    _calendar.timeSlotViewSettings.timeRulerSize,
                    _calendar.view);
                _drawSlotSelection(_width, size.height, canvas);
                break;
              }
            }
          }
        }
      }
    }
  }

  void _drawAppointmentSelection(Canvas canvas) {
    Rect rect = _appointmentView.appointmentRect.outerRect;
    rect = Rect.fromLTRB(rect.left, rect.top, rect.right, rect.bottom);
    _boxPainter = _selectionDecoration.createBoxPainter();
    _boxPainter.paint(canvas, Offset(rect.left, rect.top),
        ImageConfiguration(size: rect.size));
  }

  void _drawSlotSelection(double _width, double height, Canvas canvas) {
    //// padding used to avoid first, last row and column selection clipping.
    const double padding = 0.5;
    final Rect rect = Rect.fromLTRB(
        _xPosition == 0 ? _xPosition + padding : _xPosition,
        _yPosition == 0 ? _yPosition + padding : _yPosition,
        _xPosition + _cellWidth == _width
            ? _xPosition + _cellWidth - padding
            : _xPosition + _cellWidth,
        _yPosition + _cellHeight == height
            ? _yPosition + _cellHeight - padding
            : _yPosition + _cellHeight);
    _boxPainter = _selectionDecoration.createBoxPainter();
    _boxPainter.paint(canvas, Offset(rect.left, rect.top),
        ImageConfiguration(size: rect.size, textDirection: TextDirection.ltr));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final _SelectionPainter oldWidget = oldDelegate;
    return oldWidget._selectionDecoration != _selectionDecoration ||
        oldWidget._selectedDate != _selectedDate ||
        oldWidget._calendar.view != _calendar.view ||
        oldWidget._visibleDates != _visibleDates;
  }
}

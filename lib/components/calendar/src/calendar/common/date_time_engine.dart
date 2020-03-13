part of calendar;

//// Get the visible dates based on the date value and visible dates count.
List<DateTime> _getVisibleDates(DateTime date, List<int> nonWorkingDays,
    int firstDayOfWeek, int visibleDatesCount) {
  final List<DateTime> datesCollection = <DateTime>[];
  DateTime currentDate = date;
  if (firstDayOfWeek != null) {
    currentDate =
        _getDateOnFirstDayOfWeek(visibleDatesCount, date, firstDayOfWeek);
  }

  for (int i = 0; i < visibleDatesCount; i++) {
    final DateTime visibleDate = currentDate.add(Duration(days: i));
    if (nonWorkingDays != null &&
        nonWorkingDays.contains(visibleDate.weekday)) {
      continue;
    }

    datesCollection.add(visibleDate);
  }

  return datesCollection;
}

//// Calculate first day of week date value based original date with first day of week value.
DateTime _getDateOnFirstDayOfWeek(
    int visibleDatesCount, DateTime date, int firstDayOfWeek) {
  if (visibleDatesCount % 7 != 0) {
    return date;
  }

  const int numberOfWeekDays = 7;
  DateTime currentDate = date;
  if (visibleDatesCount == 42) {
    currentDate = DateTime(currentDate.year, currentDate.month, 1);
  }

  int value = -currentDate.weekday + firstDayOfWeek - numberOfWeekDays;
  if (value.abs() >= numberOfWeekDays) {
    value += numberOfWeekDays;
  }

  currentDate = currentDate.add(Duration(days: value));
  return currentDate;
}

//// Calculate the visible dates count based on calendar view
int _getViewDatesCount(CalendarView _view, int numberOfWeeks, DateTime date) {
  if (_view == CalendarView.month) {
    return 7 * numberOfWeeks;
  } else if (_view == CalendarView.week ||
      _view == CalendarView.workWeek ||
      _view == CalendarView.timelineWorkWeek ||
      _view == CalendarView.timelineWeek) {
    return 7;
  } else {
    return 1;
  }
}

//// Calculate the next view visible start date based on calendar view.
DateTime _getNextViewStartDate(
    CalendarView _view, DateTime date, int numberOfWeeks) {
  if (_view == CalendarView.month) {
    return numberOfWeeks == 6
        ? _getNextMonthDate(date)
        : date.add(Duration(days: numberOfWeeks * 7));
  } else if (_view == CalendarView.week ||
      _view == CalendarView.workWeek ||
      _view == CalendarView.timelineWorkWeek ||
      _view == CalendarView.timelineWeek) {
    return date.add(const Duration(days: 7));
  } else {
    return date.add(const Duration(days: 1));
  }
}

//// Calculate the previous view visible start date based on calendar view.
DateTime _getPreviousViewStartDate(
    CalendarView _view, DateTime date, int numberOfWeeks) {
  if (_view == CalendarView.month) {
    return numberOfWeeks == 6
        ? _getPreviousMonthDate(date)
        : date.add(Duration(days: -numberOfWeeks * 7));
  } else if (_view == CalendarView.week ||
      _view == CalendarView.workWeek ||
      _view == CalendarView.timelineWorkWeek ||
      _view == CalendarView.timelineWeek) {
    return date.add(const Duration(days: -7));
  } else {
    return date.add(const Duration(days: -1));
  }
}

//// Calculate the previous month visible start date.
DateTime _getPreviousMonthDate(DateTime date) {
  return date.month == 1
      ? DateTime(date.year - 1, 12, 1)
      : DateTime(date.year, date.month - 1, 1);
}

//// Calculate the next month visible start date.
DateTime _getNextMonthDate(DateTime date) {
  return date.month == 12
      ? DateTime(date.year + 1, 1, 1)
      : DateTime(date.year, date.month + 1, 1);
}

DateTime _getCurrentDate(DateTime minDate, DateTime maxDate, DateTime date) {
  if (date.isAfter(minDate)) {
    if (date.isBefore(maxDate)) {
      return date;
    } else {
      return maxDate;
    }
  } else {
    return minDate;
  }
}

int _getIndex(List<DateTime> dates, DateTime date) {
  if (date.isBefore(dates[0])) {
    return 0;
  }

  if (date.isAfter(dates[dates.length - 1])) {
    return dates.length - 1;
  }

  for (int i = 0; i < dates.length; i++) {
    final DateTime visibleDate = dates[i];
    if (_isSameDate(visibleDate, date) || visibleDate.isAfter(date)) {
      return i;
    }
  }

  return -1;
}

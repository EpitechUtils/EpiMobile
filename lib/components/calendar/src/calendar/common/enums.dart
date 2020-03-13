part of calendar;

/// The navigation direction for month view of calendar
/// MonthNavigationDirection.vertical will navigate the month in vertical direction
/// MonthNavigationDirection.horizontal will navigate the month in horizontal direction
enum MonthNavigationDirection { vertical, horizontal }

/// The calendar view for the calendar
/// CalendarView.day will display the day view of calendar
/// CalendarView.week will display the week view of calendar
/// CalendarView.workWeek will display the work week view of calendar
/// CalendarView.month will display the month view of calendar
/// CalendarView.timelineDay will display the timeline day view of calendar
/// CalendarView.timelineWeek will display the timeline week view of calendar
/// CalendarView.timelineWorkWeek will display the timeline work week view of calendar
enum CalendarView {
  day,
  week,
  workWeek,
  month,
  timelineDay,
  timelineWeek,
  timelineWorkWeek
}

/// The display mode of appointment in month view
/// MonthAppointmentDisplayMode.indicator will display the appointments as indicator in month cell
/// MonthAppointmentDisplayMode.appointment will display the appointments as appointment in month cell
/// MonthAppointmentDisplayMode.none will hides the appointments in month view
enum MonthAppointmentDisplayMode { indicator, appointment, none }

/// The recurrence type of the appointment
/// RecurrenceType.daily will indicates the appointment occurrence repeated in every day.
/// RecurrenceType.weekly will indicates the appointment occurrence repeated in every week.
/// RecurrenceType.monthly will indicates the appointment occurrence repeated in every month.
/// RecurrenceType.yearly will indicates the appointment occurrence repeated in every year.
enum RecurrenceType {
  daily,
  weekly,
  monthly,
  yearly,
}

/// The recurrence range of the appointment
/// RecurrenceRange.endDate will indicates the appointment occurrence repeated until the end date.
/// RecurrenceRange.noEndDate will indicates the appointment occurrence repeated until the last date of the calendar.
/// RecurrenceRange.count will indicates the appointment occurrence repeated with specified count times.
enum RecurrenceRange { endDate, noEndDate, count }

/// The week days occurrence of appointment
/// WeekDays.sunday will indicates the appointment occurred in sunday.
/// WeekDays.monday will indicates the appointment occurred in monday.
/// WeekDays.tuesday will indicates the appointment occurred in tuesday.
/// WeekDays.wednesday will indicates the appointment occurred in wednesday.
/// WeekDays.thursday will indicates the appointment occurred in thursday.
/// WeekDays.friday will indicates the appointment occurred in friday.
/// WeekDays.saturday will indicates the appointment occurred in saturday.
enum WeekDays { sunday, monday, tuesday, wednesday, thursday, friday, saturday }

/// The calendar element which can be returned in the tap callback
enum CalendarElement { header, viewHeader, calendarCell, appointment, agenda }

//// Action performed in data source
enum CalendarDataSourceAction { add, remove, reset }

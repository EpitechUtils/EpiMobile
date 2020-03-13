part of calendar;

/// Returns the date time collection of recurring appointment.
List<DateTime> _getRecurrenceDateTimeCollection(
    String rRule, DateTime recurrenceStartDate,
    {DateTime specificStartDate, DateTime specificEndDate}) {
  if (specificEndDate != null) {
    specificEndDate = DateTime(specificEndDate.year, specificEndDate.month,
        specificEndDate.day, 23, 59, 59);
  }

  final List<DateTime> recDateCollection = <DateTime>[];
  final dynamic isSpecificDateRange =
      specificStartDate != null && specificEndDate != null;
  final List<String> ruleSeparator = <String>['=', ';', ','];
  const String weeklySeparator = ';';

  final List<String> ruleArray = _splitRule(rRule, ruleSeparator);
  int weeklyByDayPos;
  int recCount = 0;
  final List<String> values = _findKeyIndex(ruleArray);
  final String reccount = values[0];
  final String daily = values[1];
  final String weekly = values[2];
  final String monthly = values[3];
  final String yearly = values[4];
  //String bySetPos = values[5];
  final String bySetPosCount = values[6];
  final String interval = values[7];
  final String intervalCount = values[8];
  //String until = values[9];
  final String untilValue = values[10];
  //String count = values[11];
  final String byDay = values[12];
  final String byDayValue = values[13];
  final String byMonthDay = values[14];
  final String byMonthDayCount = values[15];
  //final String byMonth = values[16];
  final String byMonthCount = values[17];
  //String weeklyByDay = values[18];
  //int byMonthDayPosition = int.parse(values[19]);
  //int byDayPosition = int.parse(values[20]);
  final List<String> weeklyRule = rRule.split(weeklySeparator);
  final List<String> weeklyRules = _findWeeklyRule(weeklyRule);
  if (weeklyRules.isNotEmpty) {
    // weeklyByDay = weeklyRules[0];
    weeklyByDayPos = int.parse(weeklyRules[1]);
  }

  if (ruleArray.isNotEmpty && rRule != null && rRule != '') {
    DateTime addDate = recurrenceStartDate;
    if (reccount != null && reccount != '') {
      recCount = int.parse(reccount);
    }

    DateTime endDate;
    if (rRule.contains('UNTIL')) {
      endDate = DateTime.parse(untilValue);
      endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 0);
      if (isSpecificDateRange) {
        endDate =
            (endDate.isAfter(specificEndDate) || endDate == specificEndDate)
                ? specificEndDate
                : endDate;
      }
    }

//// NoEndDate specified rule returns empty collection issue fix.
    if (isSpecificDateRange && !rRule.contains('COUNT') && endDate == null) {
      endDate = specificEndDate;
    }

    if (daily == 'DAILY') {
      if (!rRule.contains('BYDAY')) {
        final int dailyDayGap =
            !rRule.contains('INTERVAL') ? 1 : int.parse(intervalCount);
        int tempcount = 0;
        while (tempcount < recCount ||
            (endDate != null &&
                (addDate.isBefore(endDate) || addDate == endDate))) {
          if (isSpecificDateRange) {
            if ((addDate.isAfter(specificStartDate) ||
                    addDate == specificStartDate) &&
                (addDate.isBefore(specificEndDate) ||
                    addDate == specificEndDate)) {
              recDateCollection.add(addDate);
            }
          } else {
            recDateCollection.add(addDate);
          }

          addDate = addDate.add(Duration(days: dailyDayGap));
          tempcount++;
        }
      } else {
        while (recDateCollection.length < recCount ||
            (endDate != null &&
                (addDate.isBefore(endDate) || addDate == endDate))) {
          if (addDate.weekday != DateTime.sunday &&
              addDate.weekday != DateTime.saturday) {
            if (isSpecificDateRange) {
              if ((addDate.isAfter(specificStartDate) ||
                      addDate == specificStartDate) &&
                  (addDate.isBefore(specificEndDate) ||
                      addDate == specificEndDate)) {
                recDateCollection.add(addDate);
              }
            } else {
              recDateCollection.add(addDate);
            }
          }

          addDate = addDate.add(const Duration(days: 1));
        }
      }
    } else if (weekly == 'WEEKLY') {
      int tempCount = 0;
      final int weeklyWeekGap = ruleArray.length > 4 && interval == 'INTERVAL'
          ? int.parse(intervalCount)
          : 1;
      final bool isweeklyselected = weeklyRule[weeklyByDayPos].length > 6;

      // Below code modified for fixing issue while setting rule as "FREQ=WEEKLY;COUNT=10;BYDAY=MO" along with specified start and end date.
      while ((tempCount < recCount && isweeklyselected) ||
          (endDate != null &&
              (addDate.isBefore(endDate) || addDate == endDate))) {
        if (isSpecificDateRange) {
          if ((addDate.isAfter(specificStartDate) ||
                  addDate == specificStartDate) &&
              (addDate.isBefore(specificEndDate) ||
                  addDate == specificEndDate)) {
            _setWeeklyRecurrenceDate(
                addDate, weeklyRule, weeklyByDayPos, recDateCollection);
          }

          if (addDate.isAfter(specificEndDate)) {
            break;
          }
        } else {
          _setWeeklyRecurrenceDate(
              addDate, weeklyRule, weeklyByDayPos, recDateCollection);
        }

        if (_isRecurrenceDate(addDate, weeklyRule, weeklyByDayPos)) {
          tempCount++;
        }

        addDate = addDate.weekday == DateTime.saturday
            ? addDate.add(Duration(days: ((weeklyWeekGap - 1) * 7) + 1))
            : addDate.add(const Duration(days: 1));
      }
    } else if (monthly == 'MONTHLY') {
      final int monthlyMonthGap = ruleArray.length > 4 && interval == 'INTERVAL'
          ? int.parse(intervalCount)
          : 1;
      if (byMonthDay == 'BYMONTHDAY') {
        final int monthDate = int.parse(byMonthDayCount);
        if (monthDate < 30) {
          final int currDate = int.parse(recurrenceStartDate.day.toString());
          final DateTime temp = DateTime(addDate.year, addDate.month, monthDate,
              addDate.hour, addDate.minute, addDate.second);
          addDate = monthDate < currDate
              ? DateTime(temp.year, temp.month + 1, temp.day, temp.hour,
                  temp.minute, temp.second)
              : temp;
          int tempcount = 0;
          while (tempcount < recCount ||
              (endDate != null &&
                  (addDate.isBefore(endDate) || addDate == endDate))) {
            if (addDate.month == 2 && monthDate > 28) {
              addDate = DateTime(
                  addDate.year,
                  addDate.month,
                  DateTime(addDate.year, addDate.month + 1, 1)
                      .subtract(const Duration(days: 1))
                      .day,
                  addDate.hour,
                  addDate.minute,
                  addDate.second);
              if (isSpecificDateRange) {
                if ((addDate.isAfter(specificStartDate) ||
                        addDate == specificStartDate) &&
                    (addDate.isBefore(specificEndDate) ||
                        addDate == specificEndDate)) {
                  recDateCollection.add(addDate);
                }

                if (addDate.isAfter(specificEndDate)) {
                  break;
                }
              } else {
                recDateCollection.add(addDate);
              }

              addDate = DateTime(addDate.year, addDate.month + monthlyMonthGap,
                  monthDate, addDate.hour, addDate.minute, addDate.second);
            } else {
              if (isSpecificDateRange) {
                if ((addDate.isAfter(specificStartDate) ||
                        addDate == specificStartDate) &&
                    (addDate.isBefore(specificEndDate) ||
                        addDate == specificEndDate)) {
                  recDateCollection.add(addDate);
                }

                if (addDate.isAfter(specificEndDate)) {
                  break;
                }
              } else {
                recDateCollection.add(addDate);
              }

              addDate = DateTime(addDate.year, addDate.month + monthlyMonthGap,
                  addDate.day, addDate.hour, addDate.minute, addDate.second);
            }

            tempcount++;
          }
        } else {
          addDate = DateTime(
              addDate.year,
              addDate.month,
              DateTime(addDate.year, addDate.month + 1, 1)
                  .subtract(const Duration(days: 1))
                  .day,
              addDate.hour,
              addDate.minute,
              addDate.second);
          int tempcount = 0;
          while (tempcount < recCount ||
              (endDate != null &&
                  (addDate.isBefore(endDate) || addDate == endDate))) {
            if (isSpecificDateRange) {
              if ((addDate.isAfter(specificStartDate) ||
                      addDate == specificStartDate) &&
                  (addDate.isBefore(specificEndDate) ||
                      addDate == specificEndDate)) {
                recDateCollection.add(addDate);
              }

              if (addDate.isAfter(specificEndDate)) {
                break;
              }
            } else {
              recDateCollection.add(addDate);
            }

            addDate = DateTime(
                addDate.year,
                addDate.month + monthlyMonthGap,
                DateTime(addDate.year, addDate.month + monthlyMonthGap, 1)
                    .subtract(const Duration(days: 1))
                    .day,
                addDate.hour,
                addDate.minute,
                addDate.second);
            tempcount++;
          }
        }
      } else if (byDay == 'BYDAY') {
        dynamic tempRecDateCollectionCount = 0;
        while (recDateCollection.length < recCount ||
            (endDate != null &&
                (addDate.isBefore(endDate) || addDate == endDate))) {
          final DateTime monthStart = DateTime(addDate.year, addDate.month, 1,
              addDate.hour, addDate.minute, addDate.second);
          final DateTime weekStartDate =
              monthStart.add(Duration(days: -monthStart.weekday));
          final int monthStartWeekday = monthStart.weekday;
          final int nthweekDay = _getWeekDay(byDayValue);
          int nthWeek;
          if (monthStartWeekday <= nthweekDay) {
            nthWeek = int.parse(bySetPosCount) - 1;
          } else {
            nthWeek = int.parse(bySetPosCount);
          }

          addDate = weekStartDate.add(Duration(days: nthWeek * 7));
          addDate = addDate.add(Duration(days: nthweekDay));
          if (addDate.isBefore(recurrenceStartDate)) {
            addDate = DateTime(addDate.year, addDate.month + 1, addDate.day,
                addDate.hour, addDate.minute, addDate.second);
            continue;
          }

          if (isSpecificDateRange) {
            if ((addDate.isAfter(specificStartDate) ||
                    addDate == specificStartDate) &&
                (addDate.isBefore(specificEndDate) ||
                    addDate == specificEndDate) &&
                (tempRecDateCollectionCount < recCount ||
                    rRule.contains('UNTIL'))) {
              recDateCollection.add(addDate);
            }

            if (addDate.isAfter(specificEndDate)) {
              break;
            }
          } else {
            recDateCollection.add(addDate);
          }

          addDate = DateTime(
              addDate.year,
              addDate.month + monthlyMonthGap,
              addDate.day - (addDate.day - 1),
              addDate.hour,
              addDate.minute,
              addDate.second);
          tempRecDateCollectionCount++;
        }
      }
    } else if (yearly == 'YEARLY') {
      final int yearlyYearGap = ruleArray.length > 4 && interval == 'INTERVAL'
          ? int.parse(intervalCount)
          : 1;
      if (byMonthDay == 'BYMONTHDAY') {
        final int monthIndex = int.parse(byMonthCount);
        final int dayIndex = int.parse(byMonthDayCount);
        if (monthIndex > 0 && monthIndex <= 12) {
          final int bound = DateTime(addDate.year, addDate.month + 1, 1)
              .subtract(const Duration(days: 1))
              .day;
          if (bound >= dayIndex) {
            final DateTime specificDate = DateTime(addDate.year, monthIndex,
                dayIndex, addDate.hour, addDate.minute, addDate.second);
            if (specificDate.isBefore(addDate)) {
              addDate = specificDate;
              addDate = DateTime(addDate.year + 1, addDate.month, addDate.day,
                  addDate.hour, addDate.minute, addDate.second);
              if (isSpecificDateRange) {
                if ((addDate.isAfter(specificStartDate) ||
                        addDate == specificStartDate) &&
                    (addDate.isBefore(specificEndDate) ||
                        addDate == specificEndDate)) {
                  recDateCollection.add(addDate);
                }
              } else {
                recDateCollection.add(addDate);
              }
            } else {
              addDate = specificDate;
            }

            int tempcount = 0;
            while (tempcount < recCount ||
                (endDate != null &&
                    (addDate.isBefore(endDate) || addDate == endDate))) {
              if (!recDateCollection.contains(addDate)) {
                if (isSpecificDateRange) {
                  if ((addDate.isAfter(specificStartDate) ||
                          addDate == specificStartDate) &&
                      (addDate.isBefore(specificEndDate) ||
                          addDate == specificEndDate)) {
                    recDateCollection.add(addDate);
                  }

                  if (addDate.isAfter(specificEndDate)) {
                    break;
                  }
                } else {
                  recDateCollection.add(addDate);
                }
              }

              addDate = DateTime(addDate.year + yearlyYearGap, addDate.month,
                  addDate.day, addDate.hour, addDate.minute, addDate.second);
              tempcount++;
            }
          }
        }
      } else if (byDay == 'BYDAY') {
        final int monthIndex = int.parse(byMonthCount);
        DateTime monthStart = DateTime(addDate.year, monthIndex, 1,
            addDate.hour, addDate.minute, addDate.second);
        DateTime weekStartDate =
            monthStart.add(Duration(days: -monthStart.weekday));
        int monthStartWeekday = monthStart.weekday;
        int nthweekDay = _getWeekDay(byDayValue);
        int nthWeek;
        if (monthStartWeekday <= nthweekDay) {
          nthWeek = int.parse(bySetPosCount) - 1;
        } else {
          nthWeek = int.parse(bySetPosCount);
        }

        monthStart = weekStartDate.add(Duration(days: nthWeek * 7));
        monthStart = monthStart.add(Duration(days: nthweekDay));

        if ((monthStart.month != addDate.month &&
                monthStart.isBefore(addDate)) ||
            (monthStart.month == addDate.month &&
                (monthStart.isBefore(addDate) ||
                    monthStart.isBefore(recurrenceStartDate)))) {
          addDate = DateTime(addDate.year + 1, addDate.month, addDate.day,
              addDate.hour, addDate.minute, addDate.second);
          monthStart = DateTime(addDate.year, monthIndex, 1, addDate.hour,
              addDate.minute, addDate.second);
          weekStartDate = monthStart.add(Duration(days: -monthStart.weekday));
          monthStartWeekday = monthStart.weekday;
          nthweekDay = _getWeekDay(byDayValue);
          if (monthStartWeekday <= nthweekDay) {
            nthWeek = int.parse(bySetPosCount) - 1;
          } else {
            nthWeek = int.parse(bySetPosCount);
          }

          monthStart = weekStartDate.add(Duration(days: nthWeek * 7));
          monthStart = monthStart.add(Duration(days: nthweekDay));

          addDate = monthStart;

          if (!recDateCollection.contains(addDate)) {
            if (isSpecificDateRange) {
              if ((addDate.isAfter(specificStartDate) ||
                      addDate == specificStartDate) &&
                  (addDate.isBefore(specificEndDate) ||
                      addDate == specificEndDate)) {
                recDateCollection.add(addDate);
              }
            } else {
              recDateCollection.add(addDate);
            }
          }
        } else {
          addDate = monthStart;
        }

        int tempcount = 0;
        while (tempcount < recCount ||
            (endDate != null &&
                (addDate.isBefore(endDate) || addDate == endDate))) {
          if (!recDateCollection.contains(addDate)) {
            if (isSpecificDateRange) {
              if ((addDate.isAfter(specificStartDate) ||
                      addDate == specificStartDate) &&
                  (addDate.isBefore(specificEndDate) ||
                      addDate == specificEndDate)) {
                recDateCollection.add(addDate);
              }

              if (addDate.isAfter(specificEndDate)) {
                break;
              }
            } else {
              recDateCollection.add(addDate);
            }
          }

          addDate = DateTime(addDate.year + yearlyYearGap, addDate.month,
              addDate.day, addDate.hour, addDate.minute, addDate.second);

          monthStart = DateTime(addDate.year, monthIndex, 1, addDate.hour,
              addDate.minute, addDate.second);

          weekStartDate = monthStart.add(Duration(days: -monthStart.weekday));
          monthStartWeekday = monthStart.weekday;
          nthweekDay = _getWeekDay(byDayValue);
          if (monthStartWeekday <= nthweekDay) {
            nthWeek = int.parse(bySetPosCount) - 1;
          } else {
            nthWeek = int.parse(bySetPosCount);
          }

          monthStart = weekStartDate.add(Duration(days: nthWeek * 7));
          monthStart = monthStart.add(Duration(days: nthweekDay));

          if (monthStart.month != addDate.month &&
              monthStart.isBefore(addDate)) {
            addDate = monthStart;
            addDate = DateTime(addDate.year + 1, addDate.month, addDate.day,
                addDate.hour, addDate.minute, addDate.second);
            if (!recDateCollection.contains(addDate)) {
              if (isSpecificDateRange) {
                if ((addDate.isAfter(specificStartDate) ||
                        addDate == specificStartDate) &&
                    (addDate.isBefore(specificEndDate) ||
                        addDate == specificEndDate)) {
                  recDateCollection.add(addDate);
                }

                if (addDate.isAfter(specificEndDate)) {
                  break;
                }
              } else {
                recDateCollection.add(addDate);
              }
            }
          } else {
            addDate = monthStart;
          }

          tempcount++;
        }
      }
    }
  }

  return recDateCollection;
}

/// Returns the recurrence properties based on the given recurrence rule and
/// the recurrence start date.
RecurrenceProperties _parseRRule(String rRule, DateTime recStartDate) {
  final DateTime recurrenceStartDate = recStartDate;
  final RecurrenceProperties recProp = RecurrenceProperties();

  recProp.startDate = recStartDate;
  final List<String> ruleSeparator = <String>['=', ';', ','];
  const String weeklySeparator = ';';
  final List<String> ruleArray = _splitRule(rRule, ruleSeparator);
  final List<String> weeklyRule = rRule.split(weeklySeparator);
//string count, reccount, daily, weekly, monthly, yearly, interval, intervalCount, until, untilValue, weeklyByDay, bySetPos, bySetPosCount, byDay, byDayValue, byMonthDay, byMonthDayCount, byMonth, byMonthCount;
  int weeklyByDayPos;
  int recCount = 0;
  final List<String> resultList = _findKeyIndex(ruleArray);
  final String reccount = resultList[0];
  final String daily = resultList[1];
  final String weekly = resultList[2];
  final String monthly = resultList[3];
  final String yearly = resultList[4];
  //final String bySetPos = resultList[5];
  final String bySetPosCount = resultList[6];
  final String interval = resultList[7];
  final String intervalCount = resultList[8];
  //final String until = resultList[9];
  final String untilValue = resultList[10];
  //final String count = resultList[11];
  final String byDay = resultList[12];
  final String byDayValue = resultList[13];
  final String byMonthDay = resultList[14];
  final String byMonthDayCount = resultList[15];
  //final String byMonth = resultList[16];
  final String byMonthCount = resultList[17];
  //String weeklyByDay = resultList[18];
  //final int byMonthDayPosition = int.parse(resultList[19]);
  final int byDayPosition = int.parse(resultList[20]);
  final List<String> weeklyRules = _findWeeklyRule(weeklyRule);
  if (weeklyRules.isNotEmpty) {
    //weeklyByDay = weeklyRules[0];
    weeklyByDayPos = int.parse(weeklyRules[1]);
  }

  if (ruleArray.isNotEmpty && (rRule != null || rRule != '')) {
    DateTime addDate = recurrenceStartDate;
    if (reccount != null || reccount != '') {
      recCount = int.parse(reccount);
    }

    if (!rRule.contains('COUNT') && !rRule.contains('UNTIL')) {
      recProp.recurrenceRange = RecurrenceRange.noEndDate;
    } else if (rRule.contains('COUNT')) {
      recProp.recurrenceRange = RecurrenceRange.count;
      recProp.recurrenceCount = recCount;
    } else if (rRule.contains('UNTIL')) {
      recProp.recurrenceRange = RecurrenceRange.endDate;
      DateTime endDate = DateTime.parse(untilValue);
      endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
      recProp.endDate = endDate;
    }

    if (daily == 'DAILY') {
      recProp.recurrenceType = RecurrenceType.daily;

      if (rRule.contains('COUNT')) {
        recProp.interval = int.parse(intervalCount);
      } else if (rRule.contains('BYDAY')) {
        recProp.interval = int.parse(intervalCount);
        recProp.weekDays = <WeekDays>[];
        recProp.weekDays.add(WeekDays.monday);
        recProp.weekDays.add(WeekDays.tuesday);
        recProp.weekDays.add(WeekDays.wednesday);
        recProp.weekDays.add(WeekDays.thursday);
        recProp.weekDays.add(WeekDays.friday);
      } else {
        recProp.interval = ruleArray.length > 4 && interval == 'INTERVAL'
            ? int.parse(intervalCount)
            : 1;
      }
    } else if (weekly == 'WEEKLY') {
      recProp.recurrenceType = RecurrenceType.weekly;
      recProp.interval = ruleArray.length > 4 && interval == 'INTERVAL'
          ? int.parse(intervalCount)
          : 1;
      final int wyWeekGap = recProp.interval;
      int i = 0;
      if (recProp.recurrenceRange == RecurrenceRange.noEndDate) {
        recCount = 7;
      }

      while (i < 7) {
        switch (addDate.weekday) {
          case DateTime.sunday:
            {
              if (weeklyRule[weeklyByDayPos].contains('SU')) {
                recProp.weekDays.add(WeekDays.sunday);
              }

              break;
            }

          case DateTime.monday:
            {
              if (weeklyRule[weeklyByDayPos].contains('MO')) {
                recProp.weekDays.add(WeekDays.monday);
              }

              break;
            }

          case DateTime.tuesday:
            {
              if (weeklyRule[weeklyByDayPos].contains('TU')) {
                recProp.weekDays.add(WeekDays.tuesday);
              }

              break;
            }

          case DateTime.wednesday:
            {
              if (weeklyRule[weeklyByDayPos].contains('WE')) {
                recProp.weekDays.add(WeekDays.wednesday);
              }

              break;
            }

          case DateTime.thursday:
            {
              if (weeklyRule[weeklyByDayPos].contains('TH')) {
                recProp.weekDays.add(WeekDays.thursday);
              }

              break;
            }

          case DateTime.friday:
            {
              if (weeklyRule[weeklyByDayPos].contains('FR')) {
                recProp.weekDays.add(WeekDays.friday);
              }

              break;
            }

          case DateTime.saturday:
            {
              if (weeklyRule[weeklyByDayPos].contains('SA')) {
                recProp.weekDays.add(WeekDays.saturday);
              }

              break;
            }
        }

        addDate = addDate.weekday == 7
            ? addDate.add(Duration(days: ((wyWeekGap - 1) * 7) + 1))
            : addDate.add(const Duration(days: 1));
        i = i + 1;
      }
    } else if (monthly == 'MONTHLY') {
      recProp.recurrenceType = RecurrenceType.monthly;
      if (!rRule.contains('COUNT')) {
        recProp.interval = ruleArray.length > 4 && interval == 'INTERVAL'
            ? int.parse(intervalCount)
            : 1;
        if (rRule.contains('BYMONTHDAY')) {
          recProp.week = -1;
          recProp.dayOfMonth = int.parse(byMonthDayCount);
        } else if (rRule.contains('BYDAY')) {
          recProp.week = int.parse(bySetPosCount);
          recProp.dayOfWeek = _getWeekDay(byDayValue);
        }
      } else {
        recProp.interval = ruleArray.length > 4 && interval == 'INTERVAL'
            ? int.parse(intervalCount)
            : 1;
        int position =
            ruleArray.length > 4 && interval == 'INTERVAL' ? 6 : byDayPosition;
        position = ruleArray.length == 4 ? 2 : position;
        if (byMonthDay == 'BYMONTHDAY') {
          recProp.week = -1;
          recProp.dayOfMonth = int.parse(byMonthDayCount);
        } else if (ruleArray[position] == 'BYDAY') {
          recProp.week = int.parse(bySetPosCount);
          recProp.dayOfWeek = _getWeekDay(byDayValue);
        }
      }
    } else if (yearly == 'YEARLY') {
      recProp.recurrenceType = RecurrenceType.yearly;
      if (!rRule.contains('COUNT')) {
        recProp.interval = ruleArray.length > 4 && interval == 'INTERVAL'
            ? int.parse(intervalCount)
            : 1;
        if (rRule.contains('BYMONTHDAY')) {
          recProp.month = int.parse(byMonthCount);
          recProp.dayOfWeek = int.parse(byMonthDayCount);
        } else if (rRule.contains('BYDAY')) {
          recProp.month = int.parse(byMonthCount);
          recProp.week = int.parse(bySetPosCount);
          recProp.dayOfWeek = _getWeekDay(byDayValue);
        }
      } else {
        recProp.interval = ruleArray.length > 4 && interval == 'INTERVAL'
            ? int.parse(intervalCount)
            : 1;
        if (byMonthDay == 'BYMONTHDAY') {
          recProp.month = int.parse(byMonthCount);
          recProp.dayOfMonth = int.parse(byMonthDayCount);
        } else if (byDay == 'BYDAY') {
          recProp.month = int.parse(byMonthCount);
          recProp.week = int.parse(bySetPosCount);
          recProp.dayOfWeek = _getWeekDay(byDayValue);
        }
      }
    }
  }

  return recProp;
}

/// Generates the recurrence rule based on the given recurrence properties and
/// the start date and end date of the recurrence appointment.
String _generateRRule(RecurrenceProperties recurrenceProperties,
    DateTime appStartTime, DateTime appEndTime) {
  final DateTime recPropStartDate = recurrenceProperties.startDate;
  final DateTime recPropEndDate = recurrenceProperties.endDate;
  final DateTime startDate =
      appStartTime.isAfter(recPropStartDate) ? appStartTime : recPropStartDate;
  final DateTime endDate = recPropEndDate;
  final dynamic diffTimeSpan = appEndTime.difference(appStartTime);
  int recCount = 0;
  String rRule = '';
  DateTime prevDate = DateTime.utc(1);
  bool isValidRecurrence = true;

  recCount = recurrenceProperties.recurrenceCount;
  if (recurrenceProperties.recurrenceType == RecurrenceType.daily) {
    if ((recCount > 0 &&
            recurrenceProperties.recurrenceRange == RecurrenceRange.count) ||
        recurrenceProperties.recurrenceRange == RecurrenceRange.noEndDate ||
        ((startDate.isBefore(endDate) || startDate == endDate) &&
            recurrenceProperties.recurrenceRange == RecurrenceRange.endDate)) {
      rRule = 'FREQ=DAILY';

      if (recurrenceProperties.weekDays.contains(WeekDays.monday) &&
          recurrenceProperties.weekDays.contains(WeekDays.tuesday) &&
          recurrenceProperties.weekDays.contains(WeekDays.wednesday) &&
          recurrenceProperties.weekDays.contains(WeekDays.thursday) &&
          recurrenceProperties.weekDays.contains(WeekDays.friday)) {
        if (diffTimeSpan.inHours > 24) {
          isValidRecurrence = false;
        }

        rRule = rRule + ';BYDAY=MO,TU,WE,TH,FR';
      } else {
        if (diffTimeSpan.inHours >= recurrenceProperties.interval * 24) {
          isValidRecurrence = false;
        }

        if (recurrenceProperties.interval > 0) {
          rRule =
              rRule + ';INTERVAL=' + recurrenceProperties.interval.toString();
        }
      }

      if (recurrenceProperties.recurrenceRange == RecurrenceRange.count) {
        rRule = rRule + ';COUNT=' + recCount.toString();
      } else if (recurrenceProperties.recurrenceRange ==
          RecurrenceRange.endDate) {
        final DateFormat format = DateFormat('yyyyMMdd');
        rRule = rRule + ';UNTIL=' + format.format(endDate);
      }
    }
  } else if (recurrenceProperties.recurrenceType == RecurrenceType.weekly) {
    DateTime addDate = startDate;
    if ((recCount > 0 &&
            recurrenceProperties.recurrenceRange == RecurrenceRange.count) ||
        recurrenceProperties.recurrenceRange == RecurrenceRange.noEndDate ||
        ((startDate.isBefore(endDate) || startDate == endDate) &&
            recurrenceProperties.recurrenceRange == RecurrenceRange.endDate)) {
      rRule = 'FREQ=WEEKLY';
      String byDay = '';
      int su = 0, mo = 0, tu = 0, we = 0, th = 0, fr = 0, sa = 0;
      String dayKey = '';
      int dayCount = 0;
      rRule = rRule + ';BYDAY=';
      int count = 0;
      int i = 0;
      while ((count < recCount &&
              isValidRecurrence &&
              recurrenceProperties.weekDays != null &&
              recurrenceProperties.weekDays.isNotEmpty) ||
          (addDate.isBefore(endDate) || addDate == endDate) ||
          (recurrenceProperties.recurrenceRange == RecurrenceRange.noEndDate &&
              i < 7)) {
        switch (addDate.weekday) {
          case DateTime.sunday:
            {
              if (recurrenceProperties.weekDays.contains(WeekDays.sunday)) {
                dayKey = 'SU,';
                dayCount = su;
              }

              break;
            }

          case DateTime.monday:
            {
              if (recurrenceProperties.weekDays.contains(WeekDays.monday)) {
                dayKey = 'MO,';
                dayCount = mo;
              }

              break;
            }

          case DateTime.tuesday:
            {
              if (recurrenceProperties.weekDays.contains(WeekDays.tuesday)) {
                dayKey = 'TU,';
                dayCount = tu;
              }

              break;
            }

          case DateTime.wednesday:
            {
              if (recurrenceProperties.weekDays.contains(WeekDays.wednesday)) {
                dayKey = 'WE,';
                dayCount = we;
              }

              break;
            }

          case DateTime.thursday:
            {
              if (recurrenceProperties.weekDays.contains(WeekDays.thursday)) {
                dayKey = 'TH,';
                dayCount = th;
              }

              break;
            }

          case DateTime.friday:
            {
              if (recurrenceProperties.weekDays.contains(WeekDays.friday)) {
                dayKey = 'FR,';
                dayCount = fr;
              }

              break;
            }

          case DateTime.saturday:
            {
              if (recurrenceProperties.weekDays.contains(WeekDays.saturday)) {
                dayKey = 'SA';
                dayCount = sa;
              }

              break;
            }
        }

        if (dayKey != null && dayKey != '') {
          if (count != 0) {
            final dynamic tempTimeSpan = addDate.difference(prevDate);
            if (tempTimeSpan <= diffTimeSpan) {
              isValidRecurrence = false;
            } else {
              prevDate = addDate;
              if (dayCount == 1) {
                break;
              }

              if (addDate.weekday != DateTime.saturday) {
                byDay =
                    byDay.isNotEmpty && byDay.substring(byDay.length - 1) == 'A'
                        ? byDay + ',' + dayKey
                        : byDay + dayKey;
              } else {
                byDay = byDay + dayKey;
              }

              dayCount++;
            }
          } else {
            prevDate = addDate;
            count++;
            byDay = byDay.isNotEmpty && byDay.substring(byDay.length - 1) == 'A'
                ? byDay + ',' + dayKey
                : byDay + dayKey;
            dayCount++;
          }

          if (recurrenceProperties.recurrenceRange ==
              RecurrenceRange.noEndDate) {
            recCount++;
          }

          switch (addDate.weekday) {
            case DateTime.sunday:
              {
                su = dayCount;
                break;
              }

            case DateTime.monday:
              {
                mo = dayCount;
                break;
              }

            case DateTime.tuesday:
              {
                tu = dayCount;
                break;
              }

            case DateTime.wednesday:
              {
                we = dayCount;
                break;
              }

            case DateTime.thursday:
              {
                th = dayCount;
                break;
              }

            case DateTime.friday:
              {
                fr = dayCount;
                break;
              }

            case DateTime.saturday:
              {
                sa = dayCount;
                break;
              }
          }

          dayCount = 0;
          dayKey = '';
        }

        addDate = addDate.weekday == DateTime.saturday
            ? addDate.add(
                Duration(days: ((recurrenceProperties.interval - 1) * 7) + 1))
            : addDate.add(const Duration(days: 1));
        i = i + 1;
      }

      byDay = _sortByDay(byDay);
      rRule = rRule + byDay;

      if (recurrenceProperties.interval > 0) {
        rRule = rRule + ';INTERVAL=' + recurrenceProperties.interval.toString();
      }

      if (recurrenceProperties.recurrenceRange == RecurrenceRange.count) {
        rRule = rRule + ';COUNT=' + recCount.toString();
      } else if (recurrenceProperties.recurrenceRange ==
          RecurrenceRange.endDate) {
        final DateFormat format = DateFormat('yyyyMMdd');
        rRule = rRule + ';UNTIL=' + format.format(endDate);
      }
    }
  } else if (recurrenceProperties.recurrenceType == RecurrenceType.monthly) {
    if ((recCount > 0 &&
            recurrenceProperties.recurrenceRange == RecurrenceRange.count) ||
        recurrenceProperties.recurrenceRange == RecurrenceRange.noEndDate ||
        ((startDate.isBefore(endDate) || startDate == endDate) &&
            recurrenceProperties.recurrenceRange == RecurrenceRange.endDate)) {
      rRule = 'FREQ=MONTHLY';

      if (recurrenceProperties.week == -1) {
        rRule =
            rRule + ';BYMONTHDAY=' + recurrenceProperties.dayOfMonth.toString();
      } else {
        final DateTime firstDate =
            DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
        final dynamic dayNames =
            List<dynamic>.generate(7, (dynamic index) => index)
                .map((dynamic value) => DateFormat(DateFormat.ABBR_WEEKDAY)
                    .format(firstDate.add(Duration(days: value))))
                .toList();
        final String byDayString = dayNames[recurrenceProperties.dayOfWeek - 1];
        //AbbreviatedDayNames will return three digit char , as per the standard we need to retrun only fisrt two char for RRule so here have removed the last char.
        rRule = rRule +
            ';BYDAY=' +
            byDayString.substring(0, byDayString.length - 1).toUpperCase() +
            ';BYSETPOS=' +
            recurrenceProperties.week.toString();
      }

      if (recurrenceProperties.interval > 0) {
        rRule = rRule + ';INTERVAL=' + recurrenceProperties.interval.toString();
      }

      if (recurrenceProperties.recurrenceRange == RecurrenceRange.count) {
        rRule = rRule + ';COUNT=' + recCount.toString();
      } else if (recurrenceProperties.recurrenceRange ==
          RecurrenceRange.endDate) {
        final DateFormat format = DateFormat('yyyyMMdd');
        rRule = rRule + ';UNTIL=' + format.format(endDate);
      }

      if (DateTime(
                  startDate.year,
                  startDate.month + recurrenceProperties.interval,
                  startDate.day,
                  startDate.hour,
                  startDate.minute,
                  startDate.second)
              .difference(startDate) <
          diffTimeSpan) {
        isValidRecurrence = false;
      }
    }
  } else if (recurrenceProperties.recurrenceType == RecurrenceType.yearly) {
    if ((recCount > 0 &&
            recurrenceProperties.recurrenceRange == RecurrenceRange.count) ||
        recurrenceProperties.recurrenceRange == RecurrenceRange.noEndDate ||
        ((startDate.isBefore(endDate) || startDate == endDate) &&
            recurrenceProperties.recurrenceRange == RecurrenceRange.endDate)) {
      rRule = 'FREQ=YEARLY';

      if (recurrenceProperties.week == -1) {
        rRule = rRule +
            ';BYMONTHDAY=' +
            recurrenceProperties.dayOfMonth.toString() +
            ';BYMONTH=' +
            recurrenceProperties.month.toString();
      } else {
        final DateTime firstDate =
            DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
        final dynamic dayNames =
            List<dynamic>.generate(7, (dynamic index) => index)
                .map((dynamic value) => DateFormat(DateFormat.ABBR_WEEKDAY)
                    .format(firstDate.add(Duration(days: value))))
                .toList();
        final String byDayString = dayNames[recurrenceProperties.dayOfWeek - 1];
        //AbbreviatedDayNames will return three digit char , as per the standard we need to retrun only fisrt two char for RRule so here have removed the last char.
        rRule = rRule +
            ';BYDAY=' +
            byDayString.substring(0, byDayString.length - 1).toUpperCase() +
            ';BYMONTH=' +
            recurrenceProperties.month.toString() +
            ';BYSETPOS=' +
            recurrenceProperties.week.toString();
      }

      if (recurrenceProperties.interval > 0) {
        rRule = rRule + ';INTERVAL=' + recurrenceProperties.interval.toString();
      }

      if (recurrenceProperties.recurrenceRange == RecurrenceRange.count) {
        rRule = rRule + ';COUNT=' + recCount.toString();
      } else if (recurrenceProperties.recurrenceRange ==
          RecurrenceRange.endDate) {
        final DateFormat format = DateFormat('yyyyMMdd');
        rRule = rRule + ';UNTIL=' + format.format(endDate);
      }

      if (DateTime(
                  startDate.year + recurrenceProperties.interval,
                  startDate.month,
                  startDate.day,
                  startDate.hour,
                  startDate.minute,
                  startDate.second)
              .difference(startDate) <
          diffTimeSpan) {
        isValidRecurrence = false;
      }
    }
  }

  if (!isValidRecurrence) {
    rRule = '';
  }

  return rRule;
}

List<String> _findKeyIndex(List<String> ruleArray) {
  int byMonthDayPosition = 0;
  int byDayPosition = 0;
  String reccount = '';
  String daily = '';
  String weekly = '';
  String monthly = '';
  String yearly = '';
  String bySetPos = '';
  String bySetPosCount = '';
  String interval = '';
  String intervalCount = '';
  String count = '';
  String byDay = '';
  String byDayValue = '';
  String byMonthDay = '';
  String byMonthDayCount = '';
  String byMonth = '';
  String byMonthCount = '';
  const String weeklyByDay = '';
  String until = '';
  String untilValue = '';

  for (int i = 0; i < ruleArray.length; i++) {
    if (ruleArray[i] == 'COUNT') {
      count = ruleArray[i];
      reccount = ruleArray[i + 1];
      continue;
    }

    if (ruleArray[i] == 'DAILY') {
      daily = ruleArray[i];
      continue;
    }

    if (ruleArray[i] == 'WEEKLY') {
      weekly = ruleArray[i];
      continue;
    }

    if (ruleArray[i] == 'INTERVAL') {
      interval = ruleArray[i];
      intervalCount = ruleArray[i + 1];
      continue;
    }

    if (ruleArray[i] == 'UNTIL') {
      until = ruleArray[i];
      untilValue = ruleArray[i + 1];
      continue;
    }

    if (ruleArray[i] == 'MONTHLY') {
      monthly = ruleArray[i];
      continue;
    }

    if (ruleArray[i] == 'YEARLY') {
      yearly = ruleArray[i];
      continue;
    }

    if (ruleArray[i] == 'BYSETPOS') {
      bySetPos = ruleArray[i];
      bySetPosCount = ruleArray[i + 1];
      continue;
    }

    if (ruleArray[i] == 'BYDAY') {
      byDayPosition = i;
      byDay = ruleArray[i];
      byDayValue = ruleArray[i + 1];
      continue;
    }

    if (ruleArray[i] == 'BYMONTH') {
      byMonth = ruleArray[i];
      byMonthCount = ruleArray[i + 1];
      continue;
    }

    if (ruleArray[i] == 'BYMONTHDAY') {
      byMonthDayPosition = i;
      byMonthDay = ruleArray[i];
      byMonthDayCount = ruleArray[i + 1];
      continue;
    }
  }

  return <String>[
    reccount,
    daily,
    weekly,
    monthly,
    yearly,
    bySetPos,
    bySetPosCount,
    interval,
    intervalCount,
    until,
    untilValue,
    count,
    byDay,
    byDayValue,
    byMonthDay,
    byMonthDayCount,
    byMonth,
    byMonthCount,
    weeklyByDay,
    byMonthDayPosition.toString(),
    byDayPosition.toString()
  ];
}

List<String> _findWeeklyRule(List<String> weeklyRule) {
  final List<String> result = <String>[];
  for (int i = 0; i < weeklyRule.length; i++) {
    if (weeklyRule[i].contains('BYDAY')) {
      result.add(weeklyRule[i]);
      result.add(i.toString());
      break;
    }
  }

  return result;
}

int _getWeekDay(String weekDay) {
  int index = 1;
  final DateTime firstDate =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
  final dynamic dayNames = List<dynamic>.generate(7, (dynamic index) => index)
      .map((dynamic value) => DateFormat(DateFormat.ABBR_WEEKDAY)
          .format(firstDate.add(Duration(days: value))))
      .toList();
  for (int i = 0; i < 7; i++) {
    final dynamic dayName = dayNames[i];
    //AbbreviatedDayNames will return three digit char , user may give 2 digit char also as per the standard so here have checked the char count.
    if (dayName.toUpperCase() == weekDay ||
        weekDay.length == 2 &&
            dayName.substring(0, dayName.length - 1).toUpperCase() == weekDay) {
      index = i;
    }
  }

  return index + 1;
}

List<String> _splitRule(String text, List<String> patterns) {
  final List<String> result = <String>[];
//  List<Object> splitedString = text.split(patterns[0]);
//  for (int i = 0; i < splitedString.length; i++) {
//    String string = splitedString[i];
//    bool isSplited = false;
//    for (int j = 0; j < patterns.length; j++) {
//      if (string.contains(patterns[j])) {
//        isSplited = true;
//        List<Object> recursiveString = string.split(patterns[j]);
//        for (int k = 0; k < recursiveString.length; k++) {
//          splitedString.add(recursiveString[k]);
//        }
//      }
//    }
//
//    if (isSplited) {
//      splitedString.removeAt(i);
//      i--;
//    }
//    else {
//      result.add(string);
//    }
//  }

  int startIndex = 0;
  for (int i = 0; i < text.length; i++) {
    final String charValue = text[i];
    for (int j = 0; j < patterns.length; j++) {
      if (charValue == patterns[j]) {
        result.add(text.substring(startIndex, i));
        startIndex = i + 1;
      }
    }
  }

  if (startIndex != text.length) {
    result.add(text.substring(startIndex, text.length));
  }

  return result;
}

bool _isRecurrenceDate(
    DateTime addDate, List<String> weeklyRule, int weeklyByDayPos) {
  bool isRecurrenceDate = false;
  switch (addDate.weekday) {
    case DateTime.sunday:
      {
        if (weeklyRule[weeklyByDayPos].contains('SU')) {
          isRecurrenceDate = true;
        }

        break;
      }

    case DateTime.monday:
      {
        if (weeklyRule[weeklyByDayPos].contains('MO')) {
          isRecurrenceDate = true;
        }

        break;
      }

    case DateTime.tuesday:
      {
        if (weeklyRule[weeklyByDayPos].contains('TU')) {
          isRecurrenceDate = true;
        }

        break;
      }

    case DateTime.wednesday:
      {
        if (weeklyRule[weeklyByDayPos].contains('WE')) {
          isRecurrenceDate = true;
        }

        break;
      }

    case DateTime.thursday:
      {
        if (weeklyRule[weeklyByDayPos].contains('TH')) {
          isRecurrenceDate = true;
        }

        break;
      }

    case DateTime.friday:
      {
        if (weeklyRule[weeklyByDayPos].contains('FR')) {
          isRecurrenceDate = true;
        }

        break;
      }

    case DateTime.saturday:
      {
        if (weeklyRule[weeklyByDayPos].contains('SA')) {
          isRecurrenceDate = true;
        }

        break;
      }
  }

  return isRecurrenceDate;
}

void _setWeeklyRecurrenceDate(DateTime addDate, List<String> weeklyRule,
    int weeklyByDayPos, List<DateTime> recDateCollection) {
  switch (addDate.weekday) {
    case DateTime.sunday:
      {
        if (weeklyRule[weeklyByDayPos].contains('SU')) {
          recDateCollection.add(addDate);
        }

        break;
      }

    case DateTime.monday:
      {
        if (weeklyRule[weeklyByDayPos].contains('MO')) {
          recDateCollection.add(addDate);
        }

        break;
      }

    case DateTime.tuesday:
      {
        if (weeklyRule[weeklyByDayPos].contains('TU')) {
          recDateCollection.add(addDate);
        }

        break;
      }

    case DateTime.wednesday:
      {
        if (weeklyRule[weeklyByDayPos].contains('WE')) {
          recDateCollection.add(addDate);
        }

        break;
      }

    case DateTime.thursday:
      {
        if (weeklyRule[weeklyByDayPos].contains('TH')) {
          recDateCollection.add(addDate);
        }

        break;
      }

    case DateTime.friday:
      {
        if (weeklyRule[weeklyByDayPos].contains('FR')) {
          recDateCollection.add(addDate);
        }

        break;
      }

    case DateTime.saturday:
      {
        if (weeklyRule[weeklyByDayPos].contains('SA')) {
          recDateCollection.add(addDate);
        }

        break;
      }
  }
}

String _sortByDay(String byDay) {
  final List<String> sortedDays = <String>[
    'SU',
    'MO',
    'TU',
    'WE',
    'TH',
    'FR',
    'SA'
  ];
  String weeklydaystring = '';
  int count = 0;
  for (int i = 0; i < sortedDays.length; i++) {
    if (!byDay.contains(sortedDays[i])) {
      continue;
    }

    count++;
    String day = sortedDays[i];
    if (count > 1) {
      day = ',' + day;
    }

    weeklydaystring = weeklydaystring + day;
  }

  return weeklydaystring;
}

String intToDay(int n) {
  switch (n) {
    case 0:
      return "saturday";
    case 1:
      return "sunday";
    case 2:
      return "monday";
    case 3:
      return "tuesday";
    case 4:
      return "wednesday";
    case 5:
      return "thursday";
    case 6:
      return "friday";
    case 7:
      return "saturday";
    default:
      return "error";
  }
}

int weekDayIL(int weekday) => (weekday % 7) + 1;

String rawDateToDateString(DateTime rawDate) =>
    rawDate.toString().substring(0, 10);

String parseDateToHebrew(String date) {
  return date.substring(8) +
      "/" +
      date.substring(5, 7) +
      "/" +
      date.substring(0, 4);
}



bool isUpComing(String dateString) {
  if (DateTime.parse(dateString).difference(DateTime.now()).inMinutes > 0) {
    return true;
  } else
    return false;
}

int dateStringComparator(String d1, String d2) {
  if (DateTime.parse(d1).difference(DateTime.parse(d2)).inSeconds > 0) {
    return 1;
  }
  return -1;
}

// DateTime setActivityRawDate(DateTime rawDate, String startTime) {
//   var newHour = int.parse(startTime.substring(0, startTime.indexOf(':')));
//   var newMinute = int.parse(startTime.substring(startTime.indexOf(':') + 1));

//   return DateTime(rawDate.year, rawDate.month, rawDate.day, newHour, newMinute);
// }

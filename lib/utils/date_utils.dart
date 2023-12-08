import 'package:intl/intl.dart';

class DateUtil {
  static String getStringDate(DateTime date, String lang) {
    var now = DateTime.now();
    var returnVal;
    if (now.year == date.year &&
        now.month == date.month &&
        now.day == date.day) {
      if (lang == "en") {
        returnVal = "Today";
      }
      if (lang == "es") {
        returnVal = "Este Día";
      }
      if (lang == "fr") {
        returnVal = "Aujourd'hui";
      }
      return returnVal;
      //lang == "en" ?  : "Hoy";
    }
    var formatter = DateFormat('EEE, dd MMM yyyy');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  static String getStringDateOnly(DateTime date) {
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  static String getStringDateTime(DateTime date) {
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  static String getPrettyDate(String date) {
    //2022-09-02T09:56:14.000Z
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var inputDate = inputFormat.parse(date); // <-- dd/MM 24H format

    var outputFormat = DateFormat('EEE, MMM d yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String getPrettyDateFromUtc(String date) {
    //2022-09-02T09:56:14.000Z
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var inputDate =
        inputFormat.parse(date, true).toLocal(); // <-- dd/MM 24H format

    var outputFormat = DateFormat('EEE, MMM d yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String getPrettyTimeFromUtc(String date) {
    //2022-09-02T09:56:14.000Z
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var inputDate =
        inputFormat.parse(date, true).toLocal(); // <-- dd/MM 24H format

    var outputFormat = DateFormat('HH:mm');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String getPrettyDateTimeFromUtc(String date) {
    //2022-09-02T09:56:14.000Z
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    var inputDate =
        inputFormat.parse(date, true).toLocal(); // <-- dd/MM 24H format

    var outputFormat = DateFormat('HH:mm MMM d yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static bool isDateIsOnRange(String date, int range) {
    //2022-09-02T09:56:14.000Z
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    var inputDate = inputFormat
        .parse(date, true)
        .toLocal()
        .add(const Duration(minutes: 30)); // <-- dd/MM 24H format
    var now = DateTime.now();
    bool enableDisable =
        inputDate.difference(now).inMinutes <= 30 && now.isBefore(inputDate);
    // return inputDate.difference(now).inMinutes <= 30 && now.isBefore(inputDate);
    return enableDisable;
  }

  static int remainingTime(String date) {
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    var inputDate = inputFormat
        .parse(date, true)
        .toLocal()
        .add(const Duration(minutes: 30)); // <-- dd/MM 24H format
    var now = DateTime.now();
    if (now.isBefore(inputDate)) {
      return inputDate.difference(now).inMinutes;
    } else {
      return 0;
    }
  }
}

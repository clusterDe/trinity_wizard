import 'package:intl/intl.dart';

class DateTimeHelper {
  static String inputDateFormat = 'yyyy-MM-dd HH:mm:ss:SSSa';

  static String outputDate = 'dd MMMM yyyy';

  static String inputDate = 'dd/MM/yyyy';

  static String formatDate({required DateTime dateTime}) {
    var format = DateFormat(outputDate).format(dateTime);

    return format;
  }

  static String formatDateFromString({required String date}) {
    var parse = DateFormat(inputDate).parse(date);
    var format = DateFormat(outputDate).format(parse);

    return format;
  }

  static String formatDateToDb({required String date}) {
    var parse = DateFormat(outputDate).parse(date);
    var format = DateFormat(inputDate).format(parse);

    return format;
  }
}

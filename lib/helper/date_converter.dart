import 'package:intl/intl.dart';

class DateConverter {

  static String formatDate(DateTime date) {
    return DateFormat('MMMM d, y').format(date);
  }

  static String today() {
    final d = DateTime.now();
    final months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
    return "${d.day} ${months[d.month-1]}, ${d.year}";
  }

  static String greeting() {
    final h = DateTime.now().hour;

    if (h >= 0 && h < 5) {
      return "Burning the midnight oil?";
    } else if (h >= 5 && h < 7) {
      return "Rise and Shine!";
    } else if (h >= 7 && h < 12) {
      return "Good Morning!";
    } else if (h == 12) {
      return "Happy Noon!";
    } else if (h > 12 && h < 17) {
      return "Good Afternoon!";
    } else if (h >= 17 && h < 19) {
      return "Good Evening!";
    } else if (h >= 19 && h < 22) {
      return "Hope you had a great day!";
    } else {
      return "Good Night!";
    }
  }

}
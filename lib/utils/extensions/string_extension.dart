import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  static String differenceBetweenDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    final minutes = difference.inMinutes;
    final hours = difference.inHours;
    final days = difference.inDays;
    final months = (difference.inDays / 30).floor();
    final years = (difference.inDays / 365).floor();

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return minutes == 1 ? '1 minute ago' : '$minutes minutes ago';
    } else if (difference.inHours < 24) {
      return hours == 1 ? '1 hour ago' : '$hours hours ago';
    } else if (difference.inDays < 30) {
      return days == 1 ? '1 day ago' : '$days days ago';
    } else if (difference.inDays < 365) {
      return months == 1 ? '1 month ago' : '$months months ago';
    } else {
      return years == 1 ? '1 year ago' : '$years years ago';
    }
  }

  static String decodeHtmlString({required String htmlString}) {
    return HtmlUnescape().convert(htmlString);
  }

  static String dateFormatter(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String dateToDayFormatter(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  static String getButtonLabel(String status) {
    return switch (status) {
      'Pending' => 'I\' m doing it!',
      'In Progress' => 'I\' m done!',
      _ => 'I\' m doing it!',
    };
  }

  static String getAlertDialogContentLabel(String status) {
    return switch (status) {
      'Pending' => 'Are you sure you\'re starting this task?',
      'In Progress' => 'Are you sure you\'ve completed this task?',
      _ => '',
    };
  }
}

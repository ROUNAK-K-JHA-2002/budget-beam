import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<Map<String, dynamic>> profileItems = [
  {
    "icon": Icons.settings,
    "title": "Settings",
    "route": "/settings",
    "color": Colors.blue,
  },
  {
    "icon": Icons.diamond,
    "title": "Upgrade to Premium",
    "route": "/upgrade",
    "color": Colors.purple,
  },
  {
    "icon": Icons.share,
    "title": "Invite Friends",
    "route": "/invite",
    "color": Colors.green,
  },
  {
    "icon": Icons.admin_panel_settings,
    "title": "Data and Privacy",
    "route": "/data",
    "color": Colors.red,
  },
  {
    "icon": Icons.backup,
    "title": "Backup and Restore",
    "route": "/backup",
    "color": Colors.orange,
  },
  {
    "icon": Icons.feedback,
    "title": "Feedback / Bug Report",
    "route": "/developer",
    "color": Colors.amber,
  },
  {
    "icon": Icons.logout,
    "title": "Logout",
    "route": "/logout",
    "color": Colors.grey,
  },
];

List<String> tags = ['food', 'travel', 'entertainment', 'other'];
List<Map<String, dynamic>> categories = [
  {
    "text": "Food & Dining",
    "icon": Icons.fastfood,
    "color": Colors.orange,
  },
  {
    "text": "Trip",
    "icon": Icons.flight,
    "color": Colors.amber,
  },
  {
    "text": "Entertainment",
    "icon": Icons.movie,
    "color": Colors.purple,
  },
  {
    "text": "Housing",
    "icon": Icons.home,
    "color": Colors.blue,
  },
  {
    "text": "Transportation",
    "icon": Icons.directions_car,
    "color": Colors.yellow,
  },
  {
    "text": "Shopping",
    "icon": Icons.shopping_bag,
    "color": Colors.pink,
  },
  {
    "text": "Health & Fitness",
    "icon": Icons.fitness_center,
    "color": Colors.red,
  },
  {
    "text": "Savings & Investments",
    "icon": Icons.savings,
    "color": Colors.teal,
  },
  {
    "text": "Salary",
    "icon": Icons.attach_money,
    "color": Colors.green,
  },
  {
    "text": "Other",
    "icon": Icons.more,
    "color": Colors.grey,
  }
];

List<String> types = ['Spend', 'Income'];

Map<String, dynamic> generateColorAndAbbreviation(String inputString, int? id) {
  // Define a list of colors
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.cyan,
  ];

  // Select a random color from the list
  Color randomColor = colors[13 % colors.length];

  // Generate the abbreviated string
  List<String> words = inputString.split(' ');
  String abbreviatedString = words.map((word) => word[0].toUpperCase()).join();

  return {
    'color': randomColor,
    'abbreviation': abbreviatedString,
  };
}

String formatDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(Duration(days: 1));

  if (date.isAfter(today)) {
    return 'Today';
  } else if (date.isAfter(yesterday)) {
    return 'Yesterday';
  } else {
    return DateFormat('MMM d, yyyy').format(date);
  }
}

List<String> monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

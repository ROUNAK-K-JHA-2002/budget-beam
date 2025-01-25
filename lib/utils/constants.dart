import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<Map<String, dynamic>> profileItems = [
  {
    "icon": Icons.settings,
    "title": "Settings",
    "route": "/settings",
  },
  {
    "icon": Icons.diamond,
    "title": "Upgrade to Premium",
    "route": "/upgrade",
  },
  {
    "icon": Icons.share,
    "title": "Invite Friends",
    "route": "/invite",
  },
  {
    "icon": Icons.admin_panel_settings,
    "title": "Data and Privacy",
    "route": "/data",
  },
  {
    "icon": Icons.backup,
    "title": "Backup and Restore",
    "route": "/backup",
  },
  {
    "icon": Icons.feedback,
    "title": "Feedback / Bug Report",
    "route": "/developer",
  },
  {
    "icon": Icons.request_page,
    "title": "Feature Request",
    "route": "/developer",
  },
  {
    "icon": Icons.code,
    "title": "Developer Contact",
    "route": "/developer",
  },
  {
    "icon": Icons.logout,
    "title": "Logout",
    "route": "/logout",
  },
];

List<String> tags = ['food', 'travel', 'entertainment', 'other'];
List<Map<String, dynamic>> categories = [
  {
    "text": "Food & Dining",
    "icon": Icons.fastfood, // Replace with your icon library if needed
    "color": Colors.orange,
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
    "color": Colors.green,
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

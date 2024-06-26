import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class THelperFunctions {
  // static Map<String, Color> basicColors = {
  //   'Red': Colors.red,
  //   'Pink': Colors.pink,
  //   'Purple': Colors.purple,
  //   'DeepPurple': Colors.deepPurple,
  //   'Indigo': Colors.indigo,
  //   'Blue': Colors.blue,
  //   'LightBlue': Colors.lightBlue,
  //   'Cyan': Colors.cyan,
  //   'Teal': Colors.teal,
  //   'Green': Colors.green,
  //   'LightGreen': Colors.lightGreen,
  //   'Lime': Colors.lime,
  //   'Yellow': Colors.yellow,
  //   'Amber': Colors.amber,
  //   'Orange': Colors.orange,
  //   'DeepOrange': Colors.deepOrange,
  //   'Brown': Colors.brown,
  //   'Grey': Colors.grey,
  //   'Black': Colors.black,
  //   'White': Colors.white,
  // };

  static Map<String, Color> basicColors = {
    'Red': Colors.red,
    'Pink': Colors.pink,
    'Purple': Colors.purple,
    'DeepPurple': Colors.deepPurple,
    'Indigo': Colors.indigo,
    'Blue': Colors.blue,
    'LightBlue': Colors.lightBlue,
    'Cyan': Colors.cyan,
    'Teal': Colors.teal,
    'Green': Colors.green,
    'LightGreen': Colors.lightGreen,
    'Lime': Colors.lime,
    'Yellow': Colors.yellow,
    'Amber': Colors.amber,
    'Orange': Colors.orange,
    'DeepOrange': Colors.deepOrange,
    'Brown': Colors.brown,
    'Grey': Colors.grey,
    'Black': Colors.black,
    'White': Colors.white,
  };

  static Map<String, String> vietnameseToEnglishColors = {
    'Trắng': 'White',
    'Đen': 'Black',
    'Đỏ': 'Red',
    'Hồng': 'Pink',
    'Xanh': 'Blue', // Có thể điều chỉnh nếu cần thiết cho các sắc thái khác nhau
    'Tím': 'Purple',
    'Vàng': 'Yellow',
    'Cam': 'Orange',
    'Nâu': 'Brown',
    'Xám': 'Grey',
    'Xanh lá': 'Green',
    'Xanh dương': 'Blue', // Có thể điều chỉnh nếu cần thiết cho các sắc thái khác nhau
  };

  // static Color? getColor(String value) {
  //   return basicColors[value];
  // }
  static Color? getColor(String colorName) {
    String? englishColorName = vietnameseToEnglishColors[colorName.toLowerCase()];
    if (englishColorName == null) {
      return null;
    }
    return basicColors[englishColorName];
  }
  
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return "${text.substring(0, maxLength)}...";
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize(){
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
  return MediaQuery.of(Get.context!).size.height;
}

static double screenWidth() {
  return MediaQuery.of(Get.context!).size.width;
}

static String getFormattedDate(DateTime date, {String format = 'dd MMM yyyy'}) {
  return DateFormat(format).format(date);
}

static List<T> removeDuplicates<T>(List<T> list) {
  return list.toSet().toList();
}

static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
  final wrappedList = <Widget>[];

  for (var i = 0; i < widgets.length; i += rowSize) {
    final rowChildren = widgets.sublist(i, i + rowSize < widgets.length ? i + rowSize : widgets.length);
    wrappedList.add(Row(children: rowChildren));
  }

  return wrappedList;
}

}

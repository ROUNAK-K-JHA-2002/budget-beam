import 'package:budgetbeam/components/text_field.dart';
import 'package:budgetbeam/main.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.system);

  final ValueNotifier<String> currencyNotifier = ValueNotifier('INR');
  final TextEditingController dailyBudgetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    String? themeMode = await storage.read(key: 'themeMode');
    if (themeMode != null) {
      switch (themeMode) {
        case 'light':
          themeNotifier.value = ThemeMode.light;
          break;
        case 'dark':
          themeNotifier.value = ThemeMode.dark;
          break;
        case 'system':
        default:
          themeNotifier.value = ThemeMode.system;
          break;
      }
    }
  }

  Future<void> _saveThemeMode(ThemeMode mode) async {
    String modeString;
    switch (mode) {
      case ThemeMode.light:
        modeString = 'light';
        break;
      case ThemeMode.dark:
        modeString = 'dark';
        break;
      case ThemeMode.system:
      default:
        modeString = 'system';
        break;
    }
    await storage.write(key: 'themeMode', value: modeString);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Settings",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  size: 20.sp,
                ),
              )
            ],
          ),
          Text(
            "Manage your account and preferences here.",
            style: TextStyle(
              fontSize: 15.sp,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            "Set Daily Budget",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor),
          ),
          Text(
            "You will be shown an warning if you exceed your daily budget.",
            style: TextStyle(fontSize: 14.sp),
          ),
          SizedBox(height: 1.5.h),
          TextField(
            controller: dailyBudgetController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter your daily budget',
              border: OutlineInputBorder(),
            ),
          ),
          MaterialButton(
            color: kPrimaryColor,
            onPressed: () {},
            elevation: 4,
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 2.h),
          Text(
            "Theme",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor),
          ),
          Text(
            "Choose between light and dark mode (Default: System Default).",
            style: TextStyle(fontSize: 14.sp),
          ),
          Wrap(
            spacing: 8.0,
            children: [
              ChoiceChip(
                label: const Text('Light'),
                selected: themeNotifier.value == ThemeMode.light,
                onSelected: (bool selected) {
                  if (selected) {
                    themeNotifier.value = ThemeMode.light;
                    _saveThemeMode(ThemeMode.light);
                  }
                },
              ),
              ChoiceChip(
                label: const Text('Dark'),
                selected: themeNotifier.value == ThemeMode.dark,
                onSelected: (bool selected) {
                  if (selected) {
                    themeNotifier.value = ThemeMode.dark;
                    _saveThemeMode(ThemeMode.dark);
                  }
                },
              ),
              ChoiceChip(
                label: const Text('System Default'),
                selected: themeNotifier.value == ThemeMode.system,
                onSelected: (bool selected) {
                  if (selected) {
                    themeNotifier.value = ThemeMode.system;
                    _saveThemeMode(ThemeMode.system);
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            "Currency",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor),
          ),
          Text(
            "Choose your currency (Default: INR).",
            style: TextStyle(fontSize: 14.sp),
          ),
          Wrap(
            spacing: 8.0,
            children: [
              ChoiceChip(
                label: const Text('INR'),
                selected: themeNotifier.value == ThemeMode.light,
                onSelected: (bool selected) {
                  if (selected) {
                    themeNotifier.value = ThemeMode.light;
                    _saveThemeMode(ThemeMode.light);
                  }
                },
              ),
              ChoiceChip(
                label: const Text('USD'),
                selected: themeNotifier.value == ThemeMode.dark,
                onSelected: (bool selected) {
                  if (selected) {
                    themeNotifier.value = ThemeMode.dark;
                    _saveThemeMode(ThemeMode.dark);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

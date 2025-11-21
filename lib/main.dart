import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants/app_colors.dart';
import 'constants/app_dimens.dart';
import 'constants/app_texts.dart';
import 'screens/home_screen.dart';
import 'screens/listing_screen.dart';
import 'screens/saves_screen.dart';

void main() {
  runApp(const CarAdvisorApp());
}

class CarAdvisorApp extends StatelessWidget {
  const CarAdvisorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lightScheme = ColorScheme.fromSeed(
      seedColor: AppColors.seedColor,
      brightness: Brightness.light,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppTexts.appTitle,
      theme: ThemeData(
        colorScheme: lightScheme,
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.seedColor,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          toolbarTextStyle: const TextStyle(color: Colors.white),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.seedColor,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.chipBackground,
          selectedColor: AppColors.seedColor.withValues(alpha: 0.12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
          ),
          labelStyle: TextStyle(color: lightScheme.onSurface),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.paddingSmall,
            vertical: 0,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
            borderSide: BorderSide(color: AppColors.borderLight),
          ),
        ),
      ),
      home: const CarAdvisorHome(),
    );
  }
}

class CarAdvisorHome extends StatefulWidget {
  const CarAdvisorHome({super.key});

  @override
  State<CarAdvisorHome> createState() => _CarAdvisorHomeState();
}

class _CarAdvisorHomeState extends State<CarAdvisorHome> {
  int _selectedIndex = 0;

  static const List<String> _labels = [
    AppTexts.navHome,
    AppTexts.navListing,
    AppTexts.navSaves,
  ];
  static const List<IconData> _icons = [Icons.home, Icons.list, Icons.bookmark];
  static const List<Widget> _screens = [
    HomeScreen(),
    ListingScreen(),
    SavesScreen(),
  ];

  void _onDestinationSelected(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBottomAppBar(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return BottomAppBar(
      elevation: isDark ? AppDimens.elevationLow : AppDimens.elevationMedium,
      shadowColor: isDark
          ? Colors.black54
          : Colors.black.withValues(alpha: 0.08),
      color: isDark ? colorScheme.surface : Colors.white,
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.spaceSmall,
        horizontal: AppDimens.paddingSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_labels.length, (index) {
          final label = _labels[index];
          final icon = _icons[index];
          final isSelected = index == _selectedIndex;
          final itemColor = isSelected
              ? colorScheme.primary
              : colorScheme.onSurfaceVariant;

          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
              onTap: () => _onDestinationSelected(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimens.paddingSmall,
                  horizontal: AppDimens.spaceSmall,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: itemColor),
                    const SizedBox(height: 4),
                    Text(
                      label,
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: itemColor),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final label = _labels[_selectedIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(label),
        elevation: 0,
        actions: _selectedIndex == 0
            ? [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_border),
                ),
              ]
            : null,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }
}

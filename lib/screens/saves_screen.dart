import 'package:flutter/material.dart';
import '../constants/app_dimens.dart';
import '../constants/app_texts.dart';

class SavesScreen extends StatelessWidget {
  const SavesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingLarge,
        vertical: AppDimens.paddingMedium,
      ),
      child: ListView(
        children: [
          const SizedBox(height: AppDimens.spaceMedium),
          const ListTile(
            title: Text(AppTexts.favorites),
            subtitle: Text(AppTexts.favoritesSubtitle),
            dense: true,
          ),
          const ListTile(
            title: Text(AppTexts.trackedListings),
            subtitle: Text(AppTexts.trackedSubtitle),
            dense: true,
          ),
          const ListTile(
            title: Text(AppTexts.notes),
            subtitle: Text(AppTexts.notesSubtitle),
            dense: true,
          ),
          const SizedBox(height: AppDimens.space200),
        ],
      ),
    );
  }
}

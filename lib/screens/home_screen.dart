import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_texts.dart';
import '../constants/app_dimens.dart';
import '../widgets/listing/car_card.dart';
import '../widgets/home/overlay_unfocus_textfield.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingLarge,
        vertical: AppDimens.paddingMedium,
      ),
      children: [
        const SizedBox(height: AppDimens.spaceMedium),
        // Search bar
        Container(
          decoration: BoxDecoration(
            color: isDark ? colorScheme.surface : Colors.white,
            borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
            border: Border.all(
              color: isDark ? Colors.transparent : AppColors.borderDefault,
            ),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: AppColors.cardShadowLight,
                      blurRadius: AppDimens.blurRadiusSmall,
                      offset: const Offset(0, AppDimens.shadowOffsetSmall),
                    ),
                  ],
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.paddingMedium,
            vertical: AppDimens.spaceSmall,
          ),
          child: Row(
            children: [
              const Icon(Icons.search, size: AppDimens.iconLarge),
              const SizedBox(width: AppDimens.spaceMedium),
              Expanded(
                child: OverlayUnfocusTextField(
                  initialValue: '',
                  decoration: const InputDecoration(
                    hintText: AppTexts.searchHint,
                    border: InputBorder.none,
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                  onApply: (value) {
                    // TODO: wire search logic
                    debugPrint('Search applied: $value');
                  },
                ),
              ),
              const SizedBox(width: AppDimens.spaceMedium),
              IconButton(onPressed: () {}, icon: const Icon(Icons.mic)),
            ],
          ),
        ),
        const SizedBox(height: AppDimens.paddingMedium),

        Text(
          AppTexts.recentSearches,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppDimens.spaceMedium),
        Wrap(
          spacing: AppDimens.spaceMedium,
          children: [
            Chip(label: Text('Toyota Camry')),
            Chip(label: Text('2019 SUV')),
            Chip(label: Text('Under \$30,000')),
          ],
        ),

        const SizedBox(height: AppDimens.space18),
        Text(
          AppTexts.highMarketShare,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppDimens.spaceMedium),

        CarCard(
          title: '2020 Toyota Camry',
          price: '\$14,900',
          marketShare: '2.8%',
          imageUrl: 'https://picsum.photos/seed/camry/600/400',
          tags: const [
            AppTexts.oneOwner,
            AppTexts.noAccidents,
            AppTexts.higherTrim,
          ],
          badgeLabel: AppTexts.badgeOld,
        ),

        CarCard(
          title: '2021 Honda CR-V',
          price: '\$21,500',
          marketShare: '2.1%',
          imageUrl: 'https://picsum.photos/seed/crv/600/400',
          tags: const [AppTexts.twoOwners, AppTexts.noAccidents],
          badgeLabel: AppTexts.badgeNew,
        ),

        const SizedBox(height: AppDimens.space80),
      ],
    );
  }
}

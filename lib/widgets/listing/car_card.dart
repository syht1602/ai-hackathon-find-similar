import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_texts.dart';
import '../../constants/app_dimens.dart';

class CarCard extends StatelessWidget {
  const CarCard({
    super.key,
    required this.title,
    required this.price,
    required this.marketShare,
    required this.imageUrl,
    this.tags = const [],
    this.badgeLabel,
    this.onTap,
  });

  final String title;
  final String price;
  final String marketShare;
  final String imageUrl;
  final List<String> tags;
  final String? badgeLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark
        ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.2)
        : Colors.white;
    final borderColor = isDark ? Colors.transparent : AppColors.borderCard;
    final shadow = isDark
        ? null
        : [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: AppDimens.blurRadiusMedium,
              offset: const Offset(0, AppDimens.shadowOffsetMedium),
            ),
          ];

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.radiusXLarge),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: AppDimens.cardMarginVertical,
        ),
        padding: const EdgeInsets.all(AppDimens.paddingMedium),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(AppDimens.radiusXLarge),
          border: Border.all(color: borderColor),
          boxShadow: shadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (badgeLabel != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.spaceMedium,
                      vertical: AppDimens.spaceXSmall,
                    ),
                    margin: const EdgeInsets.only(left: AppDimens.spaceMedium),
                    decoration: BoxDecoration(
                      color: badgeLabel!.toLowerCase().contains('new')
                          ? colorScheme.primary.withValues(alpha: 0.12)
                          : AppColors.chipBackgroundLight,
                      borderRadius: BorderRadius.circular(
                        AppDimens.radiusMedium,
                      ),
                    ),
                    child: Text(
                      badgeLabel!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: badgeLabel!.toLowerCase().contains('new')
                            ? colorScheme.primary
                            : Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppDimens.spaceMedium),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimens.space10),
                  child: Image.network(
                    imageUrl,
                    width: AppDimens.imageWidthSmall,
                    height: AppDimens.imageHeightSmall,
                    fit: BoxFit.cover,
                    errorBuilder: (c, o, s) => Container(
                      width: AppDimens.imageWidthSmall,
                      height: AppDimens.imageHeightSmall,
                      color: colorScheme.surface,
                      child: const Icon(Icons.directions_car, size: 36),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimens.paddingMedium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        price,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppDimens.spaceSmall),
                      Text(
                        '${AppTexts.marketSharePrefix}$marketShare',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: AppDimens.spaceSmall),
                      Text(
                        '${AppTexts.mpgCity}\n${AppTexts.fuelType}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.spaceMedium),
            Wrap(
              spacing: AppDimens.spaceMedium,
              runSpacing: AppDimens.spaceSmall,
              children: tags
                  .map(
                    (t) => Chip(
                      label: Text(
                        t,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      backgroundColor: isDark
                          ? colorScheme.surface
                          : AppColors.chipBackgroundAlt,
                      visualDensity: VisualDensity.compact,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

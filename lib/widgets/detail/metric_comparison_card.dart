import 'package:flutter/material.dart';
import '../../constants/app_dimens.dart';

/// Reusable metric comparison card for detail analysis
class MetricComparisonCard extends StatelessWidget {
  const MetricComparisonCard({
    super.key,
    required this.icon,
    required this.label,
    required this.selectedTitle,
    required this.selectedValue,
    required this.comparisonTitle,
    required this.comparisonValue,
    required this.difference,
    required this.formatter,
    required this.isLowerBetter,
  });

  final IconData icon;
  final String label;
  final String selectedTitle;
  final String selectedValue;
  final String comparisonTitle;
  final String comparisonValue;
  final num difference;
  final String Function(num) formatter;
  final bool isLowerBetter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isBetter = isLowerBetter ? difference < 0 : difference > 0;
    final color = isBetter
        ? theme.colorScheme.primary
        : theme.colorScheme.error;
    final prefix = difference > 0 ? '+' : '';

    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingLarge),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusXLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: AppDimens.iconLarge,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: AppDimens.spaceMedium),
              Text(
                label,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMedium),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedTitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppDimens.paddingXSmall),
                    Text(
                      selectedValue,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.compare_arrows_rounded,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      comparisonTitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                    const SizedBox(height: AppDimens.paddingXSmall),
                    Text(
                      comparisonValue,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMedium),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.paddingMedium,
              vertical: AppDimens.paddingSmall,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isBetter ? Icons.trending_up : Icons.trending_down,
                  color: color,
                  size: AppDimens.iconSmall,
                ),
                const SizedBox(width: AppDimens.spaceSmall),
                Text(
                  '$prefix${formatter(difference)} ${isBetter ? "better" : "worse"}',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: AppDimens.fontSizeMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

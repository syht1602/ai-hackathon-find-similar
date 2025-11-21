import 'package:flutter/material.dart';

import '../../constants/app_dimens.dart';
import '../../constants/app_texts.dart';
import '../../models/car.dart';

class ComparisonModal extends StatelessWidget {
  const ComparisonModal({
    super.key,
    required this.selectedCar,
    required this.comparisonCar,
  });

  final Car selectedCar;
  final Car comparisonCar;

  String _getComparisonResult() {
    final priceDiff = selectedCar.price - comparisonCar.price;
    final marketDiff = selectedCar.marketShare - comparisonCar.marketShare;

    if (priceDiff < 0 && marketDiff > 0) {
      return AppTexts.betterValue;
    } else if (priceDiff > 0 && marketDiff > 0) {
      return AppTexts.premiumOption;
    } else if (priceDiff < 0 && marketDiff < 0) {
      return AppTexts.budgetChoice;
    } else {
      return AppTexts.tradeOff;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final priceDiff = selectedCar.price - comparisonCar.price;
    final marketDiff = selectedCar.marketShare - comparisonCar.marketShare;
    final mileage = comparisonCar.details['mileage'];
    final selectedMileage = selectedCar.details['mileage'];
    final mileageDiff = (mileage is num && selectedMileage is num)
        ? mileage - selectedMileage
        : null;

    return DraggableScrollableSheet(
      initialChildSize: AppDimens.modalInitialSize,
      minChildSize: AppDimens.modalMinSize,
      maxChildSize: AppDimens.modalMaxSize,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppDimens.radiusModal),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: AppDimens.blurRadiusLarge,
                offset: const Offset(0, -AppDimens.spaceMedium),
              ),
            ],
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: AppDimens.paddingMedium),
                width: AppDimens.modalHandleWidth,
                height: AppDimens.modalHandleHeight,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(AppDimens.space24),
                  children: [
                    // Header
                    _buildHeader(theme),
                    const SizedBox(height: AppDimens.space24),

                    // Price comparison
                    _buildMetricCard(
                      theme,
                      icon: Icons.attach_money_rounded,
                      label: AppTexts.priceComparison,
                      selectedValue: '\$${selectedCar.price}',
                      comparisonValue: '\$${comparisonCar.price}',
                      difference: priceDiff,
                      formatter: (val) => '\$${val.abs()}',
                      isLowerBetter: true,
                    ),
                    const SizedBox(height: AppDimens.paddingMedium),

                    // Market share comparison
                    _buildMetricCard(
                      theme,
                      icon: Icons.trending_up_rounded,
                      label: AppTexts.marketShare,
                      selectedValue:
                          '${selectedCar.marketShare.toStringAsFixed(1)}%',
                      comparisonValue:
                          '${comparisonCar.marketShare.toStringAsFixed(1)}%',
                      difference: marketDiff,
                      formatter: (val) => '${val.abs().toStringAsFixed(1)}%',
                      isLowerBetter: false,
                    ),

                    // Mileage comparison (if available)
                    if (mileageDiff != null) ...[
                      const SizedBox(height: AppDimens.paddingMedium),
                      _buildMetricCard(
                        theme,
                        icon: Icons.speed_rounded,
                        label: AppTexts.mileage,
                        selectedValue:
                            '${selectedMileage.toStringAsFixed(0)} mi',
                        comparisonValue: '${mileage.toStringAsFixed(0)} mi',
                        difference: mileageDiff,
                        formatter: (val) =>
                            '${val.abs().toStringAsFixed(0)} mi',
                        isLowerBetter: true,
                      ),
                    ],

                    const SizedBox(height: AppDimens.space24),
                    _buildSummary(theme),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppDimens.paddingMedium),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.primaryContainer,
              ],
            ),
            borderRadius: BorderRadius.circular(AppDimens.radiusXLarge),
          ),
          child: const Icon(
            Icons.analytics_rounded,
            color: Colors.white,
            size: AppDimens.iconXXLarge,
          ),
        ),
        const SizedBox(width: AppDimens.paddingLarge),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTexts.detailedAnalysis,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppDimens.spaceXSmall),
              Text(
                '${selectedCar.title} vs ${comparisonCar.title}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    ThemeData theme, {
    required IconData icon,
    required String label,
    required String selectedValue,
    required String comparisonValue,
    required num difference,
    required String Function(num) formatter,
    required bool isLowerBetter,
  }) {
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
          // Label row
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

          // Values comparison row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedCar.title,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppDimens.spaceXSmall),
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
                      comparisonCar.title,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                    const SizedBox(height: AppDimens.spaceXSmall),
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

          // Difference indicator
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.paddingMedium,
              vertical: AppDimens.spaceMedium,
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
                  '$prefix${formatter(difference)} ${isBetter ? AppTexts.better : AppTexts.worse}',
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

  Widget _buildSummary(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingLarge),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppDimens.radiusXLarge),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_rounded,
                color: theme.colorScheme.primary,
                size: AppDimens.iconLarge,
              ),
              const SizedBox(width: AppDimens.spaceMedium),
              Text(
                AppTexts.summary,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMedium),
          Text(
            _getComparisonResult(),
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}

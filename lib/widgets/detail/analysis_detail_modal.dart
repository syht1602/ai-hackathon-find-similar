import 'package:flutter/material.dart';
import '../../constants/app_dimens.dart';
import '../../constants/app_texts.dart';
import '../../models/car.dart';
import '../common/gradient_icon_container.dart';
import 'metric_comparison_card.dart';

class AnalysisDetailModal extends StatelessWidget {
  const AnalysisDetailModal({
    super.key,
    required this.selected,
    required this.comparison,
    required this.comparisonResult,
  });

  final Car selected;
  final Car comparison;
  final String comparisonResult;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final priceDiff = selected.price - comparison.price;
    final marketDiff = selected.marketShare - comparison.marketShare;
    final mileage = comparison.details['mileage'];
    final selectedMileage = selected.details['mileage'];
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
                blurRadius: 32,
                offset: const Offset(0, -8),
              ),
            ],
          ),
          child: Column(
            children: [
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
                  padding: const EdgeInsets.all(AppDimens.paddingXXLarge),
                  children: [
                    Row(
                      children: [
                        GradientIconContainer(
                          icon: Icons.analytics_rounded,
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.primaryContainer,
                          ],
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
                              const SizedBox(height: AppDimens.paddingXSmall),
                              Text(
                                '${selected.title} vs ${comparison.title}',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimens.paddingXXLarge),
                    MetricComparisonCard(
                      icon: Icons.attach_money_rounded,
                      label: AppTexts.priceComparison,
                      selectedTitle: selected.title,
                      selectedValue: '\$${selected.price}',
                      comparisonTitle: comparison.title,
                      comparisonValue: '\$${comparison.price}',
                      difference: priceDiff,
                      formatter: (val) => '\$${val.abs()}',
                      isLowerBetter: true,
                    ),
                    const SizedBox(height: AppDimens.paddingMedium),
                    MetricComparisonCard(
                      icon: Icons.trending_up_rounded,
                      label: AppTexts.marketShare,
                      selectedTitle: selected.title,
                      selectedValue:
                          '${selected.marketShare.toStringAsFixed(1)}%',
                      comparisonTitle: comparison.title,
                      comparisonValue:
                          '${comparison.marketShare.toStringAsFixed(1)}%',
                      difference: marketDiff,
                      formatter: (val) => '${val.abs().toStringAsFixed(1)}%',
                      isLowerBetter: false,
                    ),
                    if (mileageDiff != null) ...[
                      const SizedBox(height: AppDimens.paddingMedium),
                      MetricComparisonCard(
                        icon: Icons.speed_rounded,
                        label: AppTexts.mileage,
                        selectedTitle: selected.title,
                        selectedValue:
                            '${selectedMileage.toStringAsFixed(0)} mi',
                        comparisonTitle: comparison.title,
                        comparisonValue: '${mileage.toStringAsFixed(0)} mi',
                        difference: mileageDiff,
                        formatter: (val) =>
                            '${val.abs().toStringAsFixed(0)} mi',
                        isLowerBetter: true,
                      ),
                    ],
                    const SizedBox(height: AppDimens.paddingXXLarge),
                    Container(
                      padding: const EdgeInsets.all(AppDimens.paddingLarge),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer.withValues(
                          alpha: 0.3,
                        ),
                        borderRadius: BorderRadius.circular(
                          AppDimens.radiusXLarge,
                        ),
                        border: Border.all(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.3,
                          ),
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
                            comparisonResult,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../../constants/app_dimens.dart';
import '../../constants/app_texts.dart';
import '../../models/car.dart';

class SimilarCarsCarousel extends StatelessWidget {
  const SimilarCarsCarousel({
    super.key,
    required this.cars,
    required this.selected,
    required this.currentComparison,
    required this.onSelect,
  });

  final List<Car> cars;
  final Car selected;
  final Car? currentComparison;
  final ValueChanged<Car> onSelect;

  @override
  Widget build(BuildContext context) {
    if (cars.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppDimens.paddingSmall),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(
                        alpha: AppDimens.opacityLight,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppDimens.radiusMedium,
                      ),
                    ),
                    child: Icon(
                      Icons.compare_arrows_rounded,
                      color: theme.colorScheme.primary,
                      size: AppDimens.iconLarge,
                    ),
                  ),
                  const SizedBox(width: AppDimens.spaceLarge),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppTexts.compareAlternativesHeader,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          AppTexts.tapCardToCompare,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: AppDimens.opacityVeryHigh,
                            ),
                            fontSize: AppDimens.fontSizeSmall,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppDimens.spaceLarge),
            FilledButton.icon(
              onPressed: () => _openImproveSearchSheet(context),
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.primary.withValues(
                  alpha: AppDimens.opacityLight,
                ),
                foregroundColor: theme.colorScheme.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.spaceLarge,
                  vertical: AppDimens.paddingSmall,
                ),
              ),
              icon: const Icon(
                Icons.auto_fix_high_rounded,
                size: AppDimens.iconMedium,
              ),
              label: const Text(
                AppTexts.improveResultsButton,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.spaceXXLarge),
        SizedBox(
          height: AppDimens.carouselHeight,
          child: ListView.separated(
            padding: const EdgeInsets.only(
              bottom: AppDimens.carouselBottomPadding,
            ),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final car = cars[index];
              final isSelected = currentComparison?.id == car.id;
              final priceDiff = car.price - selected.price;
              final mileage = car.details['mileage'];
              final selectedMileage = selected.details['mileage'];
              final mileageDiff = (mileage is num && selectedMileage is num)
                  ? mileage - selectedMileage
                  : null;
              final mileagePct = (mileageDiff != null && selectedMileage != 0)
                  ? (mileageDiff / selectedMileage) * 100
                  : null;

              return GestureDetector(
                onTap: () => onSelect(car),
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: AppDimens.animationFast,
                  ),
                  curve: Curves.easeInOut,
                  width: AppDimens.carouselCardWidth,
                  padding: const EdgeInsets.all(AppDimens.spaceLarge),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [
                              theme.colorScheme.primary.withValues(
                                alpha: AppDimens.opacityMedium,
                              ),
                              theme.colorScheme.primaryContainer.withValues(
                                alpha: AppDimens.opacityMediumHigh,
                              ),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: isSelected
                        ? null
                        : theme.colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(AppDimens.radiusCard),
                    border: Border.all(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.surfaceContainerHighest,
                      width: AppDimens.borderWidthNormal,
                    ),
                  ),
                  child: DefaultTextStyle.merge(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: AppDimens.carouselImageHeight,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppDimens.radiusLarge,
                            ),
                            child: car.photos.isNotEmpty
                                ? Image.network(
                                    car.photos.first,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    color: theme
                                        .colorScheme
                                        .surfaceContainerHighest,
                                    child: Icon(
                                      Icons.directions_car,
                                      color: theme.colorScheme.onSurface
                                          .withValues(
                                            alpha: AppDimens.opacityHigh,
                                          ),
                                      size: AppDimens.iconXXLarge,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: AppDimens.spaceMedium),
                        Text(
                          car.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: AppDimens.fontSizeMedium,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppDimens.spaceXSmall),
                        _MetricChip(
                          value: '\$${car.price}',
                          color: priceDiff >= 0
                              ? theme.colorScheme.error
                              : theme.colorScheme.primary,
                        ),
                        if (mileage is num)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: AppDimens.spaceXSmall,
                            ),
                            child: _MetricChip(
                              value: mileagePct == null
                                  ? '${mileage.toStringAsFixed(0)} mi'
                                  : '${mileage.toStringAsFixed(0)} mi (${mileagePct >= 0 ? '+' : ''}${mileagePct.toStringAsFixed(1)}%)',
                              color: theme.colorScheme.tertiary,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, _) =>
                const SizedBox(width: AppDimens.spaceLarge),
            itemCount: cars.length,
          ),
        ),
      ],
    );
  }

  void _openImproveSearchSheet(BuildContext context) {
    final controller = TextEditingController();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: AppDimens.paddingXLarge,
              right: AppDimens.paddingXLarge,
              top: AppDimens.paddingXLarge,
              bottom:
                  MediaQuery.of(sheetContext).viewInsets.bottom +
                  AppDimens.paddingXLarge,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.tips_and_updates,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: AppDimens.spaceMedium),
                      const Text(
                        AppTexts.tipsAndUpdates,
                        style: TextStyle(
                          fontSize: AppDimens.fontSizeXLarge,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimens.spaceLarge),
                  TextField(
                    controller: controller,
                    maxLines: 4,
                    textInputAction: TextInputAction.newline,
                    decoration: const InputDecoration(
                      hintText: AppTexts.improveResultsHint,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: AppDimens.radiusLarge),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        final input = controller.text.trim();
                        Navigator.of(sheetContext).pop();

                        if (input.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(AppTexts.pleaseDescribe),
                            ),
                          );
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppTexts.thanksForFeedback(input)),
                          ),
                        );
                      },
                      icon: const Icon(Icons.send_rounded),
                      label: const Text(AppTexts.submitButton),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.value, required this.color});

  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = color.withValues(alpha: 0.14);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.space10,
        vertical: AppDimens.spaceMedium,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: AppDimens.opacityLight),
            blurRadius: AppDimens.blurRadiusSmall,
            offset: const Offset(0, AppDimens.shadowOffsetSmall),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: AppDimens.fontSizeXSmall,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

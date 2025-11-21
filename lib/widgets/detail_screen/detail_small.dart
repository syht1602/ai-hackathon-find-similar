import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_dimens.dart';
import '../../constants/app_texts.dart';
import '../../models/car.dart';

enum DiffColor { good, bad, neutral }

class DetailSmall extends StatelessWidget {
  const DetailSmall({
    super.key,
    required this.car,
    this.compareTo,
    this.higherIsBetter,
    this.isSelected = false,
    this.onTap,
  });

  final Car car;
  final Car? compareTo;
  final Map<String, bool>? higherIsBetter;
  final bool isSelected;
  final VoidCallback? onTap;

  static const _ignoreCompareKeys = {
    'owner',
    'owners',
    'dealer',
    'registration',
    'notes',
    'accidents',
  };

  DiffColor _evaluate(num base, num other, bool higherBetter) {
    if (base == other) return DiffColor.neutral;
    if (higherBetter) return other > base ? DiffColor.good : DiffColor.bad;
    return other < base ? DiffColor.good : DiffColor.bad;
  }

  Color _colorFor(DiffColor d) {
    switch (d) {
      case DiffColor.good:
        return AppColors.diffGood;
      case DiffColor.bad:
        return AppColors.diffBad;
      case DiffColor.neutral:
        return AppColors.diffNeutral;
    }
  }

  bool _shouldCompareKey(String key) {
    final lk = key.toLowerCase();
    for (final ig in _ignoreCompareKeys) {
      if (lk.contains(ig)) return false;
    }
    return true;
  }

  Widget _buildRow(String label, dynamic value, {Widget? trailing}) {
    final capitalizedLabel = label.isEmpty
        ? label
        : label[0].toUpperCase() + label.substring(1);
    return Row(
      children: [
        Expanded(
          child: Text(
            capitalizedLabel,
            style: const TextStyle(fontSize: AppDimens.fontSizeSmall),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: AppDimens.spaceXSmall),
        Expanded(
          flex: 2,
          child: value is Widget
              ? value
              : Text(
                  value.toString(),
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: AppDimens.fontSizeSmall,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: AppDimens.spaceXSmall),
          trailing,
        ],
      ],
    );
  }

  Widget _buildComparisonArrow(num current, num other, bool higherBetter) {
    final diff = current - other;
    final diffColor = _evaluate(other, current, higherBetter);

    if (diffColor == DiffColor.neutral) return const SizedBox.shrink();

    final color = _colorFor(diffColor);
    final icon = diff >= 0 ? Icons.arrow_upward : Icons.arrow_downward;

    return Icon(icon, size: AppDimens.fontSizeIcon, color: color);
  }

  Widget _buildColoredValue(
    String baseValue,
    num current,
    num other,
    bool higherBetter,
  ) {
    final diff = current - other;
    final pct = other == 0 ? 0 : (diff / other) * 100;
    final sign = pct >= 0 ? '+' : '';
    final color = _colorFor(_evaluate(other, current, higherBetter));
    final displayValue = baseValue;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '($sign${pct.toStringAsFixed(1)}%) ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: AppDimens.fontSizeTiny,
              color: color,
            ),
          ),
          TextSpan(
            text: displayValue,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: AppDimens.fontSizeSmall,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.right,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final primaryTextColor = isDark ? Colors.white : Colors.black87;
    final containerColor = isDark
        ? cs.surfaceContainerHighest.withValues(alpha: AppDimens.opacityLight)
        : cs.surfaceContainerHigh.withValues(alpha: AppDimens.opacityVeryHigh);
    final highlight = compareTo != null || isSelected;
    final textColor = highlight ? cs.onPrimaryContainer : primaryTextColor;
    final decoration = BoxDecoration(
      color: highlight ? null : containerColor,
      gradient: highlight
          ? LinearGradient(
              colors: [
                cs.primary.withValues(alpha: AppDimens.opacityMedium),
                cs.primaryContainer.withValues(
                  alpha: AppDimens.opacityVeryLight,
                ),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          : null,
      borderRadius: BorderRadius.circular(AppDimens.spaceSmall),
    );

    final price = car.price;
    final market = car.marketShare;

    final Map<String, bool> hib = {
      'price': false,
      'marketShare': true,
      ...?higherIsBetter,
    };

    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: AppDimens.detailSmallMaxHeight,
        ),
        child: Container(
          padding: const EdgeInsets.all(AppDimens.space10),
          decoration: decoration,
          child: DefaultTextStyle.merge(
            style: TextStyle(color: textColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name at top - full width
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

                // Picture with badge overlay
                SizedBox(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppDimens.spaceSmall,
                        ),
                        child: car.photos.isNotEmpty
                            ? Image.network(
                                car.photos[0],
                                width: double.infinity,
                                height: AppDimens.imageHeightMedium,
                                fit: BoxFit.fitWidth,
                              )
                            : Container(
                                width: double.infinity,
                                height: AppDimens.imageHeightMedium,
                                color: cs.surface,
                                child: const Icon(
                                  Icons.directions_car,
                                  size: AppDimens.iconXXLarge,
                                ),
                              ),
                      ),
                      if (car.badge.isNotEmpty)
                        Positioned(
                          top: AppDimens.spaceXSmall,
                          left: AppDimens.spaceXSmall,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimens.spaceXSmall,
                              vertical: AppDimens.badgeVerticalPadding,
                            ),
                            decoration: BoxDecoration(
                              color: highlight
                                  ? Colors.white
                                  : cs.primary.withValues(
                                      alpha: AppDimens.opacityNearFull,
                                    ),
                              borderRadius: BorderRadius.circular(
                                AppDimens.spaceXSmall,
                              ),
                            ),
                            child: Text(
                              car.badge,
                              style: TextStyle(
                                fontSize: AppDimens.badgeFontSize,
                                fontWeight: FontWeight.w700,
                                color: highlight ? cs.primary : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      if (compareTo != null)
                        Positioned(
                          top: car.badge.isNotEmpty
                              ? AppDimens.badgeTopPosition
                              : AppDimens.spaceXSmall,
                          left: AppDimens.spaceXSmall,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimens.spaceXSmall,
                              vertical: AppDimens.badgeVerticalPadding,
                            ),
                            decoration: BoxDecoration(
                              color: highlight
                                  ? Colors.white.withValues(
                                      alpha: AppDimens.opacityNearFull,
                                    )
                                  : Colors.black.withValues(
                                      alpha: AppDimens.opacityExtraHigh,
                                    ),
                              borderRadius: BorderRadius.circular(
                                AppDimens.spaceXSmall,
                              ),
                            ),
                            child: Text(
                              isSelected
                                  ? AppTexts.selected
                                  : AppTexts.comparing,
                              style: TextStyle(
                                fontSize: AppDimens.badgeFontSize,
                                fontWeight: FontWeight.w600,
                                color: highlight ? cs.primary : Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimens.spaceXSmall),

                // Important values only
                _buildRow(
                  AppTexts.priceLabel,
                  compareTo == null
                      ? '\$${price.toString()}'
                      : _buildColoredValue(
                          '\$${price.toString()}',
                          price,
                          compareTo!.price,
                          hib['price'] ?? false,
                        ),
                  trailing: compareTo != null
                      ? _buildComparisonArrow(
                          price,
                          compareTo!.price,
                          hib['price'] ?? false,
                        )
                      : null,
                ),
                const SizedBox(height: AppDimens.spaceXSmall),

                if (car.details.containsKey('mileage'))
                  _buildRow(
                    AppTexts.mileageLabel,
                    compareTo == null
                        ? car.details['mileage'].toString()
                        : () {
                            final current = car.details['mileage'] as num;
                            final other = compareTo!.details['mileage'];
                            if (other is num) {
                              return _buildColoredValue(
                                current.toString(),
                                current,
                                other,
                                false,
                              );
                            }
                            return current.toString();
                          }(),
                    trailing:
                        compareTo != null &&
                            compareTo!.details.containsKey('mileage') &&
                            compareTo!.details['mileage'] is num
                        ? _buildComparisonArrow(
                            car.details['mileage'] as num,
                            compareTo!.details['mileage'] as num,
                            false,
                          )
                        : null,
                  ),
                const SizedBox(height: AppDimens.spaceXSmall),

                _buildRow(
                  AppTexts.marketLabel,
                  compareTo == null
                      ? '${market.toString()}%'
                      : _buildColoredValue(
                          '${market.toString()}%',
                          market,
                          compareTo!.marketShare,
                          hib['marketShare'] ?? true,
                        ),
                  trailing: compareTo != null
                      ? _buildComparisonArrow(
                          market,
                          compareTo!.marketShare,
                          hib['marketShare'] ?? true,
                        )
                      : null,
                ),
                const SizedBox(height: AppDimens.spaceSmall),
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimens.spaceXSmall),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: highlight
                            ? Colors.white.withValues(
                                alpha: AppDimens.opacityVeryLight,
                              )
                            : cs.surfaceContainerHigh.withValues(
                                alpha: AppDimens.opacityMediumHigh * 2,
                              ),
                      ),
                      child: ListView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.spaceMedium,
                          vertical: AppDimens.spaceSmall,
                        ),
                        children: [
                          for (final tagEntry in car.tags.asMap().entries)
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppDimens.spaceXSmall,
                              ),
                              child: _buildRow(
                                '${AppTexts.tag} ${tagEntry.key + 1}',
                                tagEntry.value,
                              ),
                            ),
                          for (final e in car.details.entries)
                            if (e.key.toLowerCase() != 'mileage' &&
                                e.key.toLowerCase() != 'notes')
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppDimens.spaceXSmall,
                                ),
                                child: _buildRow(
                                  e.key,
                                  e.value.toString(),
                                  trailing:
                                      (e.value is num &&
                                          _shouldCompareKey(e.key) &&
                                          compareTo != null &&
                                          compareTo!.details.containsKey(
                                            e.key,
                                          ) &&
                                          (compareTo!.details[e.key] is num))
                                      ? _buildComparisonArrow(
                                          (e.value as num),
                                          (compareTo!.details[e.key] as num),
                                          hib[e.key] ?? true,
                                        )
                                      : null,
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../constants/app_dimens.dart';
import '../../constants/app_texts.dart';

class ComparisonResultBanner extends StatelessWidget {
  const ComparisonResultBanner({
    super.key,
    required this.hasComparison,
    required this.headline,
    required this.helper,
    this.onTap,
    this.margin,
  });

  final bool hasComparison;
  final String headline;
  final String helper;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin:
            margin ??
            const EdgeInsets.fromLTRB(
              AppDimens.paddingLarge,
              AppDimens.paddingMedium,
              AppDimens.paddingLarge,
              AppDimens.spaceXSmall,
            ),
        padding: const EdgeInsets.all(AppDimens.paddingLarge),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [scheme.primary, scheme.primaryContainer],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppDimens.space18),
          boxShadow: [
            BoxShadow(
              color: scheme.primary.withValues(alpha: 0.25),
              blurRadius: AppDimens.space24,
              offset: const Offset(0, AppDimens.paddingMedium),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimens.space10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
              ),
              child: const Icon(
                Icons.trending_up,
                color: Colors.white,
                size: AppDimens.iconXLarge,
              ),
            ),
            const SizedBox(width: AppDimens.paddingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    AppTexts.analysisResult,
                    style: TextStyle(
                      fontSize: AppDimens.fontSizeLarge,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: AppDimens.spaceSmall),
                  Text(
                    headline,
                    style: const TextStyle(
                      fontSize: AppDimens.fontSizeNormal,
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppDimens.spaceMedium),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          helper,
                          style: TextStyle(
                            fontSize: AppDimens.fontSizeSmall,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasComparison) ...[
                        const SizedBox(width: AppDimens.spaceMedium),
                        Icon(
                          Icons.open_in_full_rounded,
                          color: Colors.white.withValues(alpha: 0.85),
                          size: AppDimens.iconSmall,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

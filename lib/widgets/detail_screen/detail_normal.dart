import 'package:flutter/material.dart';

import '../../constants/app_dimens.dart';
import '../../constants/app_texts.dart';
import '../../models/car.dart';

class DetailNormal extends StatelessWidget {
  const DetailNormal({super.key, required this.car});

  final Car car;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingLarge,
        vertical: AppDimens.paddingMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppDimens.imageHeightLarge,
            child: PageView.builder(
              itemCount: car.photos.length,
              itemBuilder: (context, index) {
                final url = car.photos[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: cs.surface,
                      child: const Center(
                        child: Icon(Icons.directions_car, size: 48),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: AppDimens.paddingMedium),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  car.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (car.badge.isNotEmpty) Chip(label: Text(car.badge)),
            ],
          ),

          const SizedBox(height: AppDimens.spaceMedium),
          Text(
            '\$${car.price}',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppDimens.spaceSmall),
          Text(
            '${AppTexts.marketSharePrefix}${car.marketShare}%',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: cs.primary),
          ),

          const SizedBox(height: AppDimens.paddingMedium),
          // tags horizontal scroll
          SizedBox(
            height: AppDimens.chipHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: car.tags.length,
              separatorBuilder: (context, _) =>
                  const SizedBox(width: AppDimens.spaceMedium),
              itemBuilder: (context, index) =>
                  Chip(label: Text(car.tags[index])),
            ),
          ),

          const SizedBox(height: AppDimens.paddingMedium),
          // details map
          ...car.details.entries.map((e) {
            final capitalizedLabel = e.key.isEmpty
                ? e.key
                : e.key[0].toUpperCase() + e.key.substring(1);
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimens.spaceSmall,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    capitalizedLabel,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Flexible(
                    child: Text(
                      e.value.toString(),
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: AppDimens.paddingMedium),
          Text(
            AppTexts.summary,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppDimens.spaceSmall),
          Text(
            AppTexts.summaryText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

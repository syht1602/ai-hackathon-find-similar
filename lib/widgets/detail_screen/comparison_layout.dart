import 'package:flutter/material.dart';

import '../../constants/app_dimens.dart';
import '../../models/car.dart';
import 'detail_small.dart';

class ComparisonLayout extends StatelessWidget {
  const ComparisonLayout({
    super.key,
    required this.selectedCar,
    this.comparisonCar,
    required this.onSelectedTap,
    this.onComparisonTap,
  });

  final Car selectedCar;
  final Car? comparisonCar;
  final VoidCallback onSelectedTap;
  final VoidCallback? onComparisonTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildComparisonCard(
            context,
            DetailSmall(
              car: selectedCar,
              isSelected: true,
              onTap: onSelectedTap,
            ),
          ),
        ),
        const SizedBox(width: AppDimens.paddingMedium),
        Expanded(
          child: comparisonCar == null
              ? _buildEmptyCard(context)
              : _buildComparisonCard(
                  context,
                  DetailSmall(
                    car: comparisonCar!,
                    compareTo: selectedCar,
                    onTap: onComparisonTap,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildComparisonCard(BuildContext context, Widget child) {
    return Container(
      constraints: const BoxConstraints(maxHeight: AppDimens.maxCardHeight),
      child: child,
    );
  }

  Widget _buildEmptyCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.space24),
      child: const Center(
        child: Text(
          'Select a car',
          style: TextStyle(
            fontSize: AppDimens.fontSizeSmall,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

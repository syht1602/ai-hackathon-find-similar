import 'package:flutter/material.dart';

import '../constants/app_texts.dart';
import '../constants/app_dimens.dart';
import '../models/car.dart';
import '../widgets/detail_screen/detail_normal.dart';
import '../widgets/detail_screen/similar_car_carousel.dart';
import '../widgets/detail_screen/comparison_layout.dart';
import '../widgets/detail_screen/comparison_result_banner.dart';
import '../widgets/detail_screen/comparison_modal.dart';

/// Detail screen showing car information with comparison capabilities
class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.car, required this.allCars});

  final Car car;
  final List<Car> allCars;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  bool _findSimilar = false;
  late Car _selected;
  Car? _comparison;
  late List<Car> _similar;

  @override
  void initState() {
    super.initState();
    _selected = widget.car;
    _similar = _computeSimilar(widget.allCars, _selected);
    if (_similar.isNotEmpty) _comparison = _similar.first;
  }

  List<Car> _computeSimilar(List<Car> all, Car base) {
    final others = all.where((c) => c.id != base.id).toList();
    others.sort(
      (a, b) =>
          (a.price - base.price).abs().compareTo((b.price - base.price).abs()),
    );
    return others;
  }

  void _toggleFindSimilar() {
    setState(() {
      _findSimilar = !_findSimilar;
      if (_findSimilar && _similar.isNotEmpty && _comparison == null) {
        _comparison = _similar.first;
      }
    });
  }

  void _focusOnCar(Car car) {
    setState(() {
      _selected = car;
      _similar = _computeSimilar(widget.allCars, _selected);
      _comparison = _similar.isNotEmpty ? _similar.first : null;
      _findSimilar = false;
    });
  }

  String _getComparisonResult() {
    if (_comparison == null) return '';
    final priceDiff = _selected.price - _comparison!.price;
    final marketDiff = _selected.marketShare - _comparison!.marketShare;

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

  void _showAnalysisDetails(BuildContext context) {
    if (_comparison == null) return;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) =>
          ComparisonModal(selectedCar: _selected, comparisonCar: _comparison!),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.carDetail),
        actions: [
          TextButton.icon(
            onPressed: _toggleFindSimilar,
            icon: Icon(_findSimilar ? Icons.close : Icons.search),
            label: Text(_findSimilar ? AppTexts.close : AppTexts.findSimilar),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [scheme.surfaceContainerHighest, scheme.surface],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: AppDimens.animationMedium),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: -1,
                child: child,
              ),
            ),
            child: _findSimilar
                ? _buildComparisonView(context)
                : KeyedSubtree(
                    key: ValueKey(_selected.id),
                    child: DetailNormal(car: _selected),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildComparisonView(BuildContext context) {
    final hasComparison = _comparison != null;
    final headline = hasComparison
        ? _getComparisonResult()
        : AppTexts.selectToCompare;
    final helper = hasComparison
        ? AppTexts.tapAnotherCard
        : AppTexts.tapAnyCard;

    return KeyedSubtree(
      key: const ValueKey('comparison'),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(AppDimens.paddingLarge),
              physics: const BouncingScrollPhysics(),
              children: [
                ComparisonLayout(
                  selectedCar: _selected,
                  comparisonCar: _comparison,
                  onSelectedTap: () => _focusOnCar(_selected),
                  onComparisonTap: _comparison != null
                      ? () => _focusOnCar(_comparison!)
                      : null,
                ),
                const SizedBox(height: AppDimens.paddingLarge),
                ComparisonResultBanner(
                  hasComparison: hasComparison,
                  headline: headline,
                  helper: helper,
                  onTap: hasComparison
                      ? () => _showAnalysisDetails(context)
                      : null,
                  margin: EdgeInsets.zero,
                ),
                const SizedBox(height: AppDimens.paddingLarge),
                SimilarCarsCarousel(
                  cars: _similar,
                  selected: _selected,
                  currentComparison: _comparison,
                  onSelect: (car) => setState(() => _comparison = car),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

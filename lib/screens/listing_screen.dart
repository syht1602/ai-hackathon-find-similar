import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../constants/app_dimens.dart';
import '../constants/app_texts.dart';
import '../models/car.dart';
import '../widgets/listing/car_card.dart';
import 'detail_screen.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  late Future<List<Car>> _carsFuture;

  @override
  void initState() {
    super.initState();
    _carsFuture = _loadCars();
  }

  Future<List<Car>> _loadCars() async {
    final jsonStr = await rootBundle.loadString('assets/data/cars.json');
    return Car.listFromJson(jsonStr);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingLarge,
        vertical: AppDimens.paddingMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppDimens.spaceMedium),
          Expanded(
            child: FutureBuilder<List<Car>>(
              future: _carsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('${AppTexts.errorLoading}${snapshot.error}'),
                  );
                }
                final cars = snapshot.data ?? [];
                if (cars.isEmpty) {
                  return const Center(child: Text(AppTexts.noListings));
                }

                return ListView.builder(
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    final car = cars[index];
                    return CarCard(
                      title: car.title,
                      price: '\$${car.price}',
                      marketShare: '${car.marketShare}%',
                      imageUrl: car.photos.isNotEmpty ? car.photos[0] : '',
                      tags: car.tags,
                      badgeLabel: car.badge,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                DetailScreen(car: car, allCars: cars),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

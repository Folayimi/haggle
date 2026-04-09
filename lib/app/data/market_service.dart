import 'mock_seller_profiles.dart';

class MarketService {
  const MarketService({
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.seller,
  });

  final String name;
  final String category;
  final String description;
  final String price;
  final SellerProfileData seller;
}

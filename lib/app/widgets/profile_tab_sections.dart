import 'package:flutter/material.dart';

import 'profile_widgets.dart';
import 'section_header.dart';

class NegotiationTabContent extends StatelessWidget {
  const NegotiationTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Haggle KPIs'),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: HighlightCard(label: 'Session Duration', value: '3m 42s')),
              SizedBox(width: 12),
              Expanded(child: HighlightCard(label: 'Offer Accept Rate', value: '24%')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: HighlightCard(label: 'Voice Connect', value: '67%')),
              SizedBox(width: 12),
              Expanded(child: HighlightCard(label: 'Day 7 Retention', value: '34%')),
            ],
          ),
          const SizedBox(height: 18),
          const SectionHeader(title: 'Upcoming Live Negotiations'),
          const SizedBox(height: 12),
          const UpcomingCard(
            title: 'Weekend Market: Vintage Lamp',
            time: 'Sat | 7:30 PM',
            status: 'Scheduled',
          ),
          const SizedBox(height: 12),
          const UpcomingCard(
            title: 'Boutique Drop: Leather Bag',
            time: 'Sun | 6:00 PM',
            status: 'Notify me',
          ),
          const SizedBox(height: 18),
          const SectionHeader(title: 'Recent Rooms'),
          const SizedBox(height: 12),
          const MiniMediaGrid(),
        ],
      ),
    );
  }
}

class CollectionsTabContent extends StatelessWidget {
  const CollectionsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SectionHeader(title: 'Collections'),
        SizedBox(height: 12),
        CollectionCard(
          title: 'Warm Lighting',
          items: '14 items | 6 vendors',
        ),
        SizedBox(height: 12),
        CollectionCard(
          title: 'Studio Essentials',
          items: '9 items | 4 vendors',
        ),
        SizedBox(height: 12),
        CollectionCard(
          title: 'Weekend Market Picks',
          items: '12 items | 5 vendors',
        ),
      ],
    );
  }
}

class SavedTabContent extends StatelessWidget {
  const SavedTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SectionHeader(title: 'Saved Deals'),
        SizedBox(height: 12),
        SavedDealCard(
          title: 'Ceramic Brew Kit',
          vendor: 'Budiarti',
          status: 'Offer in progress',
        ),
        SizedBox(height: 12),
        SavedDealCard(
          title: 'Gallery Wall Set',
          vendor: 'Lola Studios',
          status: 'Waiting for vendor',
        ),
        SizedBox(height: 12),
        SavedDealCard(
          title: 'Vintage Camera Bundle',
          vendor: 'Fola Studios',
          status: 'Ready to haggle',
        ),
      ],
    );
  }
}

class MiniMediaGrid extends StatelessWidget {
  const MiniMediaGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: const [
        MiniMediaCard(
          title: 'Candlelight Bundle',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/71/Coffee_%28Unsplash%29.jpg',
        ),
        MiniMediaCard(
          title: 'Garden Glow',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Orange_flowers_in_macro_%28Unsplash%29.jpg/640px-Orange_flowers_in_macro_%28Unsplash%29.jpg',
        ),
        MiniMediaCard(
          title: 'Calm Workspace',
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Cozy_interior_with_a_sofa_%28Unsplash%29.jpg/960px-Cozy_interior_with_a_sofa_%28Unsplash%29.jpg',
        ),
        MiniMediaCard(
          title: 'Warm Studio',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/76/Campfire_%2815621989189%29.jpg',
        ),
      ],
    );
  }
}

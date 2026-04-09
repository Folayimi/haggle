class SellerProduct {
  const SellerProduct({
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  final String name;
  final String category;
  final String price;
  final String imageUrl;
  final String description;
}

class SellerLiveSession {
  const SellerLiveSession({
    required this.title,
    required this.schedule,
    required this.status,
    required this.preview,
    required this.buyerBenefits,
  });

  final String title;
  final String schedule;
  final String status;
  final String preview;
  final List<String> buyerBenefits;
}

class SellerProfileData {
  const SellerProfileData({
    required this.name,
    required this.username,
    required this.businessName,
    required this.tradeMark,
    required this.avatarUrl,
    required this.coverImageUrl,
    required this.bio,
    required this.sellsSummary,
    required this.followers,
    required this.rating,
    required this.responseTime,
    required this.products,
    required this.ongoingLives,
    required this.upcomingLives,
  });

  final String name;
  final String username;
  final String businessName;
  final String tradeMark;
  final String avatarUrl;
  final String coverImageUrl;
  final String bio;
  final String sellsSummary;
  final String followers;
  final String rating;
  final String responseTime;
  final List<SellerProduct> products;
  final List<SellerLiveSession> ongoingLives;
  final List<SellerLiveSession> upcomingLives;
}

const sellerProfiles = <SellerProfileData>[
  SellerProfileData(
    name: 'Nathan Rusl',
    username: '@nathanrusl',
    businessName: 'Rusl Home Studio',
    tradeMark: 'RUSL Glow',
    avatarUrl:
        'https://upload.wikimedia.org/wikipedia/commons/7/74/Portrait_%28Unsplash%29.jpg',
    coverImageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Cozy_interior_with_a_sofa_%28Unsplash%29.jpg/960px-Cozy_interior_with_a_sofa_%28Unsplash%29.jpg',
    bio:
        'Nathan curates warm lighting, cozy decor, and small-batch statement pieces for apartments, studios, and boutique homes.',
    sellsSummary: 'Ambient lamps, artisan decor, and compact home styling bundles.',
    followers: '12.4k',
    rating: '4.9',
    responseTime: '8 min',
    products: [
      SellerProduct(
        name: 'Botanica Rose Lamp',
        category: 'Ambient Lighting',
        price: '\$84',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Orange_flowers_in_macro_%28Unsplash%29.jpg/960px-Orange_flowers_in_macro_%28Unsplash%29.jpg',
        description: 'Soft floral lamp for bedside styling and warm evening rooms.',
      ),
      SellerProduct(
        name: 'Calm Corner Set',
        category: 'Home Bundle',
        price: '\$126',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Cozy_interior_with_a_sofa_%28Unsplash%29.jpg/1280px-Cozy_interior_with_a_sofa_%28Unsplash%29.jpg',
        description: 'Layered lighting and decor pieces built for reading corners.',
      ),
      SellerProduct(
        name: 'Studio Glow Candle Pair',
        category: 'Decor Accent',
        price: '\$28',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/7/71/Coffee_%28Unsplash%29.jpg',
        description: 'Scented candle duo designed to complement warm lamp tones.',
      ),
    ],
    ongoingLives: [
      SellerLiveSession(
        title: 'Botanica Rose Lamp Live Bargain',
        schedule: 'Live now',
        status: 'Ongoing',
        preview: 'Close-up demo of brightness modes, table styling, and bundle options.',
        buyerBenefits: [
          'Real-time discount matching during the live session.',
          'Free styling tips based on your room size and color tone.',
          'Priority queue for fast offer approval before stock runs out.',
        ],
      ),
    ],
    upcomingLives: [
      SellerLiveSession(
        title: 'Weekend Lamp Bundle Showcase',
        schedule: 'Sat | 7:30 PM',
        status: 'Scheduled',
        preview: 'Nathan will display layered lamp bundles, side-table pairings, and limited home styling packs.',
        buyerBenefits: [
          'Bundle-only negotiation prices not available after the live.',
          'Early access to pieces before they appear in search.',
          'Free delivery upgrade for the first accepted bundle offers.',
        ],
      ),
      SellerLiveSession(
        title: 'Small Space Warmth Setup',
        schedule: 'Tue | 6:00 PM',
        status: 'Upcoming',
        preview: 'A guided setup for compact apartments using lamps, candles, and accent decor.',
        buyerBenefits: [
          'Recommendations tailored to small apartments and studio rooms.',
          'Combo pricing when you negotiate two or more products.',
          'Buyers can request personalized room mood suggestions in chat.',
        ],
      ),
    ],
  ),
  SellerProfileData(
    name: 'Robbinson',
    username: '@robbinsonhq',
    businessName: 'Robbinson Audio Camp',
    tradeMark: 'CampTone',
    avatarUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Portrait_of_a_woman_%28Unsplash%29.jpg/640px-Portrait_of_a_woman_%28Unsplash%29.jpg',
    coverImageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/7/76/Campfire_%2815621989189%29.jpg',
    bio:
        'Robbinson sells outdoor-friendly speakers, travel audio gear, and warm lifestyle accessories built for shared hangouts.',
    sellsSummary: 'Portable speakers, audio bundles, and travel-ready entertainment gear.',
    followers: '9.8k',
    rating: '4.8',
    responseTime: '11 min',
    products: [
      SellerProduct(
        name: 'Campfire Speaker Set',
        category: 'Portable Audio',
        price: '\$138',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/7/76/Campfire_%2815621989189%29.jpg',
        description: 'Dual-speaker set with warm tone tuning for outdoor gatherings.',
      ),
      SellerProduct(
        name: 'Night Trail Mini Speaker',
        category: 'Travel Audio',
        price: '\$59',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Cozy_interior_with_a_sofa_%28Unsplash%29.jpg/960px-Cozy_interior_with_a_sofa_%28Unsplash%29.jpg',
        description: 'Compact speaker with long battery life for mobile sessions.',
      ),
      SellerProduct(
        name: 'Audio Carry Pouch',
        category: 'Accessory',
        price: '\$24',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Orange_flowers_in_macro_%28Unsplash%29.jpg/640px-Orange_flowers_in_macro_%28Unsplash%29.jpg',
        description: 'Protective carry pouch for portable speaker accessories.',
      ),
    ],
    ongoingLives: [
      SellerLiveSession(
        title: 'Campfire Speaker Sound Test',
        schedule: 'Live now',
        status: 'Ongoing',
        preview: 'Live comparison of volume range, bass response, and outdoor playback.',
        buyerBenefits: [
          'Instant accessory add-ons at reduced live prices.',
          'Ask for real-time sound demos before you negotiate.',
          'Faster checkout lane for accepted offers during the stream.',
        ],
      ),
    ],
    upcomingLives: [
      SellerLiveSession(
        title: 'Sunset Hangout Audio Drop',
        schedule: 'Sun | 6:00 PM',
        status: 'Scheduled',
        preview: 'Robbinson will display speaker pairings, accessory bundles, and battery performance.',
        buyerBenefits: [
          'Special live bundle pricing for first-time buyers.',
          'Exclusive add-on pouch for accepted combo offers.',
          'Direct answers on portability, sound range, and outdoor setup.',
        ],
      ),
    ],
  ),
  SellerProfileData(
    name: 'Budiarti',
    username: '@budiarti.craft',
    businessName: 'Budiarti Brew House',
    tradeMark: 'SlowPour',
    avatarUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Portrait_of_a_man_%28Unsplash%29.jpg/640px-Portrait_of_a_man_%28Unsplash%29.jpg',
    coverImageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/7/71/Coffee_%28Unsplash%29.jpg',
    bio:
        'Budiarti offers handmade ceramic brewing tools and table pieces for buyers who enjoy calm rituals and artisan craftsmanship.',
    sellsSummary: 'Ceramic brew kits, handmade mugs, and slow-living tabletop pieces.',
    followers: '8.1k',
    rating: '4.9',
    responseTime: '6 min',
    products: [
      SellerProduct(
        name: 'Ceramic Brew Kit',
        category: 'Coffee Set',
        price: '\$96',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/7/71/Coffee_%28Unsplash%29.jpg',
        description: 'Handmade brew set with dripper, server, and cups.',
      ),
      SellerProduct(
        name: 'Morning Ritual Mug',
        category: 'Ceramic Mug',
        price: '\$22',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Orange_flowers_in_macro_%28Unsplash%29.jpg/640px-Orange_flowers_in_macro_%28Unsplash%29.jpg',
        description: 'Stone-textured mug with a balanced grip and soft finish.',
      ),
      SellerProduct(
        name: 'Pour Table Tray',
        category: 'Serving Piece',
        price: '\$31',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Cozy_interior_with_a_sofa_%28Unsplash%29.jpg/960px-Cozy_interior_with_a_sofa_%28Unsplash%29.jpg',
        description: 'Minimal tray built for serving brews and displaying ceramics.',
      ),
    ],
    ongoingLives: [
      SellerLiveSession(
        title: 'Ceramic Brew Kit Negotiation',
        schedule: 'Live now',
        status: 'Ongoing',
        preview: 'Budiarti shows texture, pour control, and small-batch craftsmanship details.',
        buyerBenefits: [
          'Live viewers can request custom bundle combinations.',
          'Discounted shipping for multi-item ceramic orders.',
          'Direct handling tips so buyers protect the pieces after purchase.',
        ],
      ),
    ],
    upcomingLives: [
      SellerLiveSession(
        title: 'Slow Pour Sunday',
        schedule: 'Sun | 8:30 AM',
        status: 'Scheduled',
        preview: 'A quiet morning session showing brew kits, mugs, and table tray combinations.',
        buyerBenefits: [
          'Exclusive ritual bundle discounts for morning viewers.',
          'Priority access to newly glazed ceramic pieces.',
          'Chance to reserve limited handmade stock before public release.',
        ],
      ),
    ],
  ),
];

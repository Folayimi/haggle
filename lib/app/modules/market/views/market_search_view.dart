import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';

class MarketSearchView extends StatefulWidget {
  const MarketSearchView({super.key});

  @override
  State<MarketSearchView> createState() => _MarketSearchViewState();
}

class _MarketSearchViewState extends State<MarketSearchView> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late List<String> _recentSearches;

  static const _suggestions = [
    'Electronics',
    'Phones',
    'Laptops',
    'Speakers',
    'Home decor',
    'Kitchenware',
    'Ceramic set',
    'Lighting',
    'Furniture',
    'Audio gear',
    'Live session',
    'Negotiation',
    'Carpentry',
    'Tailoring',
    'Architecture',
    'Engineering',
    'Plumbing',
    'Cleaning',
    'Photography',
    'Graphic design',
    'Gardening',
  ];

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<dynamic, dynamic>?;
    _recentSearches = List<String>.from(args?['recents'] as List<dynamic>? ?? []);
    final initialQuery = args?['query'] as String?;
    if (initialQuery != null && initialQuery.isNotEmpty) {
      _controller.text = initialQuery;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitSearch(String value) {
    final query = value.trim();
    if (query.isEmpty) return;
    _recentSearches.removeWhere((item) => item.toLowerCase() == query.toLowerCase());
    _recentSearches.insert(0, query);
    if (_recentSearches.length > 8) {
      _recentSearches = _recentSearches.sublist(0, 8);
    }
    Get.back(result: {
      'query': query,
      'recents': _recentSearches,
    });
  }

  List<String> _filteredSuggestions(String query) {
    if (query.isEmpty) return _suggestions;
    final lower = query.toLowerCase();
    return _suggestions.where((item) => item.toLowerCase().contains(lower)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final suggestions = _filteredSuggestions(_controller.text);
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        title: const Text('Search market'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              textInputAction: TextInputAction.search,
              onSubmitted: _submitSearch,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search products, services, or sellers',
                prefixIcon: const Icon(Icons.search, color: AppColors.dark),
                suffixIcon: _controller.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close, color: AppColors.dark),
                        onPressed: () => setState(() => _controller.clear()),
                      ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: AppColors.neutral),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 18),
            if (_recentSearches.isNotEmpty) ...[
              Row(
                children: [
                  Text(
                    'Recent searches',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => setState(() => _recentSearches.clear()),
                    child: const Text('Clear'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _recentSearches
                    .map(
                      (item) => ActionChip(
                        label: Text(item),
                        onPressed: () => _submitSearch(item),
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: AppColors.neutral),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 18),
            ],
            Text(
              'Suggestions',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: suggestions.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final suggestion = suggestions[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(suggestion),
                    trailing: const Icon(Icons.call_made_rounded, size: 18),
                    onTap: () => _submitSearch(suggestion),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

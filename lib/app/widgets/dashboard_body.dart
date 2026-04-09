import 'package:flutter/material.dart';

import '../modules/dashboard/views/tabs/create_tab.dart';
import '../modules/dashboard/views/tabs/live_feed_tab.dart';
import '../modules/dashboard/views/tabs/message_tab.dart';
import '../modules/dashboard/views/tabs/profile_tab.dart';
import '../modules/dashboard/views/tabs/market_tab.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    void openDrawer() => Scaffold.of(context).openDrawer();

    final pages = [
      LiveFeedTab(onMenuTap: openDrawer),
      MarketTab(onMenuTap: openDrawer),
      CreateTab(onMenuTap: openDrawer),
      MessageTab(onMenuTap: openDrawer),
      ProfileTab(onMenuTap: openDrawer),
    ];

    final padding = index == 0
        ? EdgeInsets.zero
        : index == 1
            ? const EdgeInsets.fromLTRB(0, 0, 0, 32)
            : const EdgeInsets.fromLTRB(16, 16, 16, 32);
    return SafeArea(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        child: index == 0 || index == 1 || index == 4
            ? KeyedSubtree(
                key: ValueKey(index),
                child: pages[index],
              )
            : SingleChildScrollView(
                key: ValueKey(index),
                padding: padding,
                child: pages[index],
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import 'tabs/analytics_tab.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.dark,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: AnalyticsTab(onMenuTap: _noop),
        ),
      ),
    );
  }
}

void _noop() {}

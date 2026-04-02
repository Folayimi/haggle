import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controllers/theme_controller.dart';
import '../../../widgets/dashboard_body.dart';
import '../../../widgets/dashboard_bottom_nav.dart';
import '../../../widgets/dashboard_drawer.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      drawer: DashboardDrawer(themeController: themeController),
      body: Obx(() => DashboardBody(index: controller.selectedIndex.value)),
      bottomNavigationBar: Obx(
        () => DashboardBottomNav(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.setTab,
        ),
      ),
    );
  }
}

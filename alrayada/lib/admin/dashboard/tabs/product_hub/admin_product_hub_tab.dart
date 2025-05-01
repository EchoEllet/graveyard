import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/localizations/app_localization_extension.dart';
import '../../../../common/presentation/widgets/platform_adaptive_icon.dart';
import 'categories/admin_categories_tab.dart';
import 'products/admin_products_tab.dart';

/// A screen that has both [AdminProductsTab] and [AdminCategoriesTab]
/// using [TabBarView]
class AdminProductHubTab extends StatelessWidget {
  const AdminProductHubTab({super.key});

  static const id = 'productHubTab';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Hardcoded
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                icon: const PlatformAdaptiveIcon(
                  materialIcon: Icons.folder,
                  cupertinoIcon: CupertinoIcons.folder,
                ),
                text: context.loc.categories,
              ),
              Tab(
                icon: const PlatformAdaptiveIcon(
                  cupertinoIcon: CupertinoIcons.list_bullet,
                  materialIcon: Icons.list,
                ),
                text: context.loc.products,
              ),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: [
                AdminCategoriesTab(),
                AdminProductsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

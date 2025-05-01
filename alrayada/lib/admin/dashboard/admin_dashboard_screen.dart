import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/extensions/scaffold_messenger_ext.dart';
import '../../common/localizations/app_localization_extension.dart';
import '../../common/presentation/widgets/platform_adaptive_icon.dart';
import '../../common/presentation/widgets/responsive_navbar.dart';
import '../../dashboard/tab_item.dart';
import '../live_chat/logic/admin_live_chat_cubit.dart';
import 'tabs/admin_users_tab.dart';
import 'tabs/live_chat/admin_live_chat_tab.dart';
import 'tabs/product_hub/admin_product_hub_tab.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  static const routeName = '/adminDashboard';

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  List<TabItem> get _tabs => [
        TabItem(
          id: AdminUsersTab.id,
          label: context.loc.users,
          body: const AdminUsersTab(
            key: PageStorageKey(AdminUsersTab.id),
          ),
          title: context.loc.users,
          icon: const PlatformAdaptiveIcon(
            materialIcon: Icons.person,
            cupertinoIcon: CupertinoIcons.person,
          ),
        ),
        TabItem(
          id: AdminProductHubTab.id,
          label: context.loc.productHub,
          body: const AdminProductHubTab(),
          title: context.loc.productHub,
          icon: const PlatformAdaptiveIcon(
            materialIcon: Icons.category,
            cupertinoIcon: CupertinoIcons.bag_fill,
          ),
        ),
        TabItem(
          id: 'Orders',
          label: context.loc.orders,
          body: const Text('Orders'),
          title: context.loc.orders,
          icon: const PlatformAdaptiveIcon(
            materialIcon: Icons.shopping_cart,
            cupertinoIcon: CupertinoIcons.shopping_cart,
          ),
        ),
        TabItem(
          id: AdminLiveChatTab.id,
          label: context.loc.chat,
          body: const AdminLiveChatTab(),
          title: context.loc.chat,
          icon: const PlatformAdaptiveIcon(
            materialIcon: Icons.chat,
            cupertinoIcon: CupertinoIcons.chat_bubble,
          ),
          actionsBuilder: (context) => [
            BlocConsumer<AdminLiveChatCubit, AdminLiveChatState>(
              listener: (context, state) {
                if (state is AdminLiveChatDeleteAllRoomsFailure) {
                  ScaffoldMessenger.of(context)
                      .showSnackBarText(context.loc.unknownErrorWithMsg(
                    state.exception.message,
                  ));
                }
              },
              builder: (context, state) {
                return IconButton(
                  color: Theme.of(context).colorScheme.error,
                  onPressed: state is AdminLiveChatDeleteAllRoomsInProgress
                      ? null
                      : () =>
                          context.read<AdminLiveChatCubit>().deleteAllRooms(),
                  icon: PlatformAdaptiveIcon(
                    materialIcon: Icons.delete,
                    cupertinoIcon: CupertinoIcons.delete,
                    semanticLabel: context.loc.delete,
                  ),
                );
              },
            ),
          ],
        ),
        const TabItem(
          id: 'Offers',
          label: 'Offers',
          body: Text('Offers'),
          title: 'Offers',
          icon: PlatformAdaptiveIcon(
            materialIcon: Icons.attach_money,
            cupertinoIcon: CupertinoIcons.money_dollar,
          ),
        ),
      ];

  void _navigateToTab(int newIndex) => setState(() => _currentIndex = newIndex);

  var _currentIndex = 0;
  final _pageStorageBucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return ResponsiveNavbar(
      tabs: _tabs,
      currentIndex: _currentIndex,
      onDestinationSelected: _navigateToTab,
      pageStorageBucket: _pageStorageBucket,
    );
  }
}

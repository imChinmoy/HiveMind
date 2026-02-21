import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frontend/config/core/custom_appbar.dart';
import 'package:frontend/config/themes/app_colors.dart';
import 'package:frontend/config/themes/app_textstyle.dart';
import 'package:frontend/config/utils/dummy.dart';
import 'package:frontend/features/home/presentation/widgets/avatar_widget.dart';
import 'package:frontend/features/home/presentation/widgets/channel_card_widget.dart';
import 'package:frontend/features/profile/presentation/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({Key? key}) : super(key: key);

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      drawer: _buildDrawer(),
      body: Container(
        decoration: AppGradients.appBackground,
        child: CustomScrollView(
          slivers: [
            CustomAppbar(p1title: "Hive", p2title: "Mind"),
            _buildServerRail(),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              sliver: _buildExplore(),
            ),
          ],
        ),
      ),
    );
  }
}

SliverToBoxAdapter _buildServerRail() {
  return SliverToBoxAdapter(
    child: SizedBox(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: _AddServerButton(),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 20,
              ),
              child: _serversListView(),
            ),
          ),
        ],
      ),
    ),
  );
}
Widget _serversListView() {
  final servers = DummyUtils.getServers();

  return ListView.separated(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    itemCount: servers.length,
    separatorBuilder: (_, __) => const SizedBox(width: 14),
    itemBuilder: (context, index) {
      final server = servers[index];

      return AvatarWidget(
        name: server['name'],
        avatarUrl: server['avatar'],
        isOnline: true,
        size: 56,
      );
    },
  );
}
class _AddServerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surface,
        border: Border.all(color: AppColors.divider),
      ),
      child: GestureDetector(
        onTap: () => context.push('/add-server'),
        child: const Icon(Icons.add, color: AppColors.primary, size: 32)),
    );
  }
}

SliverToBoxAdapter _buildExplore() {
  return SliverToBoxAdapter(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Explore', style: AppTextStyles.heading),

            GestureDetector(
              onTap: () {
                log('clicked view all');
              },
              child: Text(
                'View all channels',
                style: AppTextStyles.messageText,
              ),
            ),
          ],
        ),
        _CategoriesListView(),
      ],
    ),
  );
}

Widget _CategoriesListView() {
  final getChannels = DummyUtils.getCategories();

  return ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: getChannels.length,
    separatorBuilder: (_, __) => const SizedBox(height: 12),
    itemBuilder: (context, index) {
      final channel = getChannels[index];
      return ChannelCardWidget(
        thumbnail: channel['thumbnail'],
        title: channel['title'],
        subscriberCount: channel['subscriberCount'],
        callback: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        ),
      );
    },
  );
}


Widget _buildDrawer() {
  return SafeArea(
    child: Drawer(
      backgroundColor: AppColors.surfaceDark,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.person, color: AppColors.textSecondary),
              title: Text('Profile', style: AppTextStyles.channelTitle),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: AppColors.textSecondary),
              title: Text('Settings', style: AppTextStyles.channelTitle),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: AppColors.danger),
              title: Text('Logout', style: AppTextStyles.messageText),
            ),
          ],
        ),
      ),
    ),
  );
}
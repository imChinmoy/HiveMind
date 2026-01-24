import 'package:flutter/material.dart';
import 'package:frontend/config/themes/app_colors.dart';
import 'package:frontend/config/themes/app_textstyle.dart';
import 'package:frontend/config/utils/dummy.dart';
import 'package:frontend/features/home/presentation/widgets/avatar_widget.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({Key? key}) : super(key: key);

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: _buildDrawer(),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          _buildServerRail(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}


SliverAppBar _buildSliverAppBar() {
  return SliverAppBar(
    pinned: true,
    floating: true,
    snap: true,
    expandedHeight: 140,
    backgroundColor: AppColors.surfaceDark,
    elevation: 0,
    centerTitle: true,
    leading: Builder(
      builder: (context) => IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    ),
    flexibleSpace: FlexibleSpaceBar(
      titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
      title: Text('HiveMind', style: AppTextStyles.heading),
      background: Container(
        decoration: const BoxDecoration(gradient: AppGradients.appBarGradient),
      ),
    ),
  );
}

SliverToBoxAdapter _buildServerRail() {
  return SliverToBoxAdapter(
    child: Container(
      height: 88,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        gradient: AppGradients.serverRailGradient,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 12),
          _AddServerButton(),

          const SizedBox(width: 12),
          Expanded(child: _serversListView()),

          const SizedBox(width: 12),
        ],
      ),
    ),
  );
}

Widget _serversListView() {
  final servers = DummyUtils.getServers();

  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: servers.length,
    separatorBuilder: (_, __) => const SizedBox(width: 14),
    itemBuilder: (context, index) {
      final server = servers[index];

      return AvatarWidget(
        avatarUrl: server['icon'],
        isOnline: server['isLive'],
        size: 56,
      );
    },
  );
}

class _AddServerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surface,
        border: Border.all(color: AppColors.divider),
      ),
      child: const Icon(Icons.add, color: AppColors.primary, size: 28),
    );
  }
}

Widget _buildDrawer() {
  return Drawer(
    backgroundColor: AppColors.surfaceDark,
    child: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
  );
}


Widget _buildBottomNavigationBar(){

  
  return BottomNavigationBar(
    backgroundColor: AppColors.surfaceDark,
    unselectedItemColor: AppColors.textSecondary,
    selectedItemColor: AppColors.primary,
    currentIndex: 0,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ],
  );
}
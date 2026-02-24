import 'package:flutter/material.dart';
import 'package:frontend/config/themes/app_colors.dart';

class CustomAppbar extends StatelessWidget {
  final String p1title;
  final String p2title;
  final Widget? leading;
  const CustomAppbar({super.key, required this.p1title, required this.p2title, this.leading});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: true,
      expandedHeight: 150,
      collapsedHeight: 100,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      shape: Border(
        bottom: BorderSide(
          color: AppColors.primary,
      
        ),

      ),
      elevation: 1,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 0, right: 0, bottom: 30),
        title: RichText(
          text: TextSpan(
            text: p1title,
            style: TextStyle(
              fontFamily: 'Hunters K-Pop',
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
              fontSize: 28,
              height: 1.0,
            ),
            children: [
              TextSpan(
                text: p2title,
                style: TextStyle(
                  color: AppColors.primarySoft,
                  fontSize: 28,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: AppGradients.appBarGradient,
          ),
        ),
      ),
    );
  }
}

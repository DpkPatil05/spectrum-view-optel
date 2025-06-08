import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spectrum_painter/common/common_constants.dart';
import 'package:spectrum_painter/common/theme/theme_data.dart';

import '../../../common/routes/routes.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Painter's Dashboard"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: ColorConstants.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _NavigationTile(
              icon: Icons.login,
              label: 'Login / Logout',
              onTap: () {
                context.pushReplacement('/${Routers.root.path}');
              },
            ),
            _NavigationTile(
              icon: Icons.qr_code_scanner,
              label: 'Verify Product',
              onTap: () {
                context.push('/${Routers.verify.path}');
              },
            ),
            _NavigationTile(
              icon: Icons.check_circle,
              label: 'Mark as Bought',
              onTap: () {
                context.push('/${Routers.markBought.path}');
              },
            ),
            _NavigationTile(
              icon: Icons.redeem,
              label: 'Redeem Points',
              onTap: () {
                context.push('/${Routers.redeem.path}');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavigationTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.primaryWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withAlpha((0.1 * 255).round()),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.blue),
            const SizedBox(height: 12),
            Text(
              label,
              style: CustomThemeData.defaultTextStyle.copyWith(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

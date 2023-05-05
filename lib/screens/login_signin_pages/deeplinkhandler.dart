import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router/go_router.dart';
class DeepLinkHandler extends StatelessWidget {
  final String? token;

  DeepLinkHandler({required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Token: $token'),
      ),
    );
  }
}
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/user/signup',
      pageBuilder: (context, state) => MaterialPage(
        child: DeepLinkHandler(
          token: state.queryParameters['token'] ?? '',
        ),
      ),
    ),
  ],
);
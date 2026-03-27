import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/app_shell.dart';
import '../../features/ai_assistant/presentation/assistant_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/providers/auth_controller.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/feed/presentation/feed_screen.dart';
import '../../features/pets/presentation/pets_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';

final appRouterProvider = Provider<GoRouter>((Ref ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (BuildContext context, GoRouterState state) {
      final loggedIn = authState.session != null;
      final onLogin = state.matchedLocation == '/login';
      final onSplash = state.matchedLocation == '/splash';

      if (!authState.isInitialized) {
        return onSplash ? null : '/splash';
      }

      if (!loggedIn) {
        return onLogin ? null : '/login';
      }

      if (onLogin || onSplash) {
        return '/feed';
      }

      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/splash',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return AppShell(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/feed',
            builder: (BuildContext context, GoRouterState state) {
              return const FeedScreen();
            },
          ),
          GoRoute(
            path: '/pets',
            builder: (BuildContext context, GoRouterState state) {
              return const PetsScreen();
            },
          ),
          GoRoute(
            path: '/assistant',
            builder: (BuildContext context, GoRouterState state) {
              return const AssistantScreen();
            },
          ),
          GoRoute(
            path: '/profile',
            builder: (BuildContext context, GoRouterState state) {
              return const ProfileScreen();
            },
          ),
        ],
      ),
    ],
  );
});

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:treesense/features/auth/infrastructure/storage/auth_storage.dart';
import 'package:treesense/features/auth/presentation/pages/login_page.dart';
import 'package:treesense/features/auth/presentation/pages/splash_page.dart';
import 'package:treesense/features/tree/presentation/pages/home_page.dart';
import 'package:treesense/test/toDelete/tree_page.dart';
import 'package:treesense/features/auth/presentation/state/auth_provider.dart';
import 'package:treesense/features/user/presentation/pages/user_profile_page.dart';
import 'package:treesense/features/tree/presentation/pages/form/type_selection_page.dart';
import 'package:treesense/features/tree/presentation/pages/form/location_page.dart';
import 'package:treesense/features/tree/presentation/pages/form/characteristics_page.dart';
import 'package:treesense/features/tree/presentation/pages/form/defects_page.dart';
import 'package:treesense/features/tree/presentation/pages/form/photo_page.dart';
import 'package:treesense/features/tree/presentation/pages/form/observations_page.dart';
import 'package:treesense/features/tree/presentation/pages/form/summary_page.dart';

class AppRouter {
  // static final GoRouter router = GoRouter(
  //   // TODO: VOLVER A SPLASH
  //   initialLocation: '/tree-census/type',

  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) async {
      final ref = ProviderScope.containerOf(context);

      return await AuthGuard.guardRoutes(context, state, ref);
    },
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/tree-census',
        builder: (context, state) => const TreeCensusForm(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const UserProfilePage(),
      ),
      GoRoute(
        path: '/tree-census/type',
        builder: (context, state) => const TypeSelectionPage(),
      ),
      GoRoute(
        path: '/tree-census/location',
        builder: (context, state) => const TreeCensusLocationPage(),
      ),
      GoRoute(
        path: '/tree-census/characteristics',
        builder: (context, state) => const TreeCensusCharacteristicsPage(),
      ),
      GoRoute(
        path: '/tree-census/defects',
        builder: (context, state) => const TreeCensusDefectsPage(),
      ),
      GoRoute(
        path: '/tree-census/photo',
        builder: (context, state) => const TreeCensusPhotoPage(),
      ),
      GoRoute(
        path: '/tree-census/observations',
        builder: (context, state) => const TreeCensusObservationsPage(),
      ),
      GoRoute(
        path: '/tree-census/summary',
        builder: (context, state) => const TreeCensusSummaryPage(),
      ),
    ],
  );
}

class AuthGuard {
  static final AuthStorage _authStorage = AuthStorage();

  static Future<String?> guardRoutes(
    BuildContext context,
    GoRouterState state,
    ProviderContainer ref,
  ) async {
    final isLoginRoute = state.uri.path == '/login';
    final isSplashRoute = state.uri.path == '/splash';

    if (isSplashRoute) return null;

    final refreshTokenUseCase = ref.read(RefreshTokenProvider);

    final accessToken = await _authStorage.getAccessToken();

    if (accessToken == null) {
      return '/login';
    }

    final accessTokenExpired = await _authStorage.isAccessTokenExpired();

    bool isAuthenticated = !accessTokenExpired;

    if (accessTokenExpired) {
      try {
        await refreshTokenUseCase();
        isAuthenticated = true;
      } catch (_) {
        isAuthenticated = false;
      }
    }

    if (!isAuthenticated && !isLoginRoute) {
      return '/login';
    }

    if (isAuthenticated && isLoginRoute) {
      return '/home';
    }

    return null;
  }
}

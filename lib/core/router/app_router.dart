import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:treesense/features/auth/infrastructure/storage/auth_storage.dart';
import 'package:treesense/features/auth/presentation/pages/login_page.dart';
import 'package:treesense/features/auth/presentation/pages/splash_page.dart';
import 'package:treesense/features/tree/presentation/pages/tree_page.dart';
import 'package:treesense/features/auth/presentation/state/auth_provider.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) async {
      final ref = ProviderScope.containerOf(context);

      return await AuthGuard.guardRoutes(context, state, ref);
    },
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/tree-census',
        builder: (context, state) => const TreeCensusForm(),
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

    // No redirigir desde la splash screen
    if (isSplashRoute) return null;

    // Obtener el use case de refresco de token
    final refreshTokenUseCase = ref.read(RefreshTokenProvider);

    // Comprobación de expiración del token
    final accessToken = await _authStorage.getAccessToken();

    if (accessToken == null) {
      return '/login';
    }

    final accessTokenExpired = await _authStorage.isAccessTokenExpired();

    bool isAuthenticated = !accessTokenExpired;

    // Si el token ha expirado, intentamos refrescarlo
    if (accessTokenExpired) {
      try {
        await refreshTokenUseCase(); // Intenta refrescar el token
        isAuthenticated = true;
      } catch (_) {
        isAuthenticated = false;
      }
    }

    // Si no estamos autenticados y no estamos en la ruta de login, redirigimos al login
    if (!isAuthenticated && !isLoginRoute) {
      return '/login';
    }

    // Si estamos autenticados y estamos en la página de login, redirigimos al tree-census
    if (isAuthenticated && isLoginRoute) {
      return '/tree-census';
    }

    // Si todo está bien, no redirigimos
    return null;
  }
}

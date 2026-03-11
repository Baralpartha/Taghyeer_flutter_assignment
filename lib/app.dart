import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/di/injection.dart';
import 'presentation/cubits/auth/auth_cubit.dart';
import 'presentation/cubits/auth/auth_state.dart';
import 'presentation/cubits/theme/theme_cubit.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/post_detail_page.dart';
import 'presentation/pages/product_detail_page.dart';
import 'presentation/pages/splash_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = sl<AuthCubit>()..checkSession();
    final themeCubit = sl<ThemeCubit>()..loadTheme();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authCubit),
        BlocProvider.value(value: themeCubit),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          final router = GoRouter(
            navigatorKey: _rootNavigatorKey,
            initialLocation: '/splash',
            refreshListenable: GoRouterRefreshStream(authCubit.stream),
            redirect: (context, state) {
              final authState = authCubit.state;
              final loc = state.matchedLocation;

              if (authState is AuthChecking) return '/splash';

              final isLoggedIn = authState is AuthAuthenticated;
              final isAuthPage = loc == '/login' || loc == '/splash';

              if (!isLoggedIn && !isAuthPage) return '/login';
              if (isLoggedIn && isAuthPage) return '/home';

              return null;
            },
            routes: [
              GoRoute(
                path: '/splash',
                builder: (_, __) => const SplashPage(),
              ),
              GoRoute(
                path: '/login',
                builder: (_, __) => const LoginPage(),
              ),
              GoRoute(
                path: '/home',
                builder: (_, __) => const HomePage(),
              ),
              GoRoute(
                path: '/product-detail',
                builder: (_, state) =>
                    ProductDetailPage(product: state.extra as dynamic),
              ),
              GoRoute(
                path: '/post-detail',
                builder: (_, state) =>
                    PostDetailPage(post: state.extra as dynamic),
              ),
            ],
          );

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Taghyeer Assignment',
            themeMode: themeMode,
            theme: ThemeData(
              colorSchemeSeed: Colors.blue,
              useMaterial3: true,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              colorSchemeSeed: Colors.blue,
              useMaterial3: true,
              brightness: Brightness.dark,
            ),
            routerConfig: router,
          );
        },
      ),
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _sub = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
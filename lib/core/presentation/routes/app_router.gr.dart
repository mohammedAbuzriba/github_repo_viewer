// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../../../auth/presentation/authorization_page.dart' as _i3;
import '../../../auth/presentation/sign_in_page.dart' as _i2;
import '../../../githup/data/model/repo_starred_model.dart' as _i8;
import '../../../githup/presentation/repo_detail/repo_detail.dart' as _i5;
import '../../../githup/presentation/repo_starred_page/repo_starred_page.dart'
    as _i4;
import '../../../splash/presentation/splash_page.dart' as _i1;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SignInPage(),
      );
    },
    AuthorizationRoute.name: (routeData) {
      final args = routeData.argsAs<AuthorizationRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.AuthorizationPage(
          key: args.key,
          authorizationUrl: args.authorizationUrl,
          onAuthorizationCodeRedirectAttempt:
              args.onAuthorizationCodeRedirectAttempt,
        ),
      );
    },
    RepoStarredRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.RepoStarredPage(),
      );
    },
    RepoDetailRoute.name: (routeData) {
      final args = routeData.argsAs<RepoDetailRouteArgs>(
          orElse: () => const RepoDetailRouteArgs());
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.RepoDetailPage(
          key: args.key,
          repo: args.repo,
          fullname: args.fullname,
        ),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i6.RouteConfig(
          SignInRoute.name,
          path: '/sign-in',
        ),
        _i6.RouteConfig(
          AuthorizationRoute.name,
          path: '/auth',
        ),
        _i6.RouteConfig(
          RepoStarredRoute.name,
          path: '/repostarred',
        ),
        _i6.RouteConfig(
          RepoDetailRoute.name,
          path: '/repostarred',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.SignInPage]
class SignInRoute extends _i6.PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: '/sign-in',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i3.AuthorizationPage]
class AuthorizationRoute extends _i6.PageRouteInfo<AuthorizationRouteArgs> {
  AuthorizationRoute({
    _i7.Key? key,
    required Uri authorizationUrl,
    required void Function(Uri) onAuthorizationCodeRedirectAttempt,
  }) : super(
          AuthorizationRoute.name,
          path: '/auth',
          args: AuthorizationRouteArgs(
            key: key,
            authorizationUrl: authorizationUrl,
            onAuthorizationCodeRedirectAttempt:
                onAuthorizationCodeRedirectAttempt,
          ),
        );

  static const String name = 'AuthorizationRoute';
}

class AuthorizationRouteArgs {
  const AuthorizationRouteArgs({
    this.key,
    required this.authorizationUrl,
    required this.onAuthorizationCodeRedirectAttempt,
  });

  final _i7.Key? key;

  final Uri authorizationUrl;

  final void Function(Uri) onAuthorizationCodeRedirectAttempt;

  @override
  String toString() {
    return 'AuthorizationRouteArgs{key: $key, authorizationUrl: $authorizationUrl, onAuthorizationCodeRedirectAttempt: $onAuthorizationCodeRedirectAttempt}';
  }
}

/// generated route for
/// [_i4.RepoStarredPage]
class RepoStarredRoute extends _i6.PageRouteInfo<void> {
  const RepoStarredRoute()
      : super(
          RepoStarredRoute.name,
          path: '/repostarred',
        );

  static const String name = 'RepoStarredRoute';
}

/// generated route for
/// [_i5.RepoDetailPage]
class RepoDetailRoute extends _i6.PageRouteInfo<RepoDetailRouteArgs> {
  RepoDetailRoute({
    _i7.Key? key,
    _i8.RepoStarred? repo,
    String? fullname,
  }) : super(
          RepoDetailRoute.name,
          path: '/repostarred',
          args: RepoDetailRouteArgs(
            key: key,
            repo: repo,
            fullname: fullname,
          ),
        );

  static const String name = 'RepoDetailRoute';
}

class RepoDetailRouteArgs {
  const RepoDetailRouteArgs({
    this.key,
    this.repo,
    this.fullname,
  });

  final _i7.Key? key;

  final _i8.RepoStarred? repo;

  final String? fullname;

  @override
  String toString() {
    return 'RepoDetailRouteArgs{key: $key, repo: $repo, fullname: $fullname}';
  }
}

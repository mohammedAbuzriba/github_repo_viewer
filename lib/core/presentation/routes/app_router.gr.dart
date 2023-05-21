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
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../../../auth/presentation/authorization_page.dart' as _i3;
import '../../../auth/presentation/sign_in_page.dart' as _i2;
import '../../../githup/data/model/repo_starred_model.dart' as _i9;
import '../../../githup/presentation/repo_detail/repo_detail.dart' as _i6;
import '../../../githup/presentation/repo_starred_page/repo_starred_page.dart'
    as _i5;
import '../../../splash/presentation/splash_page.dart' as _i1;
import '../../../starred_repos/presentation/starred_repos_page.dart' as _i4;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SignInPage(),
      );
    },
    AuthorizationRoute.name: (routeData) {
      final args = routeData.argsAs<AuthorizationRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.AuthorizationPage(
          key: args.key,
          authorizationUrl: args.authorizationUrl,
          onAuthorizationCodeRedirectAttempt:
              args.onAuthorizationCodeRedirectAttempt,
        ),
      );
    },
    StarredReposRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.StarredReposPage(),
      );
    },
    RepoStarredRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.RepoStarredPage(),
      );
    },
    RepoDetailRoute.name: (routeData) {
      final args = routeData.argsAs<RepoDetailRouteArgs>(
          orElse: () => const RepoDetailRouteArgs());
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.RepoDetailPage(
          key: args.key,
          repo: args.repo,
        ),
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i7.RouteConfig(
          SignInRoute.name,
          path: '/sign-in',
        ),
        _i7.RouteConfig(
          AuthorizationRoute.name,
          path: '/auth',
        ),
        _i7.RouteConfig(
          StarredReposRoute.name,
          path: '/starred',
        ),
        _i7.RouteConfig(
          RepoStarredRoute.name,
          path: '/repostarred',
        ),
        _i7.RouteConfig(
          RepoDetailRoute.name,
          path: '/repostarred',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.SignInPage]
class SignInRoute extends _i7.PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: '/sign-in',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i3.AuthorizationPage]
class AuthorizationRoute extends _i7.PageRouteInfo<AuthorizationRouteArgs> {
  AuthorizationRoute({
    _i8.Key? key,
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

  final _i8.Key? key;

  final Uri authorizationUrl;

  final void Function(Uri) onAuthorizationCodeRedirectAttempt;

  @override
  String toString() {
    return 'AuthorizationRouteArgs{key: $key, authorizationUrl: $authorizationUrl, onAuthorizationCodeRedirectAttempt: $onAuthorizationCodeRedirectAttempt}';
  }
}

/// generated route for
/// [_i4.StarredReposPage]
class StarredReposRoute extends _i7.PageRouteInfo<void> {
  const StarredReposRoute()
      : super(
          StarredReposRoute.name,
          path: '/starred',
        );

  static const String name = 'StarredReposRoute';
}

/// generated route for
/// [_i5.RepoStarredPage]
class RepoStarredRoute extends _i7.PageRouteInfo<void> {
  const RepoStarredRoute()
      : super(
          RepoStarredRoute.name,
          path: '/repostarred',
        );

  static const String name = 'RepoStarredRoute';
}

/// generated route for
/// [_i6.RepoDetailPage]
class RepoDetailRoute extends _i7.PageRouteInfo<RepoDetailRouteArgs> {
  RepoDetailRoute({
    _i8.Key? key,
    _i9.RepoStarred? repo,
  }) : super(
          RepoDetailRoute.name,
          path: '/repostarred',
          args: RepoDetailRouteArgs(
            key: key,
            repo: repo,
          ),
        );

  static const String name = 'RepoDetailRoute';
}

class RepoDetailRouteArgs {
  const RepoDetailRouteArgs({
    this.key,
    this.repo,
  });

  final _i8.Key? key;

  final _i9.RepoStarred? repo;

  @override
  String toString() {
    return 'RepoDetailRouteArgs{key: $key, repo: $repo}';
  }
}

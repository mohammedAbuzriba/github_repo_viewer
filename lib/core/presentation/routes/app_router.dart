import 'package:auto_route/auto_route.dart';

import '../../../auth/presentation/authorization_page.dart';
import '../../../auth/presentation/sign_in_page.dart';
import '../../../githup/presentation/repo_detail/repo_detail.dart';
import '../../../githup/presentation/repo_starred_page/repo_starred_page.dart';
import '../../../splash/presentation/splash_page.dart';
import '../../../starred_repos/presentation/starred_repos_page.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: SplashPage, initial: true),
  MaterialRoute(page: SignInPage, path: '/sign-in'),
  MaterialRoute(page: AuthorizationPage, path: '/auth'),
  MaterialRoute(page: StarredReposPage, path: '/starred'),
  MaterialRoute(page: RepoStarredPage, path: '/repostarred'),
  MaterialRoute(page: RepoDetailPage, path: '/repostarred'),
], replaceInRouteName: 'Page,Route')
class $AppRouter {}

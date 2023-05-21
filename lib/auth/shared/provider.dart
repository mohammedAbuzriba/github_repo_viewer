import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../intrastructure/credentials_storage/credentials_storage.dart';
import '../intrastructure/credentials_storage/secure_credential_storage.dart';
import '../intrastructure/github_authenticator.dart';
import '/auth/application/auth_notifier.dart';

import 'package:riverpod/riverpod.dart';

final flutterSecureStorage = Provider((ref) => const FlutterSecureStorage());

final dioForAuthProvider = Provider((ref) => Dio());

// final oAuth2InterceptorProvider = Provider(
//   (ref) => OAuth2Interceptor(
//     ref.watch(githubAuthenticatorProvider),
//     ref.watch(authNotifierProvider.notifier),
//     ref.watch(dioForAuthProvider),
//   ),
// );

final credentialStorageProvider = Provider<CredentialStorage>(
  (ref) => SecureCredentialStorage(
    ref.watch(flutterSecureStorage),
  ),
);

final githubAuthenticatorProvider = Provider(
  (ref) => GithubAuthenticator(
    ref.watch(credentialStorageProvider),
    ref.watch(dioForAuthProvider),
  ),
);

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.watch(githubAuthenticatorProvider)),
);

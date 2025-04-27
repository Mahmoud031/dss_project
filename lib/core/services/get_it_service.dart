import 'package:dss_project/core/services/firestore_service.dart';
import 'package:dss_project/features/auth/data/repos/auth_repo_impl.dart';
import 'package:dss_project/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

import 'database_service.dart';
import 'firebase_auth_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<FirebaseAuthService>(
    FirebaseAuthService()
  );
  getIt.registerSingleton<DatabaseService>(
    FirestoreService()
  );
getIt.registerSingleton<AuthRepo>(
  AuthRepoImpl(
    firebaseAuthService: getIt<FirebaseAuthService>(),
    databaseService: getIt<DatabaseService>(),
  ),
);
}
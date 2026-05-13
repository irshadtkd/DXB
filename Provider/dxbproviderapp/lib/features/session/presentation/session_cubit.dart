import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_prefs_keys.dart';
import '../../../core/data/asset_json_loader.dart';
import '../domain/account_status.dart';
import 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit(this._loader, this._prefs) : super(const SessionState());

  final AssetJsonLoader _loader;
  final SharedPreferences _prefs;

  Future<void> hydrate() async {
    final data = await _loader.load(AppAssets.mockSession) as Map<String, dynamic>;
    final tutorialSeen = _prefs.getBool(AppPrefsKeys.hasSeenTutorial) ?? false;
    final loggedIn = _prefs.getBool(AppPrefsKeys.isLoggedIn) ?? false;
    final storedCats = _prefs.getStringList(AppPrefsKeys.providerCategories);
    final storedStatus = _prefs.getString(AppPrefsKeys.accountStatus);

    final accountStatus = loggedIn
        ? AccountStatus.fromJson(storedStatus ?? data['accountStatus'] as String?)
        : AccountStatus.draft;

    emit(
      SessionState(
        hydrated: true,
        accountStatus: accountStatus,
        isLoggedIn: loggedIn,
        hasSeenTutorial: tutorialSeen,
        role: data['role'] as String?,
        businessName: data['businessName'] as String? ?? '',
        providerCategoryIds: storedCats ?? const [],
      ),
    );
  }

  Future<void> completeTutorial() async {
    await _prefs.setBool(AppPrefsKeys.hasSeenTutorial, true);
    emit(state.copyWith(hasSeenTutorial: true));
  }

  Future<void> loginSuccess() async {
    await _prefs.setBool(AppPrefsKeys.isLoggedIn, true);
    await _prefs.setString(AppPrefsKeys.accountStatus, AccountStatus.approved.jsonName);
    emit(state.copyWith(isLoggedIn: true, accountStatus: AccountStatus.approved));
  }

  Future<void> logout() async {
    await _prefs.setBool(AppPrefsKeys.isLoggedIn, false);
    await _prefs.remove(AppPrefsKeys.accountStatus);
    await _prefs.remove(AppPrefsKeys.providerCategories);
    emit(
      state.copyWith(
        isLoggedIn: false,
        accountStatus: AccountStatus.draft,
        providerCategoryIds: const [],
      ),
    );
  }

  void selectRole(String roleId) {
    emit(state.copyWith(role: roleId));
  }

  Future<void> setProviderCategories(List<String> ids) async {
    final unique = [...ids.toSet()]..sort();
    await _prefs.setStringList(AppPrefsKeys.providerCategories, unique);
    emit(state.copyWith(providerCategoryIds: unique));
  }

  Future<void> submitRegistration() async {
    await _prefs.setBool(AppPrefsKeys.isLoggedIn, true);
    await _prefs.setString(AppPrefsKeys.accountStatus, AccountStatus.pendingApproval.jsonName);
    await _prefs.setStringList(AppPrefsKeys.providerCategories, state.providerCategoryIds);
    emit(
      state.copyWith(
        accountStatus: AccountStatus.pendingApproval,
        isLoggedIn: true,
      ),
    );
  }

  void setAccountStatus(AccountStatus s) {
    emit(state.copyWith(accountStatus: s));
  }

  Future<void> markApproved() async {
    await _prefs.setString(AppPrefsKeys.accountStatus, AccountStatus.approved.jsonName);
    emit(state.copyWith(accountStatus: AccountStatus.approved));
  }
}

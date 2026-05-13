import 'package:equatable/equatable.dart';

import '../domain/account_status.dart';

class SessionState extends Equatable {
  const SessionState({
    this.hydrated = false,
    this.accountStatus = AccountStatus.draft,
    this.isLoggedIn = false,
    this.hasSeenTutorial = false,
    this.role,
    this.businessName = '',
    this.providerCategoryIds = const [],
  });

  final bool hydrated;
  final AccountStatus accountStatus;
  final bool isLoggedIn;
  final bool hasSeenTutorial;
  final String? role;
  final String businessName;
  final List<String> providerCategoryIds;

  SessionState copyWith({
    bool? hydrated,
    AccountStatus? accountStatus,
    bool? isLoggedIn,
    bool? hasSeenTutorial,
    String? role,
    String? businessName,
    List<String>? providerCategoryIds,
  }) =>
      SessionState(
        hydrated: hydrated ?? this.hydrated,
        accountStatus: accountStatus ?? this.accountStatus,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        hasSeenTutorial: hasSeenTutorial ?? this.hasSeenTutorial,
        role: role ?? this.role,
        businessName: businessName ?? this.businessName,
        providerCategoryIds: providerCategoryIds ?? this.providerCategoryIds,
      );

  @override
  List<Object?> get props => [hydrated, accountStatus, isLoggedIn, hasSeenTutorial, role, businessName, providerCategoryIds];
}

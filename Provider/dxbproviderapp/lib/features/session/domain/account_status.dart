enum AccountStatus {
  draft,
  pendingApproval,
  approved,
  rejected,
  suspended;

  static AccountStatus fromJson(String? raw) {
    switch (raw) {
      case 'draft':
        return AccountStatus.draft;
      case 'pending':
      case 'pendingApproval':
        return AccountStatus.pendingApproval;
      case 'rejected':
        return AccountStatus.rejected;
      case 'suspended':
        return AccountStatus.suspended;
      case 'approved':
      default:
        return AccountStatus.approved;
    }
  }

  String get jsonName {
    switch (this) {
      case AccountStatus.draft:
        return 'draft';
      case AccountStatus.pendingApproval:
        return 'pending';
      case AccountStatus.approved:
        return 'approved';
      case AccountStatus.rejected:
        return 'rejected';
      case AccountStatus.suspended:
        return 'suspended';
    }
  }
}

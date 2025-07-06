class CertListArgs {
  final String? grep;
  final String? searchUserId;
  final bool owned;

  const CertListArgs({this.grep, this.searchUserId, this.owned = false});

  bool empty() {
    return grep == null && searchUserId == null;
  }
}

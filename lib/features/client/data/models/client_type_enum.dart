enum ClientType {
  particulier,
  entreprise;

  String get displayName {
    switch (this) {
      case ClientType.particulier:
        return 'Particulier';
      case ClientType.entreprise:
        return 'Entreprise';
    }
  }
}

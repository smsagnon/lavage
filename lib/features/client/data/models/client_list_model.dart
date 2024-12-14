import 'package:equatable/equatable.dart';
import 'client_type_enum.dart';

class ClientList extends Equatable {
  final String id;
  final String firstname;
  final String lastname;
  final String phone;
  final String? email;
  final bool isActive;
  final ClientType type;
  final String? photoPath;

  const ClientList({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.phone,
    this.email,
    this.isActive = true,
    required this.type,
    this.photoPath,
  });

  String get fullName => '$firstname $lastname';

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstname': firstname,
        'lastname': lastname,
        'phone': phone,
        'email': email,
        'is_active': isActive,
        'type': type.name,
        'photo_path': photoPath,
      };

  factory ClientList.fromJson(Map<String, dynamic> json) => ClientList(
        id: json['id'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        phone: json['phone'],
        email: json['email'],
        isActive: json['is_active'] ?? true,
        type: ClientType.values.firstWhere(
          (e) => e.name == json['type'],
          orElse: () => ClientType.particulier,
        ),
        photoPath: json['photo_path'],
      );

  @override
  List<Object?> get props => [
        id,
        firstname,
        lastname,
        phone,
        email,
        isActive,
        type,
        photoPath,
      ];
}

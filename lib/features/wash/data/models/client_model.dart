import 'package:equatable/equatable.dart';

class Client extends Equatable {
  final String id;
  final String firstname;
  final String lastname;
  final String phone;
  final String? email;
  final bool isActive;

  const Client({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.phone,
    this.email,
    this.isActive = true,
  });

  String get fullName => '$firstname $lastname';

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstname': firstname,
    'lastname': lastname,
    'phone': phone,
    'email': email,
    'is_active': isActive,
  };

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json['id'],
    firstname: json['firstname'],
    lastname: json['lastname'],
    phone: json['phone'],
    email: json['email'],
    isActive: json['is_active'] ?? true,
  );

  @override
  List<Object?> get props => [id, firstname, lastname, phone, email, isActive];
}

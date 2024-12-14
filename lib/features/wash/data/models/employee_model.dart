import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String id;
  final String firstname;
  final String lastname;
  final String phone;
  final bool isActive;

  const Employee({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.phone,
    this.isActive = true,
  });

  String get fullName => '$firstname $lastname';

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstname': firstname,
    'lastname': lastname,
    'phone': phone,
    'is_active': isActive,
  };

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json['id'],
    firstname: json['firstname'],
    lastname: json['lastname'],
    phone: json['phone'],
    isActive: json['is_active'] ?? true,
  );

  @override
  List<Object?> get props => [id, firstname, lastname, phone, isActive];
}

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String firstname;
  final String lastname;
  final String username;
  final String phone;
  final String email;
  final String role;

  const User({
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.phone,
    required this.email,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
    'firstname': firstname,
    'lastname': lastname,
    'username': username,
    'phone': phone,
    'email': email,
    'role': role,
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    firstname: json['firstname'],
    lastname: json['lastname'],
    username: json['username'],
    phone: json['phone'],
    email: json['email'],
    role: json['role'],
  );

  @override
  List<Object> get props => [firstname, lastname, username, phone, email, role];
}

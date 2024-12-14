import 'package:equatable/equatable.dart';
import 'service_model.dart';
import 'car_body_model.dart';
import 'payment_method_model.dart';
import 'employee_model.dart';
import 'client_model.dart';

class CarWash extends Equatable {
  final String id;
  final List<WashService> services;
  final PaymentMethod paymentMethod;
  final CarBody carBody;
  final double normalPrice;
  final double negotiatedPrice;
  final List<Employee>? employees;
  final Client? client;
  final String? about;
  final DateTime createdAt;

  const CarWash({
    required this.id,
    required this.services,
    required this.paymentMethod,
    required this.carBody,
    required this.normalPrice,
    required this.negotiatedPrice,
    this.employees,
    this.client,
    this.about,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'services': services.map((s) => s.toJson()).toList(),
    'payment_method': paymentMethod.toJson(),
    'car_body': carBody.toJson(),
    'normal_price': normalPrice,
    'negotiated_price': negotiatedPrice,
    'employees': employees?.map((e) => e.toJson()).toList(),
    'client': client?.toJson(),
    'about': about,
    'created_at': createdAt.toIso8601String(),
  };

  factory CarWash.fromJson(Map<String, dynamic> json) => CarWash(
    id: json['id'],
    services: (json['services'] as List)
        .map((s) => WashService.fromJson(s))
        .toList(),
    paymentMethod: PaymentMethod.fromJson(json['payment_method']),
    carBody: CarBody.fromJson(json['car_body']),
    normalPrice: json['normal_price'].toDouble(),
    negotiatedPrice: json['negotiated_price'].toDouble(),
    employees: json['employees'] != null
        ? (json['employees'] as List)
            .map((e) => Employee.fromJson(e))
            .toList()
        : null,
    client: json['client'] != null
        ? Client.fromJson(json['client'])
        : null,
    about: json['about'],
    createdAt: DateTime.parse(json['created_at']),
  );

  @override
  List<Object?> get props => [
    id,
    services,
    paymentMethod,
    carBody,
    normalPrice,
    negotiatedPrice,
    employees,
    client,
    about,
    createdAt,
  ];
}

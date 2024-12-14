import 'package:equatable/equatable.dart';

class PaymentMethod extends Equatable {
  final String id;
  final String name;
  final String description;
  final bool isActive;
  final bool requiresDueDate;

  const PaymentMethod({
    required this.id,
    required this.name,
    this.description = '',
    this.isActive = true,
    this.requiresDueDate = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'is_active': isActive,
    'requires_due_date': requiresDueDate,
  };

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    id: json['id'],
    name: json['name'],
    description: json['description'] ?? '',
    isActive: json['is_active'] ?? true,
    requiresDueDate: json['requires_due_date'] ?? false,
  );

  @override
  List<Object?> get props => [id, name, description, isActive, requiresDueDate];
}

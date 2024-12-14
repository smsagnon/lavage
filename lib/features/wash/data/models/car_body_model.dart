import 'package:equatable/equatable.dart';

class CarBody extends Equatable {
  final String id;
  final String name;
  final String description;
  final bool isActive;

  const CarBody({
    required this.id,
    required this.name,
    this.description = '',
    this.isActive = true,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'is_active': isActive,
  };

  factory CarBody.fromJson(Map<String, dynamic> json) => CarBody(
    id: json['id'],
    name: json['name'],
    description: json['description'] ?? '',
    isActive: json['is_active'] ?? true,
  );

  @override
  List<Object?> get props => [id, name, description, isActive];
}

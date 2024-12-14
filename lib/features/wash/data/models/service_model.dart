import 'package:equatable/equatable.dart';

class WashService extends Equatable {
  final String id;
  final String name;
  final double normalPrice;
  final double negotiatedPrice;
  final String description;
  final bool isActive;

  const WashService({
    required this.id,
    required this.name,
    required this.normalPrice,
    required this.negotiatedPrice,
    this.description = '',
    this.isActive = true,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'normal_price': normalPrice,
    'negotiated_price': negotiatedPrice,
    'description': description,
    'is_active': isActive,
  };

  factory WashService.fromJson(Map<String, dynamic> json) => WashService(
    id: json['id'],
    name: json['name'],
    normalPrice: json['normal_price'].toDouble(),
    negotiatedPrice: json['negotiated_price'].toDouble(),
    description: json['description'] ?? '',
    isActive: json['is_active'] ?? true,
  );

  @override
  List<Object?> get props => [id, name, normalPrice, negotiatedPrice, description, isActive];
}

import 'package:equatable/equatable.dart';

class CarWashStation extends Equatable {
  final String name;
  final String phone;
  final String? geographicalAddress;

  const CarWashStation({
    required this.name,
    required this.phone,
    this.geographicalAddress,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'geographical_address': geographicalAddress,
  };

  factory CarWashStation.fromJson(Map<String, dynamic> json) => CarWashStation(
    name: json['name'],
    phone: json['phone'],
    geographicalAddress: json['geographical_address'],
  );

  @override
  List<Object?> get props => [name, phone, geographicalAddress];
}

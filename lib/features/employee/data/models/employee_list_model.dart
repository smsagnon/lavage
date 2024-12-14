import 'package:equatable/equatable.dart';

class EmployeeList extends Equatable {
  final String id;
  final String firstname;
  final String lastname;
  final String phone;
  final String? about;
  final DateTime? contractStartDate;
  final DateTime? contractEndDate;
  final String? contractEndReason;
  final String? photoPath;
  final bool isActive;

  const EmployeeList({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.phone,
    this.about,
    this.contractStartDate,
    this.contractEndDate,
    this.contractEndReason,
    this.photoPath,
    this.isActive = true,
  });

  String get fullName => '$firstname $lastname';

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstname': firstname,
        'lastname': lastname,
        'phone': phone,
        'about': about,
        'contract_start_date': contractStartDate?.toIso8601String(),
        'contract_end_date': contractEndDate?.toIso8601String(),
        'contract_end_reason': contractEndReason,
        'photo_path': photoPath,
        'is_active': isActive,
      };

  factory EmployeeList.fromJson(Map<String, dynamic> json) => EmployeeList(
        id: json['id'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        phone: json['phone'],
        about: json['about'],
        contractStartDate: json['contract_start_date'] != null
            ? DateTime.parse(json['contract_start_date'])
            : null,
        contractEndDate: json['contract_end_date'] != null
            ? DateTime.parse(json['contract_end_date'])
            : null,
        contractEndReason: json['contract_end_reason'],
        photoPath: json['photo_path'],
        isActive: json['is_active'] ?? true,
      );

  @override
  List<Object?> get props => [
        id,
        firstname,
        lastname,
        phone,
        about,
        contractStartDate,
        contractEndDate,
        contractEndReason,
        photoPath,
        isActive,
      ];
}

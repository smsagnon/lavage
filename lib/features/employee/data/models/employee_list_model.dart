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
  final String contractType;
  final String? pieceType;
  final String? pieceNumber;
  final double salary;
  final String? emergencyContactName; // Added emergency contact name
  final String? emergencyContactPhone; // Added emergency contact phone


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
    this.contractType = 'CDD',
    this.pieceType,
    this.pieceNumber,
    required this.salary,
    this.emergencyContactName, // Added emergency contact name
    this.emergencyContactPhone, // Added emergency contact phone
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
        'contract_type': contractType,
        'piece_type': pieceType,
        'piece_number': pieceNumber,
        'salary': salary,
        'emergency_contact_name': emergencyContactName, // Added emergency contact name to JSON
        'emergency_contact_phone': emergencyContactPhone, // Added emergency contact phone to JSON
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
        contractType: json['contract_type'] ?? 'CDD',
        pieceType: json['piece_type'],
        pieceNumber: json['piece_number'],
        salary: json['salary'].toDouble(),
        emergencyContactName: json['emergency_contact_name'], // Added emergency contact name from JSON
        emergencyContactPhone: json['emergency_contact_phone'], // Added emergency contact phone from JSON
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
        contractType,
        pieceType,
        pieceNumber,
        salary,
        emergencyContactName, // Added emergency contact name to props
        emergencyContactPhone, // Added emergency contact phone to props
      ];
}

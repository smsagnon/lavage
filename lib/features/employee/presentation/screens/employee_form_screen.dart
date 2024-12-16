import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../bloc/employee_bloc.dart';
import '../../data/models/employee_list_model.dart';
import 'package:path/path.dart' as path;

class EmployeeFormScreen extends StatefulWidget {
  final EmployeeList? employee;

  const EmployeeFormScreen({
    super.key,
    this.employee,
  });

  @override
  State<EmployeeFormScreen> createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _aboutController = TextEditingController();
  final _pieceNumberController = TextEditingController();
  final _salaryController = TextEditingController();
  final _emergencyContactNameController = TextEditingController();
  final _emergencyContactPhoneController = TextEditingController();
  DateTime? _contractStartDate;
  DateTime? _contractEndDate;
  String? _contractEndReason;
  File? _imageFile;
  String? _selectedContractType = 'CDD';
  String? _selectedPieceType;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.employee != null) {
      _firstnameController.text = widget.employee!.firstname;
      _lastnameController.text = widget.employee!.lastname;
      _phoneController.text = widget.employee!.phone;
      _aboutController.text = widget.employee!.about ?? '';
      _contractStartDate = widget.employee!.contractStartDate;
      _contractEndDate = widget.employee!.contractEndDate;
      _contractEndReason = widget.employee!.contractEndReason;
      _selectedContractType = widget.employee!.contractType;
      _selectedPieceType = widget.employee!.pieceType;
      _pieceNumberController.text = widget.employee!.pieceNumber ?? '';
      _salaryController.text = widget.employee!.salary.toString();
      _emergencyContactNameController.text = widget.employee!.emergencyContactName ?? '';
      _emergencyContactPhoneController.text = widget.employee!.emergencyContactPhone ?? '';
      if (widget.employee!.photoPath != null) {
        _imageFile = File(widget.employee!.photoPath!);
      }
    }
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    _aboutController.dispose();
    _pieceNumberController.dispose();
    _salaryController.dispose();
    _emergencyContactNameController.dispose();
    _emergencyContactPhoneController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _contractStartDate ?? DateTime.now() : _contractEndDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _contractStartDate = picked;
        } else {
          _contractEndDate = picked;
        }
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final employeeData = EmployeeList(
        id: widget.employee?.id ?? '',
        firstname: _firstnameController.text,
        lastname: _lastnameController.text,
        phone: _phoneController.text,
        about: _aboutController.text,
        contractStartDate: _contractStartDate,
        contractEndDate: _contractEndDate,
        contractEndReason: _contractEndReason,
        photoPath: _imageFile != null ? _imageFile!.path : null,
        isActive: true,
        contractType: _selectedContractType!,
        pieceType: _selectedPieceType,
        pieceNumber: _pieceNumberController.text,
        salary: double.tryParse(_salaryController.text) ?? 0.0,
        emergencyContactName: _emergencyContactNameController.text,
        emergencyContactPhone: _emergencyContactPhoneController.text,
      );

      // TODO: Implement form submission logic here. Pass employeeData to your Bloc or repository.
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.employee == null ? 'Nouvel employé' : 'Modifier employé'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Photo Upload Section
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).primaryColor,
                      backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                      child: _imageFile == null
                          ? const Icon(Icons.person, size: 50, color: Colors.white)
                          : null,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 18,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, size: 18),
                          color: Colors.white,
                          onPressed: _pickImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Personal Information
              TextFormField(
                controller: _firstnameController,
                decoration: const InputDecoration(
                  labelText: 'Prénom*',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Veuillez entrer le prénom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _lastnameController,
                decoration: const InputDecoration(
                  labelText: 'Nom*',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Veuillez entrer le nom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Téléphone*',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Veuillez entrer le numéro de téléphone';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _aboutController,
                decoration: const InputDecoration(
                  labelText: 'À propos',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Salary TextFormField
              TextFormField(
                controller: _salaryController,
                decoration: const InputDecoration(
                  labelText: 'Salaire*',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Veuillez entrer le salaire';
                  }
                  if (double.tryParse(value!) == null) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Contract Information
              const Text(
                'Informations du contrat',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Contract Type Dropdown
              DropdownButtonFormField<String>(
                value: _selectedContractType,
                decoration: const InputDecoration(
                  labelText: 'Type de contrat*',
                  border: OutlineInputBorder(),
                ),
                items: <String>['CDD', 'CDI', 'journalier', 'quinzaine']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedContractType = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner un type de contrat';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Contract Start Date
              InkWell(
                onTap: () => _selectDate(context, true),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date de début du contrat*',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _contractStartDate != null
                        ? dateFormat.format(_contractStartDate!)
                        : 'Sélectionner une date',
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Piece Type Dropdown
              DropdownButtonFormField<String>(
                value: _selectedPieceType,
                decoration: const InputDecoration(
                  labelText: 'Type de pièce (optionnel)',
                  border: OutlineInputBorder(),
                ),
                items: <String>[
                  'CNI',
                  'Attestation d\'identité',
                  'Certificat de nationalité',
                  'extrait de naissance',
                  'permis de conduire',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPieceType = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Piece Number TextFormField
              TextFormField(
                controller: _pieceNumberController,
                decoration: const InputDecoration(
                  labelText: 'Numéro de pièce',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              // Emergency Contact Section
              const Text(
                'Personne à contacter en cas d\'urgence',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Emergency Contact Name
              TextFormField(
                controller: _emergencyContactNameController,
                decoration: const InputDecoration(
                  labelText: 'Nom & Prénom*',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Veuillez entrer le nom et prénom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Emergency Contact Phone
              TextFormField(
                controller: _emergencyContactPhoneController,
                decoration: const InputDecoration(
                  labelText: 'Téléphone*',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Veuillez entrer le numéro de téléphone';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  widget.employee == null ? 'AJOUTER' : 'MODIFIER',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

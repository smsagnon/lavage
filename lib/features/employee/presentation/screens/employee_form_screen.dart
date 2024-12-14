import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/employee_bloc.dart';
import '../../data/models/employee_list_model.dart';

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
  final _contractEndReasonController = TextEditingController();
  DateTime? _contractStartDate;
  DateTime? _contractEndDate;
  String? _photoPath;

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
      _contractEndReasonController.text = widget.employee!.contractEndReason ?? '';
      _photoPath = widget.employee!.photoPath;
    }
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    _aboutController.dispose();
    _contractEndReasonController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? _contractStartDate ?? DateTime.now()
          : _contractEndDate ?? DateTime.now(),
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

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement form submission
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
                      backgroundImage: _photoPath != null ? NetworkImage(_photoPath!) : null,
                      child: _photoPath == null
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
                          onPressed: () {
                            // TODO: Implement photo upload
                          },
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

              // Contract End Date
              InkWell(
                onTap: () => _selectDate(context, false),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date de fin du contrat',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _contractEndDate != null
                        ? dateFormat.format(_contractEndDate!)
                        : 'Sélectionner une date',
                  ),
                ),
              ),
              const SizedBox(height: 16),

              if (_contractEndDate != null)
                TextFormField(
                  controller: _contractEndReasonController,
                  decoration: const InputDecoration(
                    labelText: 'Motif de fin de contrat',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
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

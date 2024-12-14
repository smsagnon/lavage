import 'package:flutter/material.dart';
import 'dart:io';
import '../../data/models/client_type_enum.dart';
import '../widgets/avatar_picker.dart';
import '../../../shared/presentation/widgets/app_layout.dart';
import '../../../auth/data/models/user_model.dart';

class ClientFormScreen extends StatefulWidget {
  final User user;

  const ClientFormScreen({
    super.key,
    required this.user,
  });

  @override
  State<ClientFormScreen> createState() => _ClientFormScreenState();
}

class _ClientFormScreenState extends State<ClientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  ClientType _selectedType = ClientType.particulier;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  String? _avatarPath;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleImageSelected(File image) {
    setState(() {
      _avatarPath = image.path;
      debugPrint('Image selected: ${image.path}');
    });
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      debugPrint('Form submitted with avatar: $_avatarPath');
      // TODO: Implement form submission
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Nouveau Client',
      user: widget.user,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Avatar Picker
              AvatarPicker(
                currentImagePath: _avatarPath,
                onImageSelected: _handleImageSelected,
              ),
              const SizedBox(height: 24),

              // Client Type
              DropdownButtonFormField<ClientType>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Type de client*',
                  border: OutlineInputBorder(),
                ),
                items: ClientType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.displayName),
                  );
                }).toList(),
                onChanged: (ClientType? value) {
                  if (value != null) {
                    setState(() {
                      _selectedType = value;
                    });
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez sélectionner un type de client';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom*',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Phone
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Téléphone*',
                  border: OutlineInputBorder(),
                  prefixText: '+',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Veuillez entrer un numéro de téléphone';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email (Optional)
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email (optionnel)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isNotEmpty ?? false) {
                    if (!value!.contains('@')) {
                      return 'Veuillez entrer une adresse email valide';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'AJOUTER',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

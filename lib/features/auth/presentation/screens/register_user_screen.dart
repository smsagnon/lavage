import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../../data/models/user_model.dart';

class RegisterUserScreen extends StatefulWidget {
  final Function(User, String) onUserSubmitted;
  final User? initialData;

  const RegisterUserScreen({
    super.key,
    required this.onUserSubmitted,
    this.initialData,
  });

  @override
  State<RegisterUserScreen> createState() => RegisterUserScreenState();
}

class RegisterUserScreenState extends State<RegisterUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstnameController;
  late final TextEditingController _lastnameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  String _selectedRole = 'proprietaire';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _firstnameController = TextEditingController(text: widget.initialData?.firstname);
    _lastnameController = TextEditingController(text: widget.initialData?.lastname);
    _usernameController = TextEditingController(text: widget.initialData?.username);
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneController = TextEditingController(text: widget.initialData?.phone);
    _emailController = TextEditingController(text: widget.initialData?.email);
    _selectedRole = widget.initialData?.role ?? 'proprietaire';
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void submitUser() {
    if (_formKey.currentState?.validate() ?? false) {
      final user = User(
        firstname: _firstnameController.text,
        lastname: _lastnameController.text,
        username: _usernameController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        role: _selectedRole,
      );
      widget.onUserSubmitted(user, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _firstnameController,
            decoration: const InputDecoration(
              labelText: 'First Name*',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter first name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _lastnameController,
            decoration: const InputDecoration(
              labelText: 'Last Name*',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter last name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username*',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter username';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password*',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            obscureText: _obscurePassword,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter password';
              }
              if ((value?.length ?? 0) < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirm Password*',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
            ),
            obscureText: _obscureConfirmPassword,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please confirm password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone*',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email*',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter email';
              }
              if (!value!.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedRole,
            decoration: const InputDecoration(
              labelText: 'Role*',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: 'proprietaire',
                child: Text('Propriétaire'),
              ),
              DropdownMenuItem(
                value: 'gerant_principal',
                child: Text('Gérant Principal'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedRole = value;
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a role';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

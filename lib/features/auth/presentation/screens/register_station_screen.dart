import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../../data/models/station_model.dart';

class RegisterStationScreen extends StatefulWidget {
  final Function(CarWashStation) onStationSubmitted;
  final CarWashStation? initialData;

  const RegisterStationScreen({
    super.key,
    required this.onStationSubmitted,
    this.initialData,
  });

  @override
  State<RegisterStationScreen> createState() => RegisterStationScreenState();
}

class RegisterStationScreenState extends State<RegisterStationScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialData?.name);
    _phoneController = TextEditingController(text: widget.initialData?.phone);
    _addressController = TextEditingController(text: widget.initialData?.geographicalAddress);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void submitStation() {
    if (_formKey.currentState?.validate() ?? false) {
      final station = CarWashStation(
        name: _nameController.text,
        phone: _phoneController.text,
        geographicalAddress: _addressController.text,
      );
      widget.onStationSubmitted(station);
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
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Station Name*',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter station name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone Number*',
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
            controller: _addressController,
            decoration: const InputDecoration(
              labelText: 'Geographical Address',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../../data/models/registration_state_model.dart';
import 'register_station_screen.dart';
import 'register_user_screen.dart';
import 'package:go_router/go_router.dart';

class RegistrationStepperScreen extends StatefulWidget {
  const RegistrationStepperScreen({super.key});

  @override
  State<RegistrationStepperScreen> createState() => RegistrationStepperScreenState();
}

class RegistrationStepperScreenState extends State<RegistrationStepperScreen> {
  late RegistrationState _registrationState;
  final _stationFormKey = GlobalKey<RegisterStationScreenState>();
  final _userFormKey = GlobalKey<RegisterUserScreenState>();
  String? _password;

  @override
  void initState() {
    super.initState();
    _registrationState = const RegistrationState();
  }

  List<Step> getSteps() => [
    Step(
      state: _registrationState.currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: _registrationState.currentStep >= 0,
      title: const Text('Station'),
      content: RegisterStationScreen(
        key: _stationFormKey,
        onStationSubmitted: (station) {
          setState(() {
            _registrationState = _registrationState.copyWith(
              station: station,
              currentStep: 1,
            );
          });
        },
        initialData: _registrationState.station,
      ),
    ),
    Step(
      state: _registrationState.currentStep > 1 ? StepState.complete : StepState.indexed,
      isActive: _registrationState.currentStep >= 1,
      title: const Text('User'),
      content: RegisterUserScreen(
        key: _userFormKey,
        onUserSubmitted: (user, password) {
          _password = password;
          setState(() {
            _registrationState = _registrationState.copyWith(
              user: user,
              currentStep: 2,
            );
          });
        },
        initialData: _registrationState.user,
      ),
    ),
    Step(
      isActive: _registrationState.currentStep >= 2,
      title: const Text('Review'),
      content: _buildReviewStep(),
    ),
  ];

  Widget _buildReviewStep() {
    if (_registrationState.station == null || _registrationState.user == null) {
      return const Center(child: Text('Please complete previous steps'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Station Information',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Name: ${_registrationState.station!.name}'),
        Text('Phone: ${_registrationState.station!.phone}'),
        if (_registrationState.station!.geographicalAddress != null)
          Text('Address: ${_registrationState.station!.geographicalAddress}'),
        
        const SizedBox(height: 16),
        const Text(
          'User Information',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Name: ${_registrationState.user!.firstname} ${_registrationState.user!.lastname}'),
        Text('Username: ${_registrationState.user!.username}'),
        Text('Phone: ${_registrationState.user!.phone}'),
        Text('Email: ${_registrationState.user!.email}'),
        Text('Role: ${_registrationState.user!.role == 'proprietaire' ? 'Propriétaire' : 'Gérant Principal'}'),
        
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _submitRegistration,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00B4D8),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'CONFIRM REGISTRATION',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _submitRegistration() {
    if (_registrationState.station != null && _registrationState.user != null && _password != null) {
      context.read<AuthBloc>().add(
        RegisterStationEvent(_registrationState.station!),
      );
      context.read<AuthBloc>().add(
        RegisterUserEvent(_registrationState.user!, _password!),
      );
    }
  }

  void _handleStepContinue() {
    if (_registrationState.currentStep == 0) {
      _stationFormKey.currentState?.submitStation();
    } else if (_registrationState.currentStep == 1) {
      _userFormKey.currentState?.submitUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is AuthSuccess && state.user != null) {
            context.go('/home', extra: state.user);
          }
        },
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: _registrationState.currentStep,
          steps: getSteps(),
          onStepContinue: _handleStepContinue,
          onStepCancel: () {
            if (_registrationState.currentStep > 0) {
              setState(() {
                _registrationState = _registrationState.copyWith(
                  currentStep: _registrationState.currentStep - 1,
                );
              });
            }
          },
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  if (_registrationState.currentStep > 0)
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: const Text('BACK'),
                    ),
                  const SizedBox(width: 8),
                  if (_registrationState.currentStep < 2)
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00B4D8),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'NEXT',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

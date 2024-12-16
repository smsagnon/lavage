import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/employee_bloc.dart';
import '../bloc/employee_event.dart';
import '../bloc/employee_state.dart';
import '../widgets/employee_card.dart';
import '../../data/models/employee_list_model.dart';
import 'employee_form_screen.dart';
import '../../../shared/presentation/widgets/app_layout.dart';
import '../../../auth/data/models/user_model.dart';

class EmployeeScreen extends StatefulWidget {
  final User user;

  const EmployeeScreen({
    super.key,
    required this.user,
  });

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeeBloc>().add(LoadEmployees());
  }

  void _navigateToEmployeeForm([EmployeeList? employee]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmployeeFormScreen(employee: employee),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Employés',
      user: widget.user,
      child: Stack(
        children: [
          BlocBuilder<EmployeeBloc, EmployeeState>(
            builder: (context, state) {
              if (state is EmployeeLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is EmployeeLoaded) {
                return ListView.builder(
                  itemCount: state.employees.length,
                  itemBuilder: (context, index) {
                    final employee = state.employees[index];
                    return EmployeeCard(
                      employee: employee,
                      onTap: () => _navigateToEmployeeForm(employee),
                    );
                  },
                );
              }

              if (state is EmployeeError) {
                return Center(child: Text(state.message));
              }

              return const Center(child: Text('No employees found'));
            },
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              heroTag: 'addEmployeeButton', // Unique tag here
              onPressed: _navigateToEmployeeForm,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

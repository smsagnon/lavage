import 'package:flutter_bloc/flutter_bloc.dart';
import 'employee_event.dart';
import 'employee_state.dart';
import '../../data/models/employee_list_model.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial()) {
    on<LoadEmployees>(_onLoadEmployees);
  }

  Future<void> _onLoadEmployees(
    LoadEmployees event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(EmployeeLoading());
    try {
      // TODO: Implement actual API call
      // Mock data for now
      final employees = [
        EmployeeList(
          id: '1',
          firstname: 'John',
          lastname: 'Doe',
          phone: '+1234567890',
          about: 'Experienced car washer with attention to detail',
          contractStartDate: DateTime(2023, 1, 1),
          contractEndDate: DateTime(2024, 12, 31),
          contractEndReason: null,
          photoPath: null,
          salary: 100000
        ),
        EmployeeList(
          id: '2',
          firstname: 'Jane',
          lastname: 'Smith',
          phone: '+0987654321',
          about: 'Senior car detailing specialist',
          contractStartDate: DateTime(2023, 3, 15),
          contractEndDate: null,
          contractEndReason: null,
          photoPath: null,
           salary: 120000
        ),
      ];
      emit(EmployeeLoaded(employees));
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }
}

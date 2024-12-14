import 'package:flutter_bloc/flutter_bloc.dart';
import 'wash_event.dart';
import 'wash_state.dart';
import '../../data/models/service_model.dart';
import '../../data/models/car_body_model.dart';
import '../../data/models/payment_method_model.dart';
import '../../data/models/employee_model.dart';
import '../../data/models/client_model.dart';

class WashBloc extends Bloc<WashEvent, WashState> {
  WashBloc() : super(WashInitial()) {
    on<LoadWashFormData>(_onLoadWashFormData);
    on<SubmitCarWash>(_onSubmitCarWash);
  }

  Future<void> _onLoadWashFormData(
    LoadWashFormData event,
    Emitter<WashState> emit,
  ) async {
    emit(WashLoading());
    try {
      // TODO: Load data from repository
      // For now, using mock data
      final services = [
        const WashService(
          id: '1',
          name: 'Simple Wash',
          normalPrice: 10.0,
          negotiatedPrice: 8.0,
        ),
        const WashService(
          id: '2',
          name: 'Complete Wash',
          normalPrice: 20.0,
          negotiatedPrice: 15.0,
        ),
      ];

      final carBodies = [
        const CarBody(id: '1', name: 'Sedan'),
        const CarBody(id: '2', name: 'SUV'),
        const CarBody(id: '3', name: 'Van'),
      ];

      final paymentMethods = [
        const PaymentMethod(id: '1', name: 'Cash'),
        const PaymentMethod(
          id: '2',
          name: 'Credit',
          requiresDueDate: true,
        ),
      ];

      final employees = [
        const Employee(
          id: '1',
          firstname: 'John',
          lastname: 'Doe',
          phone: '+1234567890',
        ),
      ];

      final clients = [
        const Client(
          id: '1',
          firstname: 'Jane',
          lastname: 'Smith',
          phone: '+0987654321',
        ),
      ];

      emit(WashFormLoaded(
        availableServices: services,
        availableCarBodies: carBodies,
        availablePaymentMethods: paymentMethods,
        availableEmployees: employees,
        availableClients: clients,
      ));
    } catch (e) {
      emit(WashError(e.toString()));
    }
  }

  Future<void> _onSubmitCarWash(
    SubmitCarWash event,
    Emitter<WashState> emit,
  ) async {
    emit(WashLoading());
    try {
      // TODO: Submit car wash to repository
      emit(WashSuccess());
    } catch (e) {
      emit(WashError(e.toString()));
    }
  }
}

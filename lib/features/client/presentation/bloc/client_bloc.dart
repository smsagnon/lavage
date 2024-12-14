import 'package:flutter_bloc/flutter_bloc.dart';
import 'client_event.dart';
import 'client_state.dart';
import '../../data/models/client_list_model.dart';
import '../../data/models/client_type_enum.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  ClientBloc() : super(ClientInitial()) {
    on<LoadClients>(_onLoadClients);
  }

  Future<void> _onLoadClients(
    LoadClients event,
    Emitter<ClientState> emit,
  ) async {
    emit(ClientLoading());
    try {
      // TODO: Implement actual API call
      // Mock data for now
      final clients = [
        const ClientList(
          id: '1',
          firstname: 'Alice',
          lastname: 'Johnson',
          phone: '+1234567890',
          email: 'alice@example.com',
          type: ClientType.particulier, // Added type here
        ),
        const ClientList(
          id: '2',
          firstname: 'Bob',
          lastname: 'Williams',
          phone: '+0987654321',
          type: ClientType.entreprise, // Added type here
        ),
      ];
      emit(ClientLoaded(clients));
    } catch (e) {
      emit(ClientError(e.toString()));
    }
  }
}

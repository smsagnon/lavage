import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/client_bloc.dart';
import '../bloc/client_event.dart';
import '../bloc/client_state.dart';
import '../widgets/client_card.dart';
import 'client_form_screen.dart';
import '../../../shared/presentation/widgets/app_layout.dart';
import '../../../auth/data/models/user_model.dart';

class ClientScreen extends StatefulWidget {
  final User user;

  const ClientScreen({
    super.key,
    required this.user,
  });

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ClientBloc>().add(LoadClients());
  }

  void _navigateToClientForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClientFormScreen(user: widget.user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Clients',
      user: widget.user,
      child: Stack(
        children: [
          BlocBuilder<ClientBloc, ClientState>(
            builder: (context, state) {
              if (state is ClientLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ClientLoaded) {
                return ListView.builder(
                  itemCount: state.clients.length,
                  itemBuilder: (context, index) {
                    final client = state.clients[index];
                    return ClientCard(
                      client: client,
                      user: widget.user,
                      onTap: () {
                        // TODO: Navigate to client details
                      },
                    );
                  },
                );
              }

              if (state is ClientError) {
                return Center(child: Text(state.message));
              }

              return const Center(child: Text('No clients found'));
            },
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: _navigateToClientForm,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

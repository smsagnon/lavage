import 'package:car_wash_app/features/client/data/models/client_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/client_bloc.dart';
import '../bloc/client_event.dart';
import '../bloc/client_state.dart';
import '../widgets/client_card.dart';
import 'client_form_screen.dart';
import '../../../shared/presentation/widgets/app_layout.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/models/client_type_enum.dart';

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
  final _searchController = TextEditingController();
  ClientType? _selectedType;

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
      child: SizedBox(
        // Use SizedBox to constrain the Column's width
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Rechercher par nom',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        // Implement search filtering here
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: DropdownButtonFormField<ClientType>(
                      value: _selectedType,
                      decoration: const InputDecoration(
                        labelText: 'Type de client',
                        border: OutlineInputBorder(),
                      ),
                      items: ClientType.values.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type.displayName),
                        );
                      }).toList(),
                      onChanged: (ClientType? value) {
                        setState(() {
                          _selectedType = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  BlocBuilder<ClientBloc, ClientState>(
                    builder: (context, state) {
                      if (state is ClientLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is ClientLoaded) {
                        List<ClientList> filteredClients = state.clients;

                        if (_searchController.text.isNotEmpty) {
                          filteredClients = filteredClients
                              .where((client) => client.fullName
                                  .toLowerCase()
                                  .contains(
                                      _searchController.text.toLowerCase()))
                              .toList();
                        }

                        if (_selectedType != null) {
                          filteredClients = filteredClients
                              .where((client) => client.type == _selectedType)
                              .toList();
                        }

                        // Wrap ListView.builder in Expanded
                        return ListView.builder(
                          itemCount: filteredClients.length,
                          itemBuilder: (context, index) {
                            final client = filteredClients[index];
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
            ),
          ],
        ),
      ),
    );
  }
}

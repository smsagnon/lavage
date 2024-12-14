import 'package:flutter/material.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../shared/presentation/widgets/app_layout.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Car Wash Manager',
      user: user,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome, ${user.firstname} ${user.lastname}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user.role == 'proprietaire' ? 'Propriétaire' : 'Gérant Principal',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildActionCard(
                      context,
                      icon: Icons.calendar_today,
                      title: 'Appointments',
                      onTap: () {
                        // TODO: Navigate to appointments
                      },
                    ),
                    _buildActionCard(
                      context,
                      icon: Icons.people,
                      title: 'Customers',
                      onTap: () {
                        // TODO: Navigate to customers
                      },
                    ),
                    _buildActionCard(
                      context,
                      icon: Icons.bar_chart,
                      title: 'Statistics',
                      onTap: () {
                        // TODO: Navigate to statistics
                      },
                    ),
                    _buildActionCard(
                      context,
                      icon: Icons.settings,
                      title: 'Settings',
                      onTap: () {
                        // TODO: Navigate to settings
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

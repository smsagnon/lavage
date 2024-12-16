import 'package:flutter/material.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../wash/presentation/screens/new_wash_screen.dart';
import '../../../auth/data/models/user_model.dart';

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({
    super.key,
    required this.user,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(user: widget.user),
      const Center(child: Text('Caisse')), // TODO: Implement Caisse screen
      NewWashScreen(user: widget.user),
      const BoutiqueScreen(), // Boutique screen placeholder
      const MaterielsScreen(), // Materiels screen placeholder
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Caisse',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_car_wash),
            label: 'Lavage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Boutique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Materiels',
          ),
        ],
      ),
    );
  }
}

class BoutiqueScreen extends StatelessWidget {
  const BoutiqueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Boutique')),
      body: const Center(child: Text('Boutique Screen')),
    );
  }
}

class MaterielsScreen extends StatelessWidget {
  const MaterielsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Materiels')),
      body: const Center(child: Text('Materiels Screen')),
    );
  }
}

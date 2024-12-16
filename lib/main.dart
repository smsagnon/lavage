import 'package:car_wash_app/features/client/presentation/screens/client_screen.dart';
import 'package:car_wash_app/features/employee/presentation/screens/employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/registration_stepper_screen.dart';
import 'features/auth/presentation/screens/forgot_password_screen.dart';
import 'features/navigation/presentation/screens/main_screen.dart';
import 'features/auth/data/models/user_model.dart';
import 'features/wash/presentation/bloc/wash_bloc.dart';
import 'features/employee/presentation/bloc/employee_bloc.dart';
import 'features/client/presentation/bloc/client_bloc.dart';

void main() {
  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegistrationStepperScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        final user = state.extra as User;
        return MainScreen(user: user);
      },
    ),
    GoRoute(
      path: '/employees',
      builder: (context, state) {
        final user = state.extra as User;
        return EmployeeScreen(user: user);
      }, 
    ),
    GoRoute(
        path: '/clients',
        builder: (context, state) {
          final user = state.extra as User;
          return ClientScreen(
              user: user); 
        }),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => WashBloc()),
        BlocProvider(create: (context) => EmployeeBloc()),
        BlocProvider(create: (context) => ClientBloc()),
      ],
      child: MaterialApp.router(
        title: 'Car Wash App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00B4D8)),
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}

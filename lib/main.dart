import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'HomeScreen.dart';
import 'Models/OrderModel.dart';
import 'Models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51LrDO4Gi9PXHjIudRaKezIkRWLeUfUePUlHj5AGnZY0HhGOfdoQgIT1BkuPIm6fpgtKt9iFkbeLkCIbNAC1Tk0cQ00CQdFkoBD';
  await Stripe.instance.applySettings();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => Order(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: HomeScreen()),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:moovlah_user/wrapper.dart';
import 'package:provider/provider.dart';


import 'Models/OrderModel.dart';
import 'Models/models.dart';
import 'Service/auth.dart';

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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: StreamProvider<UserAuth?>.value(
            value: AuthServices().user,
            initialData: null,
            child: const Wrapper(),
          ),
        ));
  }
}

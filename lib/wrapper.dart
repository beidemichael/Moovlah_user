import 'package:flutter/material.dart';
import 'package:moovlah_user/Login/ChoiseScreen.dart';
import 'package:provider/provider.dart';
import 'Models/models.dart';
import 'Screens/1,BaseScreen.dart';
import 'Service/Database.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuth?>(context);

    return StreamProvider<List<UserInformation>>.value(
        value: DatabaseService(userUid: user?.uid).userInfo,
        initialData: const [],
        child: user == null
            ? const ChoiceScreen()
            : StreamProvider<List<Vehicles>>.value(
                value: DatabaseService().vehicles,
                initialData: const [],
                catchError: (_, __) => [],
                child: const BaseScreen()));
  }
}

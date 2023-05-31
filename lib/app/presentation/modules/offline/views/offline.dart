import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../domain/repositories/connectivity_repository.dart';
import '../../../routes/routes.dart';
import '../../../service_locator/service_locator.dart';

class OfflineView extends StatefulWidget {
  const OfflineView({super.key});

  @override
  State<OfflineView> createState() => _OfflineViewState();
}

class _OfflineViewState extends State<OfflineView> {
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();

    _streamSubscription = ServiceLocator.instance
        .find<ConnectivityRepository>()
        .onInternetChanged
        .listen(
      (connected) {
        if (connected) {
          Navigator.pushReplacementNamed(context, Routes.splash);
        }
      },
    );
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Estás OFFLINE'),
      ),
    );
  }
}

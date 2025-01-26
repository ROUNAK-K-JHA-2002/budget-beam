// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkAwareScreen extends StatefulWidget {
  const NetworkAwareScreen({super.key});

  @override
  _NetworkAwareScreenState createState() => _NetworkAwareScreenState();
}

class _NetworkAwareScreenState extends State<NetworkAwareScreen> {
  late Stream<ConnectivityResult> _connectivityStream;

  @override
  void initState() {
    super.initState();
    _connectivityStream =
        Connectivity().onConnectivityChanged.cast<ConnectivityResult>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Aware Screen'),
      ),
      body: StreamBuilder<ConnectivityResult>(
        stream: _connectivityStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            if (snapshot.data == ConnectivityResult.none) {
              // No Internet Connection
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off, size: 100, color: Colors.red),
                    SizedBox(height: 20),
                    Text(
                      'No Internet Connection',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              );
            } else {
              // Connected
              return const Center(
                child: Text(
                  'Connected to the Internet',
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
              );
            }
          } else {
            // Error
            return const Center(
              child: Text(
                'Unable to determine connectivity status.',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            );
          }
        },
      ),
    );
  }
}

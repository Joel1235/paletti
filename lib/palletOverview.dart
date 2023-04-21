// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import 'navBar.dart';

class PalletOverview extends StatefulWidget {
  const PalletOverview({super.key});

  @override
  _dashboard createState() => _dashboard();
}

class _dashboard extends State<PalletOverview> {
  bool _isDrawerOpen = true; // Standardmäßig geöffnet in der Webansicht

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
          title: const Text('Dashboard'),
          leading: isMobile
              ? IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    setState(() {
                      _isDrawerOpen = !_isDrawerOpen;
                    });
                  },
                )
              : null),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SizedBox(height: 40), Text('Dashboard works')],
        ),
      ),
    );
  }

  Future submitPallets() {
    throw UnimplementedError();
  }
}

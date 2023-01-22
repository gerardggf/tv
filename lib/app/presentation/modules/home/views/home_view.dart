import 'package:flutter/material.dart';

import '../widgets/trending_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            SizedBox(
              height: 10,
            ),
            TrendingList(),
          ],
        ),
      ),
    );
  }
}

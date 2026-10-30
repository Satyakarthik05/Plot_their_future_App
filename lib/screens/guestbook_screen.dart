import 'package:flutter/material.dart';
import '../widgets/wall_of_blessings.dart';

class GuestbookScreen extends StatelessWidget {
  const GuestbookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          WallOfBlessingsWidget(),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

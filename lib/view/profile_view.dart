import 'package:flutter/material.dart';

void main() => runApp(const ProfileView());

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _HomepageState();
}

class _HomepageState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Center(child: const Text("Profile View"));
  }
}

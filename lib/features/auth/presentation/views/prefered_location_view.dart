import 'package:flutter/material.dart';
import 'package:jobsque/features/auth/presentation/widgets/prefered_location_content.dart';

class PreferedLocationView extends StatefulWidget {
  const PreferedLocationView({super.key});

  @override
  State<PreferedLocationView> createState() => _PreferedLocationViewState();
}

class _PreferedLocationViewState extends State<PreferedLocationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: PreferedLocationContent()));
  }
}

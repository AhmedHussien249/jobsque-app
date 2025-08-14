import 'package:flutter/material.dart';
import 'package:jobsque/core/utils/app_styles.dart';

class JobDetailBottom extends StatelessWidget {
  const JobDetailBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff3366FF),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {},
        child:  Text("Apply Now",style: AppStyles.medium16.copyWith(color: Colors.white),),
      ),
    );
  }
}

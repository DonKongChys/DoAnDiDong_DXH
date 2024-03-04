

import 'package:TShop/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Column(
          children: [
            ///Header
            TPrimaryHeaderContainer(child: Column(
              children: [
                // Text(data)
              ],
            ))
            ///Body
          ],
        )
      ),
    );
  }
}
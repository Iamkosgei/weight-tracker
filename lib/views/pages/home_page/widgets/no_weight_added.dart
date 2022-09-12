import 'package:fitness/configs/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoWeightAdded extends StatelessWidget {
  const NoWeightAdded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 260,
            child: SvgPicture.asset(
              Assets.empty,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'No weight added, please click on the add (+) Icon to add',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

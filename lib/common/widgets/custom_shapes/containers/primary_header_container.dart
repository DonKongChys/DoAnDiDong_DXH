import "package:TShop/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart";
import "package:TShop/utils/constants/colors.dart";
import "package:flutter/material.dart";

import "circular_container.dart";

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        color: TColors.primary,
        // padding: const EdgeInsets.only(bottom: 0),
        child: Stack(
          children: [
            /// -- Background Custom Shapes
            Positioned(
                top: -150,
                right: -250,
                child: TCircularContainer(
                    backgroundColor: TColors.textWhite.withOpacity(0.1))),
            Positioned(
                top: 100,
                right: -300,
                child: TCircularContainer(
                    backgroundColor: TColors.textWhite.withOpacity(0.1))),
            child,
          ],
        ),
      ),
    );
  }
}

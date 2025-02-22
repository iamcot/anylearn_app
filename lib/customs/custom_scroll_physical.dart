// import 'package:flutter/material.dart';

// class CustomScrollPhysics extends ScrollPhysics {
//   final double itemDimension;

//   CustomScrollPhysics({required this.itemDimension, required ScrollPhysics parent}) : super(parent: parent);

//   // @override
//   // CustomScrollPhysics applyTo(ScrollPhysics ancestor) {
//   //   return CustomScrollPhysics(itemDimension: itemDimension, parent: buildParent(ancestor));
//   // }

//   double _getPage(ScrollPosition position) {
//     return position.pixels / itemDimension;
//   }

//   double _getPixels(double page) {
//     return page * itemDimension;
//   }

//   double _getTargetPixels(ScrollPosition position, Tolerance tolerance, double velocity) {
//     double page = _getPage(position);
//     if (velocity < -tolerance.velocity) {
//       page -= 1.0;
//     } else if (velocity > tolerance.velocity) {
//       page += 1.0;
//     }
//     return _getPixels(page.roundToDouble());
//   }

//   @override
//   Simulation createBallisticSimulation(ScrollMetrics position, double velocity) {
//     // If we're out of range and not headed back in range, defer to the parent
//     // ballistics, which should put us back in range at a page boundary.
//     if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
//         (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
//       return super.createBallisticSimulation(position, velocity);
//     final Tolerance tolerance = this.tolerance;
//     final double target = _getTargetPixels(position, tolerance, velocity);
//     if (target != position.pixels)
//       return ScrollSpringSimulation(spring, position.pixels, target, velocity, tolerance: tolerance);
//     return null;
//   }

//   @override
//   bool get allowImplicitScrolling => false;
// }

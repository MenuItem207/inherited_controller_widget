import 'package:flutter/material.dart';
import 'package:inherited_controller_widget/inherited_controller_widget.dart';

/// the controller stored within [InheritedControllerWidget]
abstract class InheritedSubController {
  /// override this function to initialise the [InheritedSubController]
  Future init() async {}

  /// returns the controller of type [T]
  static T getController<T extends InheritedSubController>(
    BuildContext context,
  ) {
    return InheritedControllerWidget.getController(context);
  }
}

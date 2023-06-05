import 'package:inherited_controller_widget/src/inherited_sub_controller.dart';

/// controller that handles [InheritedControllerWidget]
class InheritedController {
  InheritedController({
    required this.subControllersList,
  });

  /// call this function in main()
  Future init() async {
    for (InheritedSubController subController in subControllersList) {
      await subController.init();
      subControllersMap[subController.runtimeType] =
          subController; // fill up map
    }
  }

  /// a Map of controllers to store your inherited controllers in
  final List<InheritedSubController> subControllersList;

  /// maps the [Type] of [InheritedSubController] to the [InheritedSubController] instance
  final Map<dynamic, InheritedSubController> subControllersMap = {};
}

import 'package:inherited_controller_widget/src/inherited_sub_controller.dart';

/// controller that handles [InheritedControllerWidget]
class InheritedController {
  const InheritedController({
    required this.subControllers,
  });

  /// call this function in main()
  Future init() async {
    List<InheritedSubController> subControllersList =
        subControllers.values.toList();
    for (InheritedSubController subController in subControllersList) {
      await subController.init();
    }
  }

  /// a Map of controllers to store your inherited controllers in
  final Map<dynamic, InheritedSubController> subControllers;
}

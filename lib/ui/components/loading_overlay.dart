import 'package:flutter/material.dart';

import '../ui.dart';

class LoadingOverlay extends StatefulWidget {
  final Widget child;

  const LoadingOverlay({Key? key, required this.child}) : super(key: key);

  static _LoadingOverlayState of(BuildContext context) {
    final result = context.findAncestorStateOfType<_LoadingOverlayState>();
    if (result == null) throw const PresenterNotFound();
    return result;
  }

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedLoadingOverlay(
      loadingOverlayState: this,
      child: Stack(
        children: [
          widget.child,
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Visibility(
                visible: controller.value != 0,
                child: Opacity(
                  opacity: controller.value,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: black.withOpacity(0.7),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  TickerFuture close() {
    if (controller.isAnimating) {
      controller.stop();
      return controller.reverse();
    }

    return controller.reverse();
  }

  TickerFuture open() {
    if (controller.isAnimating) {
      controller.stop();
      return controller.forward();
    }

    return controller.forward();
  }

  bool get isOpen => controller.isCompleted;
}

class _InheritedLoadingOverlay extends InheritedWidget {
  final _LoadingOverlayState loadingOverlayState;

  const _InheritedLoadingOverlay({
    Key? key,
    required this.loadingOverlayState,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedLoadingOverlay oldWidget) {
    return oldWidget.loadingOverlayState != loadingOverlayState;
  }
}

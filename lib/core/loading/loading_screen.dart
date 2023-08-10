import 'package:cookain/core/config/theme.dart';
import 'package:flutter/material.dart';

part 'loading_controller.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;

  bool canPop = true;

  LoadingScreenController? controller;

  void show({
    required BuildContext context,
  }) {
    canPop = false;
    controller = showOverlay(
      context: context,
    );
  }

  void hide() {
    canPop = true;
    controller?.close();
    controller = null;
  }

  LoadingScreenController showOverlay({
    required BuildContext context,
  }) {

    final OverlayState state = Overlay.of(context);
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (_) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: MyShapes.circularBorderRadius,
              ),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: MyShapes.padding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(height: 10),
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    state.insert(overlay);

    return LoadingScreenController(
      close: () {
        overlay.remove();
        return true;
      },
      update: (text) {
        return true;
      },
    );
  }
}
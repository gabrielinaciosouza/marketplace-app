import 'package:flutter/material.dart';

import '../ui.dart';

mixin LoadingManager {
  void handleLoading(BuildContext context, Stream<bool> stream) {
    bool previous = false;
    stream.listen(
      (isLoading) {
        if (isLoading) {
          LoadingOverlay.of(context).open();
        } else if (previous && !isLoading) {
          LoadingOverlay.of(context).close();
        }
        previous = isLoading;
      },
    );
  }
}

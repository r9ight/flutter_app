import 'package:flutter/material.dart';

import '../audio/prompt_audio_controller.dart';
import '../navigation/app_route_observer.dart';

class ScreenAudioWrapper extends StatefulWidget {
  const ScreenAudioWrapper({
    super.key,
    required this.audioAsset,
    required this.child,
  });

  final String audioAsset;
  final Widget child;

  @override
  State<ScreenAudioWrapper> createState() => _ScreenAudioWrapperState();
}

class _ScreenAudioWrapperState extends State<ScreenAudioWrapper>
    with RouteAware {
  ModalRoute<dynamic>? _route;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      PromptAudioController.instance.play(widget.audioAsset);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final ModalRoute<dynamic>? route = ModalRoute.of(context);
    if (_route == route) {
      return;
    }

    if (_route != null) {
      appRouteObserver.unsubscribe(this);
    }

    _route = route;
    if (route != null) {
      appRouteObserver.subscribe(this, route);
    }
  }

  @override
  void didPopNext() {
    PromptAudioController.instance.play(widget.audioAsset);
  }

  @override
  void dispose() {
    if (_route != null) {
      appRouteObserver.unsubscribe(this);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

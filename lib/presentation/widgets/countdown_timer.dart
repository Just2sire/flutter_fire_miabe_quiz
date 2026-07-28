import "dart:async";
import "package:flutter/material.dart";

class CountdownTimerController {
  final ValueNotifier<int> remaining = ValueNotifier<int>(0);
  VoidCallback? onFinished;

  Timer? _timer;
  bool _isRunning = false;

  bool get isRunning => _isRunning;

  void start(int seconds) {
    stop();
    remaining.value = seconds;
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void reset(int seconds) {
    start(seconds);
  }

  void stop() {
    _isRunning = false;
    _timer?.cancel();
    _timer = null;
  }

  void _tick() {
    if (remaining.value <= 1) {
      stop();
      remaining.value = 0;
      onFinished?.call();
      return;
    }
    remaining.value--;
  }

  void dispose() {
    stop();
    remaining.dispose();
  }
}

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({required this.controller, super.key, this.style});
  final CountdownTimerController controller;
  final TextStyle? style;

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  @override
  void initState() {
    super.initState();
    widget.controller.remaining.addListener(_onTick);
  }

  void _onTick() {
    if (mounted) {
      setState(() {});
    }
  }

  String _formatDuration(int seconds) {
    final days = seconds ~/ 86400;
    final hours = ((seconds ~/ 3600) % 24).toString().padLeft(2, "0");
    final minutes = ((seconds ~/ 60) % 60).toString().padLeft(2, "0");
    final secs = (seconds % 60).toString().padLeft(2, "0");

    if (days > 0) {
      return "${days}j $hours:$minutes:$secs";
    }
    return "$hours:$minutes:$secs";
  }

  @override
  void dispose() {
    widget.controller.remaining.removeListener(_onTick);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatDuration(widget.controller.remaining.value),
      style:
          widget.style ??
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:wole_app/core/core_view_model/base_view_model.dart';

class BaseViewBuilder<T extends BaseViewModel> extends StatefulWidget {
  final T model;
  final Widget? child;
  final Function(T model)? initState;
  final Widget Function(T, Widget?) builder;

  const BaseViewBuilder({
    Key? key,
    this.child,
    this.initState,
    required this.builder,
    required this.model,
  }) : super(key: key);

  @override
  _BaseViewBuilderState<T> createState() => _BaseViewBuilderState<T>();
}

class _BaseViewBuilderState<T extends BaseViewModel>
    extends State<BaseViewBuilder<T>> {
  @override
  void initState() {
    if (widget.initState != null)
      SchedulerBinding.instance!.addPostFrameCallback(
        (_) => widget.initState!(widget.model),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: widget.model,
      child: Consumer<T>(
        builder: (BuildContext context, value, Widget? child) {
          return widget.builder(value, child);
        },
        child: widget.child,
      ),
    );
  }
}

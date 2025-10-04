import 'package:flutter/cupertino.dart';

class TouchableOpacity extends StatelessWidget {
  const TouchableOpacity({
    super.key,
    required this.child,
    this.onPressed,
    this.padding = EdgeInsets.zero,
    this.alignment = Alignment.center,
    this.pressedOpacity = 0.6,
    this.backgroundColor,
    this.pressedBackgroundColor,
    this.onLongPress,
    this.isLoading,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final EdgeInsets padding;
  final Alignment alignment;
  final Color? backgroundColor;
  final Color? pressedBackgroundColor;
  final bool? isLoading;

  /// The opacity that the button will fade to when it is pressed.
  /// The button will have an opacity of 1.0 when it is not pressed.
  ///
  /// This defaults to 0.4. If null, opacity will not change on pressed if using
  /// your own custom effects is desired.
  final double? pressedOpacity;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onLongPress: isLoading == true ? null : onLongPress,
      onPressed: isLoading == true ? null : onPressed,
      alignment: alignment,
      padding: padding,
      pressedOpacity: isLoading != true ? pressedOpacity : 1.0,
      minimumSize: Size(0, 0),
      child: child,
    );
  }
}

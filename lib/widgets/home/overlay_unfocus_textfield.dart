import 'package:flutter/material.dart';

class OverlayUnfocusTextField extends StatefulWidget {
  const OverlayUnfocusTextField({
    super.key,
    this.initialValue = '',
    required this.onApply,
    this.decoration,
    this.style,
  });

  final String initialValue;
  final ValueChanged<String> onApply;
  final InputDecoration? decoration;
  final TextStyle? style;

  @override
  State<OverlayUnfocusTextField> createState() =>
      _OverlayUnfocusTextFieldState();
}

class _OverlayUnfocusTextFieldState extends State<OverlayUnfocusTextField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  final GlobalKey _fieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      _insertOverlay();
    } else {
      _removeOverlay();
      // apply when losing focus
      widget.onApply(_controller.text);
    }
  }

  void _insertOverlay() {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapDown: (details) {
              final fieldContext = _fieldKey.currentContext;
              if (fieldContext == null) return;
              final box = fieldContext.findRenderObject() as RenderBox?;
              if (box == null) return;
              final local = box.globalToLocal(details.globalPosition);
              if (local.dx < 0 ||
                  local.dy < 0 ||
                  local.dx > box.size.width ||
                  local.dy > box.size.height) {
                _focusNode.unfocus();
              }
            },
            child: const SizedBox.expand(),
          ),
        );
      },
    );

    final overlay = Overlay.of(context);
    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _applyAndUnfocus() {
    widget.onApply(_controller.text);
    _focusNode.unfocus();
  }

  @override
  void dispose() {
    _removeOverlay();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: _fieldKey,
      controller: _controller,
      focusNode: _focusNode,
      decoration: widget.decoration,
      style: widget.style,
      onSubmitted: (_) => _applyAndUnfocus(),
    );
  }
}

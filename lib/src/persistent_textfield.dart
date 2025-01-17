import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistentTextField extends TextField {
  /// Unique identifier for persisting the text value
  final String persistenceId;

  /// Callback when text is persisted
  final Function(String)? onPersist;

  /// Constructor
  PersistentTextField({
    super.key,
    required this.persistenceId,
    this.onPersist,
    TextEditingController? controller,
    String? initialValue,
    super.decoration = null,
    super.keyboardType,
    super.style,
    super.strutStyle,
    super.textDirection,
    super.textAlign,
    super.textAlignVertical,
    super.autofocus,
    super.readOnly,
    super.showCursor,
    super.autocorrect,
    super.enableSuggestions,
    super.maxLines,
    super.minLines,
    super.expands,
    super.maxLength,
    ValueChanged<String>? onChanged,
    super.onEditingComplete,
    super.onSubmitted,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorColor,
    super.selectionHeightStyle,
    super.selectionWidthStyle,
    super.scrollPadding,
    bool super.enableInteractiveSelection = true,
    super.selectionControls,
    super.scrollController,
    super.scrollPhysics,
  }) : super(
          controller: controller ?? TextEditingController(),
          onChanged: (value) {
            _persistValue(persistenceId, value);
            onChanged?.call(value);
            onPersist?.call(value);
          },
        ) {
    _initializeTextField();
  }

  /// Initialize the text field with persisted value
  void _initializeTextField() async {
    final persistedValue = await _getPersistedValue(persistenceId);
    if (persistedValue != null) {
      controller?.text = persistedValue;
    }
  }

  /// Persist text value to SharedPreferences
  static Future<void> _persistValue(String id, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_getKey(id), value);
  }

  /// Get persisted value from SharedPreferences
  static Future<String?> _getPersistedValue(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_getKey(id));
  }

  /// Generate storage key
  static String _getKey(String id) => 'persistent_text_field_$id';

  /// Reset the persisted value for a given ID
  static Future<void> resetPersistedValue(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_getKey(id));
  }
}

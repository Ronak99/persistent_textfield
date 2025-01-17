# persistent_text_field

A Flutter package that extends the standard TextField widget to add persistence capabilities. This package automatically saves and restores text input values using unique identifiers, making it perfect for forms, notes, or any scenario where you need to persist user input across app sessions.

## Features

- 🔄 Automatic persistence of text input
- 🔑 Unique identifier-based storage
- 🔌 Simple drop-in replacement for TextField
- 🎯 Zero configuration required
- 🔄 Reset capability for stored values
- 📱 Works across app restarts

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  persistent_text_field: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:persistent_text_field/persistent_text_field.dart';

PersistentTextField(
  persistenceId: 'user_notes',
  decoration: InputDecoration(
    labelText: 'Notes',
    hintText: 'Enter your notes here',
  ),
)
```

### With Persistence Callback

```dart
PersistentTextField(
  persistenceId: 'user_input',
  decoration: InputDecoration(labelText: 'Input'),
  onPersist: (String value) {
    print('Text was persisted: $value');
  },
)
```

### Resetting Stored Value

```dart
// Reset the stored value for a specific ID
await PersistentTextField.resetPersistedValue('user_input');
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:persistent_text_field/persistent_text_field.dart';

class MyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            PersistentTextField(
              persistenceId: 'user_notes',
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Notes',
                hintText: 'Enter your notes here',
              ),
              onPersist: (value) {
                print('Notes saved: $value');
              },
            ),
            ElevatedButton(
              onPressed: () {
                PersistentTextField.resetPersistedValue('user_notes');
                controller.clear();
              },
              child: Text('Reset Notes'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Properties

The `PersistentTextField` widget includes all properties from the standard Flutter `TextField` widget, plus these additional properties:

- `persistenceId` (required): Unique identifier for storing the text value
- `onPersist`: Optional callback that fires when text is persisted

## How It Works

The package uses `SharedPreferences` to persist text values locally on the device. Each text field's value is stored using a unique key generated from the provided `persistenceId`. The value is automatically restored when the widget is rebuilt.

## Requirements

- Flutter SDK: >=2.12.0
- Dart SDK: >=2.12.0

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Issues and Feedback

Please file specific issues, bugs, or feature requests in our [issue tracker](https://github.com/yourusername/persistent_text_field/issues).

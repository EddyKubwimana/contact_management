import 'package:flutter/material.dart';
import '../services/contact_services';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({Key? key}) : super(key: key);

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  // Controllers for text fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Regular expression to validate phone number (only digits)
  final RegExp phoneRegex = RegExp(r'^[0-9]+$');

  // Method to validate inputs before adding a contact
  bool _validateInputs() {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String phone = _phoneController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty) {
      _showSnackbar('Please enter both first and last names.', Colors.red);
      return false;
    }

    if (phone.isEmpty) {
      _showSnackbar('Please enter a phone number.', Colors.red);
      return false;
    }

    if (!phoneRegex.hasMatch(phone)) {
      _showSnackbar('Phone number must contain only digits.', Colors.red);
      return false;
    }

    if (phone.length < 8 || phone.length > 15) {
      _showSnackbar(
          'Phone number must be between 8 and 15 digits.', Colors.red);
      return false;
    }

    return true;
  }

  // Method to show a Snackbar message
  void _showSnackbar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  // function to add a nwe contact
  Future<void> _addContact() async {
    if (!_validateInputs()) return;

    final String fullName =
        '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}';
    final String phone = _phoneController.text.trim();

    try {
      final response = await ContactService.addContact(fullName, phone);

      // Displaying success message
      _showSnackbar(response, const Color(0xFF2E6E6F));

      // claearing text fields after adding a contact
      _firstNameController.clear();
      _lastNameController.clear();
      _phoneController.clear();
    } catch (e) {
      //  error message
      _showSnackbar('Failed to add contact: $e', Colors.red);
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // First Name Field
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Last Name Field
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Phone Field
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24.0),

            //  Contact Button
            ElevatedButton(
              onPressed: _addContact,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E6E6F),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'Add Contact',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

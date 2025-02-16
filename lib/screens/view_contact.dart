import 'package:flutter/material.dart';
import '../services/contact_services';

class ViewContactScreen extends StatefulWidget {
  final Map<String, dynamic> contact;

  const ViewContactScreen({Key? key, required this.contact}) : super(key: key);

  @override
  _ViewContactScreenState createState() => _ViewContactScreenState();
}

class _ViewContactScreenState extends State<ViewContactScreen> {
  // Controllers for text fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    final fullName = widget.contact['pname'].split(' ');
    _firstNameController.text = fullName[0];
    _lastNameController.text = fullName.length > 1 ? fullName[1] : '';
    _phoneController.text = widget.contact['pphone'];
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Method to update the contact
  Future<void> _updateContact() async {
    final String fullName =
        '${_firstNameController.text} ${_lastNameController.text}';
    final String phone = _phoneController.text;
    final String contactId = widget.contact['pid'].toString();

    // input validation for the edit form
    if (fullName.trim().isEmpty || phone.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Call for the api to update the contact
      final response =
          await ContactService.editContact(fullName, phone, contactId);

      // Notification for success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response),
          backgroundColor: Colors.green,
        ),
      );

      // Exit editing mode of the contact
      setState(() {
        _isEditing = false;
      });
    } catch (e) {
      // Display of error message when the contact fail to update
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update contact: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Method to delete the contact
  Future<void> _deleteContact() async {
    final String contactId = widget.contact['pid'].toString();

    try {
      // Call the API to delete the contact
      final response = await ContactService.deleteContact(contactId);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response ? 'true' : 'false'),
          backgroundColor: response ? Colors.green : Colors.red,
        ),
      );

      // Navigate back to the previous screen
      Navigator.pop(context, true); // Pass true to indicate deletion
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete contact: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Contact' : 'View Contact'),
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Contact Avatar
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF2E6E6F),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),

            // First Name Field
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabled: _isEditing,
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
                enabled: _isEditing,
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
                enabled: _isEditing,
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24.0),

            // Update and Delete Buttons
            if (_isEditing)
              ElevatedButton(
                onPressed: _updateContact,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E6E6F),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Update Contact',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            if (!_isEditing)
              ElevatedButton(
                onPressed: _deleteContact,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Delete Contact',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

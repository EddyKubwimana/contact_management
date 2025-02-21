import 'package:flutter/material.dart';
import 'view_contact.dart';
import '../services/contact_services';

class ContactsListScreen extends StatefulWidget {
  const ContactsListScreen({Key? key}) : super(key: key);

  @override
  _ContactsListScreenState createState() => _ContactsListScreenState();
}

class _ContactsListScreenState extends State<ContactsListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Map<String, dynamic>> _allContacts =
      []; // List to store fetched contacts
  bool _isLoading = true; // To track loading state

  @override
  void initState() {
    super.initState();
    _fetchContacts(); // Fetch contacts when the screen loads
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Fetching contact from ContactService Class
  Future<void> _fetchContacts() async {
    try {
      final contacts = await ContactService.getAllContacts();
      setState(() {
        _allContacts = contacts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching contacts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> searchResults = _searchQuery.isEmpty
        ? []
        : _allContacts
            .where((contact) => contact['pname']
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
            .toList();

    return Scaffold(
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search .....',
                prefixIcon: const Icon(Icons.search),
                enabledBorder: const UnderlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF2E6E6F), width: 2.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF2E6E6F), width: 2.5),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Loading Indicator
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else
            // Search Results or Contact List
            Expanded(
              child: _searchQuery.isEmpty
                  ? _buildContactList()
                  : _buildSearchResults(searchResults),
            ),
        ],
      ),
    );
  }

  // Build the contact list
  Widget _buildContactList() {
    return ListView(
      children: [
        // All Contacts Section
        _buildSectionHeader('Contacts'),
        ..._allContacts.map((contact) => _buildContactTile(contact)).toList(),
      ],
    );
  }

  // Build search results
  Widget _buildSearchResults(List<Map<String, dynamic>> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return _buildContactTile(results[index]);
      },
    );
  }

  // Helper method to build a section header
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2E6E6F),
        ),
      ),
    );
  }

  // Helper method to build a contact tile
  Widget _buildContactTile(Map<String, dynamic> contact) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF2E6E6F),
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          contact['pname'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(contact['pphone']),
        trailing: const Icon(Icons.arrow_forward, color: Color(0xFF2E6E6F)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewContactScreen(contact: contact),
            ),
          ).then((deleted) {
            if (deleted == true) {
              _fetchContacts();
            }
          });
        },
      ),
    );
  }
}

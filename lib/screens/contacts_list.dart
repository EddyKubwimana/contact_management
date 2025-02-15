import 'package:flutter/material.dart';
import 'add_contact.dart';

class ContactsListScreen extends StatefulWidget {
  const ContactsListScreen({Key? key}) : super(key: key);

  @override
  _ContactsListScreenState createState() => _ContactsListScreenState();
}

class _ContactsListScreenState extends State<ContactsListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final List<String> _favorites = [
    'A. Amos Butezi',
    'A. Annie',
    'B. Belyse',
    'D. Desiderata',
    'E. Emily Guard',
    'F. Felix',
    'G. Gilbert',
    'L. London Call',
  ];
  final List<String> _allContacts =
      List.generate(20, (index) => 'Contact ${index + 1}');

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> searchResults = _searchQuery.isEmpty
        ? []
        : _allContacts
            .where((contact) =>
                contact.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    return Scaffold(
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Search Results or Contact List
          Expanded(
            child: _searchQuery.isEmpty
                ? _buildContactList()
                : _buildSearchResults(searchResults),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddContactScreen(),
              settings: const RouteSettings(name: '/add_contact'),
            ),
          );
        },
        backgroundColor: const Color(0xFF2E6E6F),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Build the contact list (favorites + all contacts)
  Widget _buildContactList() {
    return ListView(
      children: [
        // Favorites Section
        _buildSectionHeader('Favorites'),
        ..._favorites.map((contact) => _buildContactTile(contact)).toList(),

        const Divider(height: 1),

        // All Contacts Section
        _buildSectionHeader('All Contacts'),
        ..._allContacts.map((contact) => _buildContactTile(contact)).toList(),
      ],
    );
  }

  // Build search results
  Widget _buildSearchResults(List<String> results) {
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
  Widget _buildContactTile(String name) {
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
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${name.toLowerCase().replaceAll(' ', '')}@example.com'),
        trailing: const Icon(Icons.arrow_forward, color: Color(0xFF2E6E6F)),
        onTap: () {
          // Navigate to edit contact screen
          // Navigator.push(...);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;
  const UserDetailScreen({super.key, required this.user});

  Widget _info(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: const Color(0xFF2256A8)),
          const SizedBox(width: 12),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              const SizedBox(height: 3),
              Text(value, style: const TextStyle(fontSize: 15)),
            ],
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 12),
          CircleAvatar(radius: 37, child: Text(user.name[0], style: const TextStyle(fontSize: 28))),
          const SizedBox(height: 12),
          Text(user.name, textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Card(child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(children: [
              _info('Username', user.username, Icons.person_outline),
              _info('Email', user.email, Icons.email_outlined),
              _info('Phone', user.phone, Icons.phone_outlined),
              _info('Website', user.website, Icons.language_outlined),
            ]),
          )),
          const SizedBox(height: 12),
          Card(child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Address', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              _info('Full address', user.address.fullAddress, Icons.location_on_outlined),
            ]),
          )),
          const SizedBox(height: 12),
          Card(child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Company', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              _info('Company name', user.company.name, Icons.business_outlined),
              _info('Catchphrase', user.company.catchPhrase, Icons.format_quote_outlined),
            ]),
          )),
        ],
      ),
    );
  }
}

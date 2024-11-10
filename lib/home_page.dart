import 'package:flutter/material.dart';
import 'package:todo_list/contact.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  // Define contacts list as List<Contact> with growable list capability
  List<Contact> contacts = List<Contact>.empty(growable: true);

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contacts List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Contact Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: const InputDecoration(
                hintText: 'Contact Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String name = nameController.text.trim();
                    String contact = contactController.text.trim();
                    if (name.isNotEmpty && contact.isNotEmpty) {
                      setState(() {
                        nameController.clear();
                        contactController.clear();
                        contacts.add(Contact(name: name, contact: contact));
                      });
                    }
                  },
                  child: const Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    String name = nameController.text.trim();
                    String contact = contactController.text.trim();
                    if (name.isNotEmpty &&
                        contact.isNotEmpty &&
                        selectedIndex != -1) {
                      setState(() {
                        contacts[selectedIndex].name = name;
                        contacts[selectedIndex].contact = contact;
                        selectedIndex = -1;
                        nameController.clear();
                        contactController.clear();
                      });
                    }
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            contacts.isEmpty
                ? const Text(
                    'No Contact yet..',
                    style: TextStyle(fontSize: 22),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) => getRow(index),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].name[0].toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].contact),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    nameController.text = contacts[index].name;
                    contactController.text = contacts[index].contact;
                    selectedIndex = index;
                  });
                },
                child: const Icon(Icons.edit),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    contacts.removeAt(index);
                  });
                },
                child: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

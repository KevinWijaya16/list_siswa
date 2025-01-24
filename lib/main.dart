import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ListSiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Aplikasi Data Siswa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();

  List<Map<String, String>> students = [];
  int? editIndex;

  void _addOrUpdateStudent() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final classes = _classController.text.trim();
    final major = _majorController.text.trim();

    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        classes.isNotEmpty &&
        major.isNotEmpty) {
      if (editIndex == null) {
        // Tambah data baru
        setState(() {
          students.add({
            'firstName': firstName,
            'lastName': lastName,
            'class': classes,
            'major': major,
          });
        });
        _showAlert('Success', 'Data berhasil ditambahkan!');
      }

      _clearForm();
    } else {
      _showAlert('Error', 'Harap isi semua value!');
    }
  }

  void _editStudent(int index) {
    // Ambil data yang akan diedit dan tampilkan di pop up
    showDialog(
      context: context,
      builder: (context) {
        final editFirstNameController =
            TextEditingController(text: students[index]['firstName']);
        final editLastNameController =
            TextEditingController(text: students[index]['lastName']);
        final editClassController =
            TextEditingController(text: students[index]['class']);
        final editMajorController =
            TextEditingController(text: students[index]['major']);

        return AlertDialog(
          title: const Text('Edit Data Siswa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(editFirstNameController, 'First Name'),
              const SizedBox(height: 10),
              _buildTextField(editLastNameController, 'Last Name'),
              const SizedBox(height: 10),
              _buildTextField(editClassController, 'Class'),
              const SizedBox(height: 10),
              _buildTextField(editMajorController, 'Major'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedFirstName = editFirstNameController.text.trim();
                final updatedLastName = editLastNameController.text.trim();
                final updatedClass = editClassController.text.trim();
                final updatedMajor = editMajorController.text.trim();

                if (updatedFirstName.isNotEmpty &&
                    updatedLastName.isNotEmpty &&
                    updatedClass.isNotEmpty &&
                    updatedMajor.isNotEmpty) {
                  setState(() {
                    students[index] = {
                      'firstName': updatedFirstName,
                      'lastName': updatedLastName,
                      'class': updatedClass,
                      'major': updatedMajor,
                    };
                  });
                  Navigator.of(context).pop();
                  _showAlert('Success', 'Data berhasil diperbarui!');
                } else {
                  _showAlert('Error', 'Harap isi semua value!');
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _deleteStudent(int index) {
    setState(() {
      students.removeAt(index);
    });
    _showAlert('Success', 'Data berhasil dihapus!');
  }

  void _clearForm() {
    _firstNameController.clear();
    _lastNameController.clear();
    _classController.clear();
    _majorController.clear();
    editIndex = null;
  }

  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(80, 137, 169, 127),
        title: const Text(
          'Kevin Apps',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTextField(_firstNameController, 'First Name'),
            const SizedBox(height: 10),
            _buildTextField(_lastNameController, 'Last Name'),
            const SizedBox(height: 10),
            _buildTextField(_classController, 'Classes'),
            const SizedBox(height: 10),
            _buildTextField(_majorController, 'Major'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addOrUpdateStudent,
              child: const Text('Tambah'),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text(
              'List Siswa',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    title:
                        Text('${student['firstName']} ${student['lastName']}'),
                    subtitle: Text(
                        'Class: ${student['class']} | Major: ${student['major']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editStudent(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.red),
                          onPressed: () => _deleteStudent(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.green),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }
}

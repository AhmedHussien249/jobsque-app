import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PortfolioView extends StatefulWidget {
  const PortfolioView({super.key});

  @override
  State<PortfolioView> createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> {
  List<File> files = [];

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        files.add(File(result.files.single.path!));
      });
    }
  }

  void _removeFile(int index) {
    setState(() {
      files.removeAt(index);
    });
  }

  void _replaceFile(int index) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        files[index] = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Portfolio"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Add portfolio here",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

            const SizedBox(height: 12),

            GestureDetector(
              onTap: _pickFile,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue, style: BorderStyle.solid),
                ),
                child: Column(
                  children:  [
                    Icon(Icons.cloud_upload, size: 40, color: Colors.blue),
                    SizedBox(height: 8),
                    Text("Upload your other file"),
                    Text("Max. file size 10 MB",
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: null,
                      icon: Icon(Icons.add),
                      label: Text("Add file"),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = files[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.picture_as_pdf,
                          color: Colors.red, size: 32),
                      title: Text(file.path.split('/').last),
                      subtitle: const Text("CV.pdf 300KB"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _replaceFile(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeFile(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

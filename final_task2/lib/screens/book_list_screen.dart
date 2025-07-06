import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:open_filex/open_filex.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class BookListScreen extends StatefulWidget {
  final String folderName;
  final String extension;
  const BookListScreen({super.key, required this.folderName, required this.extension});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

enum DownloadState { notDownloaded, downloading, downloaded }

class _BookListScreenState extends State<BookListScreen> {
  final SupabaseClient client = Supabase.instance.client;
  final Map<String, DownloadState> _downloadStates = {};
  final Map<String, String> _downloadedPaths = {};
  List<String> files = [];

  @override
  void initState() {
    super.initState();
    listFiles();
  }

  Future<void> listFiles() async {
    try {
      final response = await client.storage.from('documents').list(path: widget.folderName);
      final filtered = response
          .where((f) => f.name.toLowerCase().endsWith(widget.extension))
          .map((f) => f.name)
          .toList();
      setState(() {
        files = filtered;
      });
    } catch (e) {
      print('❌ Error listing files: $e');
    }
  }

  Future<void> downloadFile(String fileName) async {
    setState(() => _downloadStates[fileName] = DownloadState.downloading);
    try {
      final url = client.storage.from('documents').getPublicUrl('${widget.folderName}/$fileName');
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/$fileName');
        await file.writeAsBytes(response.bodyBytes);

        setState(() {
          _downloadStates[fileName] = DownloadState.downloaded;
          _downloadedPaths[fileName] = file.path;
        });
      } else {
        setState(() => _downloadStates[fileName] = DownloadState.notDownloaded);
      }
    } catch (e) {
      print('❌ Download error: $e');
      setState(() => _downloadStates[fileName] = DownloadState.notDownloaded);
    }
  }

  Future<void> openFile(String fileName) async {
    final path = _downloadedPaths[fileName];
    if (path != null) {
      await OpenFilex.open(path);
    }
  }

  Widget _buildTrailing(String fileName) {
    final state = _downloadStates[fileName] ?? DownloadState.notDownloaded;
    switch (state) {
      case DownloadState.notDownloaded:
        return ElevatedButton(
          onPressed: () => downloadFile(fileName),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.blue,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: const Text('GET'),
        );
      case DownloadState.downloading:
        return const Padding(
          padding: EdgeInsets.all(4.0),
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      case DownloadState.downloaded:
        return GestureDetector(
          onTap: () => openFile(fileName),
          child: const Text(
            'OPEN',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        );
    }
  }

  Future<void> uploadBook() async {
    final fileResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [widget.extension.replaceAll('.', '')],
    );

    if (fileResult != null && fileResult.files.single.path != null) {
      final pickedFile = File(fileResult.files.single.path!);
      final fileName = fileResult.files.single.name;

      try {
        await client.storage.from('documents').upload(
          '${widget.folderName}/$fileName',
          pickedFile,
          fileOptions: const FileOptions(upsert: true),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Upload successful')),
        );
        listFiles();
      } catch (e) {
        print('❌ Upload failed: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Upload failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ages ${widget.folderName.replaceAll('Age', '').replaceAll('812', '8-12').replaceAll('48', '4-8').replaceAll('04', '0-4')}'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Image.asset(
              widget.extension == 'docx' ? 'assets/icons/docx_icon.png' : 'assets/icons/pdf_icon.png',
              width: 50,
              height: 50,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final fileName = files[index];
                return ListTile(
                  leading: Image.asset(
                    'assets/pdf_icon.png',
                    width: 40,
                    height: 40,
                    errorBuilder: (_, __, ___) => const Icon(Icons.insert_drive_file),
                  ),
                  title: Text(fileName),
                  trailing: _buildTrailing(fileName),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: uploadBook,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
              child: const Text('Upload Book', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}

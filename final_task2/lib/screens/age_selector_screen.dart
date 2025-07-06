import 'package:flutter/material.dart';
import 'book_list_screen.dart';

class AgeSelectorScreen extends StatelessWidget {
  const AgeSelectorScreen({super.key});

  void navigateToList(BuildContext context, String folder, String extension) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            BookListScreen(folderName: folder, extension: extension),
      ),
    );
  }

  Widget buildAgeCard({
    required BuildContext context,
    required String label,
    required String folder,
    required String fileType, // 'docx' or 'pdf'
    required String imageAsset,
    required String iconAsset,
  }) {
    return GestureDetector(
      onTap: () => navigateToList(context, folder, fileType),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(iconAsset, width: 32),
            const SizedBox(height: 6),
            Flexible(
              child: Image.asset(
                imageAsset,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7FB), // light background
      appBar: AppBar(
        title: const Text("Choose your child's age:"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
          children: [
            buildAgeCard(
              context: context,
              label: 'Ages 0-4',
              folder: 'Age04',
              fileType: 'docx',
              imageAsset: 'assets/images/age04.png',
              iconAsset: 'assets/icons/docx_icon.png',
            ),
            buildAgeCard(
              context: context,
              label: 'Ages 0-4',
              folder: 'Age04',
              fileType: 'pdf',
              imageAsset: 'assets/images/age04.png',
              iconAsset: 'assets/icons/pdf_icon.png',
            ),
            buildAgeCard(
              context: context,
              label: 'Ages 4-8',
              folder: 'Age48',
              fileType: 'docx',
              imageAsset: 'assets/images/age48.png',
              iconAsset: 'assets/icons/docx_icon.png',
            ),
            buildAgeCard(
              context: context,
              label: 'Ages 4-8',
              folder: 'Age48',
              fileType: 'pdf',
              imageAsset: 'assets/images/age48.png',
              iconAsset: 'assets/icons/pdf_icon.png',
            ),
            buildAgeCard(
              context: context,
              label: 'Ages 8-12',
              folder: 'Age812',
              fileType: 'docx',
              imageAsset: 'assets/images/age812.png',
              iconAsset: 'assets/icons/docx_icon.png',
            ),
            buildAgeCard(
              context: context,
              label: 'Ages 8-12',
              folder: 'Age812',
              fileType: 'pdf',
              imageAsset: 'assets/images/age812.png',
              iconAsset: 'assets/icons/pdf_icon.png',
            ),
          ],
        ),
      ),
    );
  }
}

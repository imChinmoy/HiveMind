import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config/core/custom_loader.dart';
import 'package:frontend/config/core/custom_textfield.dart';
import 'package:frontend/config/core/toast.dart';
import 'package:frontend/config/themes/app_textstyle.dart';
import 'package:frontend/features/server/presentation/state/explore_notifier.dart';
import 'package:image_picker/image_picker.dart';

class AddServerScreen extends ConsumerStatefulWidget {
  const AddServerScreen({super.key});

  @override
  ConsumerState<AddServerScreen> createState() => _AddServerScreenState();
}

class _AddServerScreenState extends ConsumerState<AddServerScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  File? selectedImage;
  bool isCreating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Create Server", style: AppTextStyles.appbarHeading),
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              _header(),
              const SizedBox(height: 30),
              _avatarPicker(),
              const SizedBox(height: 30),
              _inputSection(),
              const SizedBox(height: 30),
              _createButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        Text(
          "Create Your Own Server",
          style: AppTextStyles.heading,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          "A server for you and your friends to grow and learn together!",
          style: AppTextStyles.messageText,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _avatarPicker() {
    return GestureDetector(
      onTap: () async {
        final file = await uploadImage();
        if (file.path.isNotEmpty) {
          setState(() => selectedImage = file);
        }
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: selectedImage != null
                ? FileImage(selectedImage!)
                : null,
            child: selectedImage == null
                ? const Icon(Icons.groups_rounded, size: 50)
                : null,
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _inputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Server Name', style: AppTextStyles.hint),
        const SizedBox(height: 6),
        CustomTextField(hint: 'Enter server name', controller: nameController),
        const SizedBox(height: 20),
        Text('Description', style: AppTextStyles.hint),
        const SizedBox(height: 6),
        CustomTextField(
          hint: 'Tell people what this server is about',
          controller: descriptionController,
        ),
      ],
    );
  }

  Widget _createButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isCreating
            ? null
            : () async {
                if (nameController.text.trim().isEmpty ||
                    selectedImage == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Name and avatar are required"),
                    ),
                  );
                  return;
                }

                setState(() => isCreating = true);

                await ref
                    .read(exploreServersProvider.notifier)
                    .createServer(
                      name: nameController.text.trim(),
                      description: descriptionController.text.trim(),
                      avatar: selectedImage!,
                    );

                setState(() => isCreating = false);

                if (mounted) {
                  ToastHelper.showSuccess(
                    context,
                    "Server created successfully",
                  );
                  Navigator.popUntil(context, (route) => route.isFirst);
                }
              },
        child: isCreating ? const CustomLoader() : const Text("Create Server"),
      ),
    );
  }
}

Future<File> uploadImage() async {
  final ImagePicker picker = ImagePicker();

  try {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
  } catch (e) {
    log(e.toString());
  }

  return File('');
}

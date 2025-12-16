import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // مكتبة اختيار الصور
import 'package:provider/provider.dart';
import '../../view_models/admin_provider.dart';
import '../widgets/custom_text_field.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final uniIdCtrl = TextEditingController();
  
  File? _selectedImage; // متغير لتخزين الصورة

  // دالة اختيار الصورة
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تسجيل طالب جديد")),
      body: Consumer<AdminProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // --- جزء اختيار الصورة ---
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
                      child: _selectedImage == null
                          ? const Icon(Icons.add_a_photo, size: 40, color: Colors.grey)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("اضغط لإضافة صورة الوجه (مطلوب)", style: TextStyle(color: Colors.red)),
                  
                  const SizedBox(height: 20),
                  CustomTextField(controller: nameCtrl, label: "الاسم كامل (Name)", icon: Icons.person),
                  CustomTextField(controller: emailCtrl, label: "الإيميل (Email)", icon: Icons.email),
                  CustomTextField(controller: passCtrl, label: "كلمة المرور", icon: Icons.lock, isPassword: true),
                  CustomTextField(controller: uniIdCtrl, label: "الرقم الجامعي (University ID)", icon: Icons.badge),

                  const SizedBox(height: 30),

                  provider.isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_selectedImage == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("يجب اختيار صورة للطالب!")));
                                  return;
                                }
                                provider.registerStudent(
                                  name: nameCtrl.text,
                                  email: emailCtrl.text,
                                  password: passCtrl.text,
                                  universityId: uniIdCtrl.text,
                                  imageFile: _selectedImage!, // إرسال الصورة
                                  context: context,
                                );
                              }
                            },
                            child: const Text("حفظ بيانات الطالب"),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
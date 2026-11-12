import 'package:flutter/material.dart';
import '../models/saved_ormawa_model.dart';

class EditSavedOrmawaScreen extends StatefulWidget {
  final SavedOrmawaModel savedOrmawa;

  const EditSavedOrmawaScreen({super.key, required this.savedOrmawa});

  @override
  State<EditSavedOrmawaScreen> createState() => _EditSavedOrmawaScreenState();
}

class _EditSavedOrmawaScreenState extends State<EditSavedOrmawaScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _divisionController;
  late TextEditingController _noteController;
  late int _priority;

  @override
  void initState() {
    super.initState();
    _divisionController = TextEditingController(text: widget.savedOrmawa.targetDivision);
    _noteController = TextEditingController(text: widget.savedOrmawa.note);
    _priority = widget.savedOrmawa.priority;
  }

  @override
  void dispose() {
    _divisionController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _updateForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perubahan berhasil disimpan')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Catatan Ormawa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.savedOrmawa.ormawaName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _divisionController,
                decoration: const InputDecoration(
                  labelText: 'Divisi / Bidang yang Diminati',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Divisi wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                initialValue: _priority,
                decoration: const InputDecoration(
                  labelText: 'Tingkat Prioritas',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 1, child: Text('1 - Sangat Rendah')),
                  DropdownMenuItem(value: 2, child: Text('2 - Rendah')),
                  DropdownMenuItem(value: 3, child: Text('3 - Sedang')),
                  DropdownMenuItem(value: 4, child: Text('4 - Tinggi')),
                  DropdownMenuItem(value: 5, child: Text('5 - Prioritas Utama')),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _priority = val);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Catatan / Motivasi',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().length < 5) {
                    return 'Catatan minimal 5 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _updateForm,
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Simpan Perubahan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D47A1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
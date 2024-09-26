// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toby_flutter/providers/app_state.dart';
import 'package:toby_flutter/services/CollectionService.dart';

class UpdateCollectionState extends StatefulWidget {
  final Map<String, dynamic>?
      collection; // البيانات الحالية للمجموعة إذا كانت موجودة

  const UpdateCollectionState({super.key, this.collection});

  @override
  _UpdateCollectionStateState createState() => _UpdateCollectionStateState();
}

class _UpdateCollectionStateState extends State<UpdateCollectionState> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late final CollectionService _collectionService;
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    _collectionService =
        CollectionService(Provider.of<AppState>(context, listen: false));
    if (widget.collection != null) {
      isEdit = true;
      title = widget.collection!['title'];
      description = widget.collection!['description'];
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        if (isEdit) {
          // تعديل المجموعة الحالية
          await _collectionService.updateCollection(
              widget.collection!['id'], title, description);

          // عرض رسالة النجاح
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم التعديل بنجاح!'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          // إنشاء مجموعة جديدة
          await _collectionService.createCollection(title, description);

          // عرض رسالة النجاح
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم إنشاء المجموعة بنجاح!'),
              backgroundColor: Colors.green,
            ),
          );
        }
        Navigator.pop(context, true);
      } catch (e) {
        // في حالة حدوث خطأ
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Collection' : 'Add Collection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) {
                  title = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  description = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(isEdit ? 'Update Collection' : 'Create Collection'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

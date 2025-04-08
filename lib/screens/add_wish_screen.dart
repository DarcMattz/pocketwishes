import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../models/wish.dart';
import '../helpers/wish_storage.dart';

class AddWishScreen extends StatefulWidget {
  @override
  _AddWishScreenState createState() => _AddWishScreenState();
}

class _AddWishScreenState extends State<AddWishScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  double _price = 0;
  File? _image;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _image = File(picked.path));
  }

  void _saveWish() async {
    if (_formKey.currentState?.validate() != true) return;
    _formKey.currentState!.save();

    final newWish = Wish(
      id: Uuid().v4(),
      title: _title,
      description: _description,
      price: _price,
      imagePath: _image?.path,
    );

    final wishes = await WishStorage.loadWishes();
    wishes.add(newWish);
    await WishStorage.saveWishes(wishes);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Wish")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) =>
                    _price = double.tryParse(value ?? '0') ?? 0,
              ),
              SizedBox(height: 12),
              _image == null
                  ? Text('No image selected.')
                  : Image.file(_image!, height: 150),
              TextButton.icon(
                icon: Icon(Icons.image),
                label: Text("Pick Image"),
                onPressed: _pickImage,
              ),
              ElevatedButton(
                onPressed: _saveWish,
                child: Text("Save Wish"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

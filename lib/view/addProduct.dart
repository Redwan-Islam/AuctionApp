import 'package:auctionapp/constructor/dbHelper.dart';
import 'package:auctionapp/constructor/showMsg.dart';
import 'package:auctionapp/model/productModel.dart';
import 'package:auctionapp/provider/productProvider.dart';
import 'package:auctionapp/view/dashScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class addproduct extends StatefulWidget {
  addproduct({Key? key}) : super(key: key);

  @override
  State<addproduct> createState() => _addproductState();
}

// ignore: camel_case_types
class _addproductState extends State<addproduct> {
  late ProductProvider _productProvider;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? dateTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _productProvider = Provider.of<ProductProvider>(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        actions: [IconButton(onPressed: _saveProduct, icon: Icon(Icons.done))],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(12.0),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Product Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ShowErrorMsg;
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(hintText: 'Product Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ShowErrorMsg;
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(hintText: 'Product price'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ShowErrorMsg;
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: _showDatePickedDialog,
                      child: const Text('Select Date'),
                    ),
                    Text(dateTime == null
                        ? 'No Date Found'
                        : DateFormat('dd/MM/yyyy').format(dateTime!))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, dashScreen.routeNames);
                },
                child: const Text('Back to DashScreen')),
          ],
        ),
      ),
    );
  }

  void _showDatePickedDialog() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime.now());

    if (selectedDate != null) {
      setState(() {
        dateTime = selectedDate;
      });
    }
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      final productModel = ProductModel(
        year: dateTime!.year,
        month: dateTime!.month,
        day: dateTime!.day,
        productTimestamp: Timestamp.fromDate(dateTime!),
        name: _nameController.text,
        description: _descriptionController.text,
        price: num.parse(_priceController.text),
      );
      Provider.of<ProductProvider>(context, listen: false)
          .saveProduct(productModel)
          .then((value) {
        setState(() {
          _nameController.text = '';
          _descriptionController.text = '';
          _priceController.text = '';
          dateTime = null;
        });
        const Center(child: Text('Saved'));
      }).catchError((error) {});
    }
  }
}

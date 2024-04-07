import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import './../screens.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  EditProductScreen(
    Product? product, {
    super.key,
  }) {
    if (product == null) {
      this.product = Product(
        id: null,
        title: '',
        price: 0,
        description: '',
        imageUrl: '',
      );
    } else {
      this.product = product;
    }
  }
  late final Product product;
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late Product _editedProduct;
  var _isLoading = false;
  bool _isValidImageUrl(String value) {
    return (value.startsWith('asset') || value.startsWith('asset')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('.jpeg'));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        setState(() {});
      }
    });
    _editedProduct = widget.product;
    _imageUrlController.text = _editedProduct.imageUrl;
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }

    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final productsManager = context.read<ProductsManager>();
      if (_editedProduct.id != null) {
        productsManager.updateProduct(_editedProduct);
      } else {
        productsManager.addProduct(_editedProduct);
      }
    } catch (error) {
      await showErrorDialog(context, 'Something  went wrong.');
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chỉnh sửa giày',
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              size: 35,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Container(
        color: Colors.teal[50],
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _editForm,
                  child: ListView(
                    children: <Widget>[
                      _buildProductPreview(),
                      const SizedBox(height: 20),
                      _buildImageURRLField(),
                      const SizedBox(height: 10),
                      _buildTitleField(),
                      const SizedBox(height: 10),
                      _buildPriceField(),
                      const SizedBox(height: 10),
                      _buildDescriptionField(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  TextFormField _buildTitleField() {
    return TextFormField(
      initialValue: _editedProduct.title,
      decoration: InputDecoration(
        labelText: 'Tên giày',
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(title: value);
      },
    );
  }

  TextFormField _buildPriceField() {
    return TextFormField(
      initialValue: _editedProduct.price.toString(),
      decoration: InputDecoration(
        labelText: 'Giá',
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a price.';
        }

        if (double.tryParse(value) == null) {
          return 'Please enter a valid number.';
        }

        if (double.parse(value) <= 0) {
          return 'Please enter a number greater than zero.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(price: double.parse(value!));
      },
    );
  }

  TextFormField _buildDescriptionField() {
    return TextFormField(
      initialValue: _editedProduct.description,
      decoration: InputDecoration(
        labelText: 'Mô tả',
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a description.';
        }

        if (value.length < 10) {
          return 'Should be at least 10 characters long.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(description: value);
      },
    );
  }

  Widget _buildProductPreview() {
    return Container(
      width: double.infinity,
      height: 300,
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: _imageUrlController.text.isEmpty
          ? const Center(child: Text('Enter a URL'))
          : FittedBox(
              child: Image.asset(
                _imageUrlController.text,
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  TextFormField _buildImageURRLField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Hình ảnh',
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an image URL';
        }
        if (!_isValidImageUrl(value)) {
          return 'Please enter a valid image URL.';
        }

        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(imageUrl: value);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping/provider/product.dart';
import 'package:provider/provider.dart';
import 'package:shopping/provider/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-screen';
  EditProductScreen({Key key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _edittedProduct = Product(
    id: '',
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '',
  );
  var _initialValues = {
    'title': '',
    'desciption': '',
    'price': '',
    'imageUrl': '',
  };

  var _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;

      if (productId != null) {
        _edittedProduct = Provider.of<Products>(context).findById(productId);
        _initialValues = {
          'title': _edittedProduct.title,
          'description': _edittedProduct.description,
          'price': _edittedProduct.price.toString(),
          //'imageUrl': _edittedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _edittedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          (!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('png') &&
              !_imageUrlController.text.endsWith('jpg') &&
              !_imageUrlController.text.endsWith('jpeg'))) return;

      {
        setState(() {});
      }
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    _form.currentState.save();
    if (_edittedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_edittedProduct.id, _edittedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_edittedProduct);
    }

    Navigator.of(context).pop();

    print(_edittedProduct.title);
    print(_edittedProduct.description);
    print(_edittedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save)),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                initialValue: _initialValues['title'],
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter the value';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  _edittedProduct = Product(
                      id: _edittedProduct.id,
                      isFavorite: _edittedProduct.isFavorite,
                      title: newValue,
                      description: _edittedProduct.description,
                      price: _edittedProduct.price,
                      imageUrl: _edittedProduct.imageUrl);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                initialValue: _initialValues['price'],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter something';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter the valid number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Value cannot be zero or less than zero';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  _edittedProduct = Product(
                      id: _edittedProduct.id,
                      isFavorite: _edittedProduct.isFavorite,
                      title: _edittedProduct.title,
                      description: _edittedProduct.description,
                      price: double.parse(newValue),
                      imageUrl: _edittedProduct.imageUrl);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Desciption',
                ),
                initialValue: _initialValues['description'],
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a value';
                  }
                  if (value.length < 10) {
                    return 'Description cannot be less than 10 characters';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  _edittedProduct = Product(
                      id: _edittedProduct.id,
                      isFavorite: _edittedProduct.isFavorite,
                      title: _edittedProduct.title,
                      description: newValue,
                      price: _edittedProduct.price,
                      imageUrl: _edittedProduct.imageUrl);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(right: 10, top: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        )),
                    child: _imageUrlController.text.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Enter the URL',
                              textAlign: TextAlign.center,
                            ),
                          )
                        : FittedBox(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.contain,
                                height: 100,
                                width: 100,
                              ),
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Image URL',
                      ),
                      //initialValue: _initialValues['imageUrl'],
                      focusNode: _imageUrlFocusNode,
                      keyboardType: TextInputType.url,
                      controller: _imageUrlController,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) => _saveForm(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the image URL';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Please enter the valid URL';
                        }
                        if (!value.endsWith('png') &&
                            !value.endsWith('jpg') &&
                            !value.endsWith('jpeg')) {
                          return 'It is not an image';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) {
                        _edittedProduct = Product(
                            id: _edittedProduct.id,
                            isFavorite: _edittedProduct.isFavorite,
                            title: _edittedProduct.title,
                            description: _edittedProduct.description,
                            price: _edittedProduct.price,
                            imageUrl: newValue);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

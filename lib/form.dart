import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Store/db/helper.dart';
import 'package:Store/db/model.dart';

class ProductForm extends StatefulWidget {
  ProductForm();
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  String description = "";
  int pid;
  String pName, brand, model, size;
  double price;
  int stock;
  List productImage = ["", "", ""];
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  DatabaseHelper databaseHelper = DatabaseHelper();
  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(value)));
  }

  selectImage(int index) async {
    final picked = await picker.getImage(source: ImageSource.gallery);
    final bytes = File(picked.path).readAsBytesSync();
    setState(() {
      productImage[index] = base64Encode(bytes);
      print(productImage[index]);
    });
  }

  void deleteImage(int index) {
    if (index == 2) {
      setState(() {
        productImage[index] = "";
      });
    } else if (index == 1) {
      if (productImage[index + 1].length > 0) {
        setState(() {
          productImage[index] = productImage[index + 1];
          productImage[index + 1] = "";
        });
      } else {
        setState(() {
          productImage[index] = "";
        });
      }
    } else {
      if (productImage[index + 1].length > 0) {
        if (productImage[index + 2].length > 0) {
          setState(() {
            productImage[index] = productImage[index + 1];
            productImage[index + 1] = productImage[index + 2];
            productImage[index + 2] = "";
          });
        } else {
          setState(() {
            productImage[index] = productImage[index + 1];
            productImage[index + 1] = "";
          });
        }
      } else {
        setState(() {
          productImage[index] = "";
        });
      }
    }
  }

  submitForm() async {
    Product product = Product(
        productId: pid,
        productName: pName,
        manufactureName: brand,
        model: model,
        size: size,
        price: price,
        inStock: stock,
        picture1: productImage[0],
        picture2: productImage[1],
        picture3: productImage[2],
        description: description);
    int a = await databaseHelper.saveProduct(product);
    print(a);
  }

  @override
  Widget build(BuildContext context) {
    List<Uint8List> bytesImage = [null, null, null];
    if (productImage[0].length != 0) {
      bytesImage[0] = base64Decode(productImage[0]);
    }
    if (productImage[1].length != 0) {
      bytesImage[1] = base64Decode(productImage[1]);
    }
    if (productImage[2].length != 0) {
      bytesImage[2] = base64Decode(productImage[2]);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Form"),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.code),
                    hintText: 'Please Enter the id of the Product',
                    labelText: 'Product Id',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    pid = int.tryParse(value);
                  },
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.book),
                    hintText: 'Please Enter the name of the Product',
                    labelText: 'Product Name',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    pName = value;
                  },
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.branding_watermark),
                    hintText: 'What brand does the product belong?',
                    labelText: 'Brand/Manufacturer',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    brand = value;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Add Product Images",
                    style: TextStyle(fontSize: 18, color: Color(0xff808080)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.width * 0.5,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: GestureDetector(
                          child: productImage[0].length != 0
                              ? Container(
                                  child: Column(
                                    children: <Widget>[
                                      Image.memory(
                                        bytesImage[0],
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                      ),
                                      OutlineButton(
                                        onPressed: () => deleteImage(0),
                                        child: Text("Delete Image"),
                                      )
                                    ],
                                  ),
                                )
                              : Icon(Icons.add_a_photo),
                          onTap: () => selectImage(0),
                        ),
                      ),
                      productImage[0].length != 0
                          ? Container(
                              height: MediaQuery.of(context).size.width * 0.5,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: GestureDetector(
                                child: productImage[1].length != 0
                                    ? Container(
                                        child: Column(
                                          children: <Widget>[
                                            Image.memory(
                                              bytesImage[1],
                                              fit: BoxFit.cover,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                            ),
                                            OutlineButton(
                                              onPressed: () => deleteImage(1),
                                              child: Text("Delete Image"),
                                            )
                                          ],
                                        ),
                                      )
                                    : Icon(Icons.add_a_photo),
                                onTap: () => selectImage(1),
                              ),
                            )
                          : SizedBox(),
                      productImage[1].length != 0
                          ? Container(
                              height: MediaQuery.of(context).size.width * 0.5,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: GestureDetector(
                                child: productImage[2].length != 0
                                    ? Container(
                                        child: Column(
                                          children: <Widget>[
                                            Image.memory(
                                              bytesImage[2],
                                              fit: BoxFit.cover,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                            ),
                                            OutlineButton(
                                              onPressed: () => deleteImage(2),
                                              child: Text("Delete Image"),
                                            )
                                          ],
                                        ),
                                      )
                                    : Icon(Icons.add_a_photo),
                                onTap: () => selectImage(2),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.mood),
                    hintText: 'Enter Model name or Model code of the prooduct.',
                    labelText: 'Model name',
                  ),
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return 'Please enter some text';
                  //   }
                  //   return null;
                  // },
                  onChanged: (value) {
                    model = value;
                  },
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.satellite),
                    hintText: 'S, M, L, XL, XXL',
                    labelText: 'Product Size',
                  ),
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return 'Please enter some text';
                  //   }
                  //   return null;
                  // },
                  onChanged: (value) {
                    size = value;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.monetization_on),
                    hintText: 'Enter the price of the product in Rs.',
                    labelText: 'Price',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Price';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    price = double.tryParse(value);
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.storage),
                    hintText: 'Enter no of items in stock',
                    labelText: 'In Stock',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Stock';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    stock = int.tryParse(value);
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, top: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Product Description ${description.length}/255",
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff808080)),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        validator: (value) {
                          if (value.length > 255) {
                            return 'Please enter less than 255 words';
                          }
                          return null;
                        },
                        onChanged: (value) => {
                          setState(() {
                            description = value;
                          })
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        submitForm();
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Form Succesfully Submitted'),
                          action: SnackBarAction(
                              label: 'View Product List',
                              onPressed: () => Navigator.pop(context)),
                        ));
                        _formKey.currentState.reset();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

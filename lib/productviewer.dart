import 'dart:convert';
import 'dart:typed_data';

import 'package:Store/db/model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'images/1.jpg',
  'images/2.jpg',
  'images/3.jpg',
];

class ProductViewer extends StatefulWidget {
  ProductViewer({this.product});
  final Product product;
  @override
  _ProductViewerState createState() => _ProductViewerState();
}

class _ProductViewerState extends State<ProductViewer> {
  List<Uint8List> bytesImage = [null, null, null];
  @override
  void initState() {
    super.initState();
    if (widget.product.picture1 != null ||
        widget.product.picture1.length > 10) {
      bytesImage[0] = base64Decode(widget.product.picture1);
    }
    if (widget.product.picture2 != null || widget.product.picture2.length > 0) {
      bytesImage[1] = base64Decode(widget.product.picture1);
    }
    if (widget.product.picture3 != null || widget.product.picture3.length > 0) {
      bytesImage[2] = base64Decode(widget.product.picture1);
    }
  }

  @override
  Widget build(BuildContext context) {
    bytesImage.removeWhere((value) => value == null);
    return Scaffold(
        appBar: AppBar(
          title: Text('Product Detail'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: CarouselSlider(
                options: CarouselOptions(),
                items: bytesImage
                    .map((item) => Container(
                          child: Center(
                              child: Image.memory(
                            item,
                            fit: BoxFit.cover,
                            width: 1000,
                            height: 2000,
                          )),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'Product Name: ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700]),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${widget.product.productName}',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 22,
                                      fontStyle: FontStyle.italic))
                            ]),
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Price: ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700]),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Rs.${widget.product.price}',
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 17))
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'Model: ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700]),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${widget.product.model}',
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17))
                            ]),
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'InStock: ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700]),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${widget.product.inStock}',
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17))
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Card(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Product Description:',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${widget.product.description}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

import 'package:Store/db/helper.dart';
import 'package:Store/db/model.dart';
import 'package:Store/productviewer.dart';
import 'package:Store/form.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void navigateToForm() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => ProductForm(),
    ));
  }

  dynamic productsListMap;
  List<Product> allProduct;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadProducts();
    });
  }

  void seeDetails(int index) {
    print("Aayush");
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => ProductViewer(
        product: allProduct[index],
      ),
    ));
  }

  Future<void> loadProducts() async {
    allProduct = [];
    productsListMap = await dbHelper.getAllProducts();
    setState(() {
      productsListMap.forEach((p) => allProduct.add(Product.fromMapObject(p)));
    });
  }

  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
          onRefresh: loadProducts,
          child: Center(
            child: allProduct != null
                ? ListView.builder(
                    padding: EdgeInsets.only(top: 10),
                    itemCount: allProduct.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Card(
                          margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).padding.top * 0.5,
                            vertical: MediaQuery.of(context).padding.top * 0.25,
                          ),
                          elevation: 0.5,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.person_add),
                            ),
                            title: Text(
                              "${allProduct[index].productName}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                color: Colors.black54,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text:
                                      " ${allProduct[index].manufactureName} ",
                                  style: TextStyle(
                                    fontFamily: 'Myriad',
                                    color: Colors.blue,
                                  ),
                                ),
                                TextSpan(
                                  text: "Model: ${allProduct[index].model}",
                                  style: TextStyle(
                                    fontFamily: 'Myriad',
                                    color: Colors.red,
                                  ),
                                )
                              ]),
                            ),
                            onTap: () => {seeDetails(index)},
                          ));
                    },
                  )
                : SizedBox(),
          )),

      floatingActionButton: FloatingActionButton(
        onPressed: navigateToForm,
        tooltip: 'Add Product',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

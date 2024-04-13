import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      home: ShoppingList(
        products: <Product>[
          Product(productName: 'Apple'),
          Product(productName: 'Banana'),
          Product(productName: 'Orange'),
        ],
      ),
    );
  }
}

class Product {
  final String? productName;
  Product({required this.productName});
}

class ShoppingList extends StatefulWidget {
  final List<Product> products;

  const ShoppingList({Key? key, required this.products}) : super(key: key);

  @override
  State<ShoppingList> createState() => ShoppingListState();
}

class ShoppingListState extends State<ShoppingList> {
  Set<Product> shoppingCart = Set<Product>();

  void handleCardChange(Product product, bool inCard) {
    setState(() {
      inCard ? shoppingCart.remove(product) : shoppingCart.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Shopping Cart App'),
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: widget.products.map((product) {
            return ShoppingListItem(
              productName: product.productName,
              product: product,
              onCardChange: handleCardChange,
              inCard: shoppingCart.contains(product),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ShoppingListItem extends StatelessWidget {
  final String? productName;
  final Product product;
  final Function(Product, bool) onCardChange;
  final bool? inCard;

  ShoppingListItem({
    this.productName,
    required this.product,
    required this.onCardChange,
    this.inCard,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCardChange(product, inCard ?? false);
      },
      leading: CircleAvatar(
        backgroundColor: inCard ?? false ? Colors.teal : Colors.blue,
        child: Text(
          productName?[0] ?? '',
          style: TextStyle(color: Colors.white),
        ),
      ),
      title: Text(productName ?? '', style: TextStyle(
        decoration: inCard ?? false ? TextDecoration.lineThrough : null,
      ),),
    );
  }
}

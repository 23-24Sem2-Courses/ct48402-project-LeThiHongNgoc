import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen(
    this.product, {
    super.key,
    this.onFavoritePressed,
  });

  final Product product;
  final void Function()? onFavoritePressed;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  TextEditingController quantityController = TextEditingController();

  void _increaseQuantity() {
    setState(() {
      _quantity++;
      quantityController.text = _quantity.toString();
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
        quantityController.text = _quantity.toString();
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'Không giảm được nữa',
                textAlign: TextAlign.center,
              ),
            ),
          );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    quantityController.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.title,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Image.asset(
                  widget.product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  widget.product.title,
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                FavoriteProductButton(
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _decreaseQuantity,
                  child: const Icon(Icons.remove),
                ),
                SizedBox(
                  width: 50,
                  child: TextField(
                    style: const TextStyle(fontSize: 25),
                    controller: quantityController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _quantity = int.tryParse(value) ?? 1;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  // style: ElevatedButton.styleFrom(
                  //   padding: const EdgeInsets.all(0),
                  //   backgroundColor: Theme.of(context).primaryColor,
                  //   foregroundColor: Colors.white,
                  // ),
                  onPressed: _increaseQuantity,
                  child: const Icon(Icons.add),
                ),
                Text(
                  '\$${widget.product.price}',
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                widget.product.description,
                textAlign: TextAlign.center,
                softWrap: true,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            CartButton(
              onPressed: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        'Đã thêm sản phẩm vào giỏ hàng',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Add to Cart',
            style: TextStyle(
                color: Theme.of(context).primaryColorLight, fontSize: 25),
          ),
          IconButton(
            iconSize: 30,
            onPressed: onPressed,
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.error,
          ),
        ],
      ),
    );
  }
}

class FavoriteProductButton extends StatefulWidget {
  const FavoriteProductButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  State<FavoriteProductButton> createState() => _FavoriteProductButtonState();
}

class _FavoriteProductButtonState extends State<FavoriteProductButton> {
  bool _isFavorited = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            iconSize: 30,
            icon: Icon(_isFavorited ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).colorScheme.error,
            onPressed: () {
              setState(() {
                if (_isFavorited = !_isFavorited) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).primaryColor,
                        content: const Text(
                          'Đã thêm sản phẩm vào danh sách yêu thích',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                }
              });
            }),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import './../screens.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';
  const ProductDetailScreen(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  bool isFavorite = false;
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
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          SearchButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearch(
                  Provider.of<ProductsManager>(context, listen: false).items,
                ),
              );
            },
          ),
          ShoppingCartButton(
            onPressed: () {
              // Navigate to CartScreen
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        height: 1000,
        color: Colors.teal[50],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: widget.product.id ?? '',
                child: Image.asset(
                  widget.product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FavoriteProductButton(
                    onPressed: () {},
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '\$${widget.product.price}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _decreaseQuantity,
                    child: Container(
                      // padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.remove,
                        size: 35,
                        color: Color(0xff022840),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 70,
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
                  GestureDetector(
                    onTap: _increaseQuantity,
                    child: Container(
                      // padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 35,
                        color: Color(0xff022840),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
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
              const SizedBox(
                height: 20,
              ),
              CartButton(onPressed: () {
                if (_quantity > 0) {
                  final cart = context.read<CartManager>();
                  cart.addItemWithQuantity(widget.product, _quantity);
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('Thêm vào giỏ hàng thành công'),
                      ),
                    );
                } else {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('Vui lòng chọn số lượng'),
                      ),
                    );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
    required this.onPressed,
    this.quantity,
  });

  final void Function() onPressed;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: const Text(
              'Thêm vào giỏ hàng',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
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
          iconSize: 35,
          icon: Icon(
            _isFavorited ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {
            setState(
              () {
                if (_isFavorited = !_isFavorited) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          'Đã thêm sản phẩm vào danh sách yêu thích',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                }
              },
            );
          },
        ),
      ],
    );
  }
}

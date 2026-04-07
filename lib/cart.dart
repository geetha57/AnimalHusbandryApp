import 'package:flutter/material.dart';
import 'order_history.dart';

class CartPage extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String productImage;
  final int quantity;

  const CartPage({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.quantity,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Map<String, dynamic>> cartItems;

  @override
  void initState() {
    super.initState();
    cartItems = [
      {
        'name': widget.productName,
        'price': widget.productPrice,
        'image': widget.productImage,
        'quantity': widget.quantity,
      }
    ];
  }

  double get totalAmount {
    return cartItems.fold(0, (sum, item) {
      double price = double.tryParse(
          item['price'].toString().replaceAll(RegExp(r'[^0-9.]'), '')) ??
          0.0;
      return sum + price * item['quantity'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      backgroundColor: Colors.green.shade50,
      body: cartItems.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined,
                size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text("Cart is empty 😔",
                style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        // Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            item['image'],
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                Container(
                                  width: 90,
                                  height: 90,
                                  color: Colors.grey.shade200,
                                  child: const Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey),
                                ),
                            loadingBuilder:
                                (context, child, loadingProgress) {
                              if (loadingProgress == null)
                                return child;
                              return Container(
                                width: 90,
                                height: 90,
                                color: Colors.grey.shade100,
                                child: const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.green)),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "₹${item['price']}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.green.shade700,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 8),

                              // Quantity Controls
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (item['quantity'] > 1) {
                                          item['quantity']--;
                                        } else {
                                          cartItems.removeAt(index);
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding:
                                      const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color:
                                        Colors.green.shade100,
                                        borderRadius:
                                        BorderRadius.circular(
                                            6),
                                      ),
                                      child: Icon(Icons.remove,
                                          size: 18,
                                          color:
                                          Colors.green.shade700),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Text(
                                      '${item['quantity']}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight.bold),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        item['quantity']++;
                                      });
                                    },
                                    child: Container(
                                      padding:
                                      const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color:
                                        Colors.green.shade100,
                                        borderRadius:
                                        BorderRadius.circular(
                                            6),
                                      ),
                                      child: Icon(Icons.add,
                                          size: 18,
                                          color:
                                          Colors.green.shade700),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Delete Button
                        IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.red),
                          onPressed: () {
                            setState(() {
                              cartItems.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom Summary + Place Order
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    offset: const Offset(0, -3))
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Amount:",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Text(
                      "₹${totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // ✅ Place Order → goes to AddressPage now
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding:
                      const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddressPage(
                            productName: widget.productName,
                            productPrice:
                            "₹${totalAmount.toStringAsFixed(2)}",
                          ),
                        ),
                      );
                    },
                    child: const Text("Place Order",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
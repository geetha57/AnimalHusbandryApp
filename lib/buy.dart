import 'package:flutter/material.dart';
import 'cart.dart';
import 'order_history.dart';

class BuyPage extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String productImage;

  const BuyPage({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productImage,
  });

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  int quantity = 1;

  double get pricePerUnit {
    return double.tryParse(
        widget.productPrice.replaceAll(RegExp(r'[^0-9.]'), '')) ??
        0.0;
  }

  double get totalAmount => quantity * pricePerUnit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy ${widget.productName}'),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      backgroundColor: Colors.green.shade50,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.productImage,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.productName,
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(widget.productPrice,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green.shade800)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Quantity Selector
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Quantity:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline,
                              color: Colors.green.shade700),
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() => quantity--);
                            }
                          },
                        ),
                        Text('$quantity',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline,
                              color: Colors.green.shade700),
                          onPressed: () {
                            setState(() => quantity++);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Payment Summary
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildPaymentDetailRow(
                        'Subtotal:',
                        '₹${pricePerUnit.toStringAsFixed(2)}'),
                    _buildPaymentDetailRow('Delivery Fee:', 'FREE'),
                    const Divider(),
                    _buildPaymentDetailRow(
                        'Total Amount:',
                        '₹${totalAmount.toStringAsFixed(2)}',
                        isTotal: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ ADD TO CART - goes to CartPage
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    padding:
                    const EdgeInsets.symmetric(vertical: 16)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CartPage(
                        productName: widget.productName,
                        productPrice: widget.productPrice,
                        productImage: widget.productImage,
                        quantity: quantity,
                      ),
                    ),
                  );
                },
                child: const Text('Add to Cart'),
              ),
            ),
            const SizedBox(height: 12),

            // ✅ BUY NOW - goes to AddressPage directly
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    padding:
                    const EdgeInsets.symmetric(vertical: 16)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddressPage(
                        productName: widget.productName,
                        productPrice:
                        '₹${totalAmount.toStringAsFixed(2)}',
                      ),
                    ),
                  );
                },
                child: const Text('Buy Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetailRow(String label, String value,
      {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight:
                  isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontWeight:
                  isTotal ? FontWeight.bold : FontWeight.w600,
                  color: isTotal
                      ? Colors.green.shade800
                      : Colors.black87)),
        ],
      ),
    );
  }
}
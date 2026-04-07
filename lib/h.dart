import 'package:flutter/material.dart';
import 'buy.dart'; // Make sure this path is correct

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Product data list
    final products = [
      {
        "name": "Milk",
        "price": "₹70 / litre",
        "image":
        "https://i.pinimg.com/736x/af/fa/d3/affad3ffbc2017887ca534fcd1a4fa9d.jpg"
      },
      {
        "name": "Farm Eggs",
        "price": "₹5 / egg",
        "image":
        "https://i.pinimg.com/736x/a6/a1/1f/a6a11fb2ab6dad9f6d7c4304b9a52dd8.jpg"
      },
      {
        "name": "Ghee",
        "price": "₹450 / litre",
        "image": "https://cdn-icons-png.flaticon.com/128/5015/5015411.png"
      },
      {
        "name": "Paneer",
        "price": "₹90 / kg",
        "image":
        "https://i.pinimg.com/736x/bd/5b/21/bd5b21c1c4e28c335d1f367a2036d68c.jpg"
      },
      {
        "name": "Fresh Chicken",
        "price": "₹180 / kg",
        "image": "https://cdn-icons-png.flaticon.com/128/1046/1046751.png"
      },
      {
        "name": "Yogurt",
        "price": "₹50 / litre",
        "image":
        "https://i.pinimg.com/736x/33/c4/b1/33c4b110edd5c871c6bb189bd27a3a80.jpg"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('AnimCraft'),
        actions: const [Icon(Icons.shopping_cart)],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.green.shade100,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Because Your Herd Deserves the Best!',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                            'Top-quality dairy and meat products just for you.')
                      ],
                    ),
                  ),
                  Image.network(
                    'https://i.pinimg.com/736x/2b/bd/41/2bbd41cacfef33803b9d7eb1bde3cb29.jpg',
                    height: 80,
                    width: 80,
                  ),
                ],
              ),
            ),

            // Product Categories
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Product Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 80,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCategory('Dairy'),
                        _buildCategory('Meat'),
                        _buildCategory('Eggs'),
                        _buildCategory('Feed'),
                        _buildCategory('Health'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Flash Sale
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.orange.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Flash Sale: 25% off on Feed!',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Icon(Icons.flash_on, color: Colors.orange),
                ],
              ),
            ),

            // Featured Products Grid
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Explore Our Products',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _buildProductCard(
                        context: context,
                        name: product["name"]!,
                        price: product["price"]!,
                        image: product["image"]!,
                      );
                    },
                  ),
                ],
              ),
            ),

            // Promo Banner
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '30% off on all organic milk products! 🐄',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            // Tips & Advice
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Tips & Advice',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                      '🐮 Keep your cows hydrated\n🐐 Provide balanced diet\n🐔 Clean shelters regularly'),
                ],
              ),
            ),

            // Join Community
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.groups, size: 32, color: Colors.brown),
                  SizedBox(width: 10),
                  Expanded(child: Text('Join our  farming community!')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Category Chip
  Widget _buildCategory(String name) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(child: Text(name)),
    );
  }

  // Product Card Widget (with navigation)
  Widget _buildProductCard({
    required BuildContext context,
    required String name,
    required String price,
    required String image,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Image.network(image, fit: BoxFit.contain),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(price),
          const SizedBox(height: 6),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BuyPage(
                    productName: name,
                    productPrice: price,
                    productImage: image,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('Buy'),
          ),
        ],
      ),
    );
  }
}
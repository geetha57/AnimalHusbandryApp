import 'package:flutter/material.dart';
import 'order.dart';

// ═══════════════════════════════════════════
//           ORDER HISTORY PAGE
// ═══════════════════════════════════════════

class Order {
  final String orderId;
  final String productName;
  final String price;
  final String date;
  String status;
  final String image;

  Order({
    required this.orderId,
    required this.productName,
    required this.price,
    required this.date,
    required this.status,
    required this.image,
  });
}

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  List<Order> orders = [
    Order(
      orderId: "#ORD001",
      productName: "Fresh Milk",
      price: "₹50",
      date: "20 Mar 2026",
      status: "Delivered",
      image:
      "https://images.unsplash.com/photo-1550583724-b2692b85b150?w=200",
    ),
    Order(
      orderId: "#ORD002",
      productName: "Farm Eggs",
      price: "₹80",
      date: "21 Mar 2026",
      status: "Pending",
      image:
      "https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f?w=200",
    ),
    Order(
      orderId: "#ORD003",
      productName: "Organic Cheese",
      price: "₹120",
      date: "22 Mar 2026",
      status: "Cancelled",
      image:
      "https://images.unsplash.com/photo-1486297678162-eb2a19b0a318?w=200",
    ),
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "Delivered":
        return Icons.check_circle;
      case "Pending":
        return Icons.access_time;
      case "Cancelled":
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      backgroundColor: Colors.green.shade50,
      body: orders.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text("No orders yet!",
                style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          order.image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey.shade200,
                            child:
                            const Icon(Icons.image_not_supported),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(order.productName,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(order.orderId,
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13)),
                            const SizedBox(height: 4),
                            Text(order.date,
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13)),
                            const SizedBox(height: 4),
                            Text(order.price,
                                style: TextStyle(
                                    color: Colors.green.shade700,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15)),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Icon(getStatusIcon(order.status),
                              color: getStatusColor(order.status)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: getStatusColor(order.status)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color:
                                  getStatusColor(order.status)),
                            ),
                            child: Text(
                              order.status,
                              style: TextStyle(
                                  color: getStatusColor(order.status),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tap to reorder",
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12)),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddressPage(
                                productName: order.productName,
                                productPrice: order.price,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.refresh, size: 16),
                        label: const Text("Reorder"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ═══════════════════════════════════════════
//              ADDRESS PAGE
// ═══════════════════════════════════════════

class AddressModel {
  String name;
  String phone;
  String address;
  String city;
  String pincode;
  bool isDefault;

  AddressModel({
    required this.name,
    required this.phone,
    required this.address,
    required this.city,
    required this.pincode,
    this.isDefault = false,
  });
}

class AddressPage extends StatefulWidget {
  final String productName;
  final String productPrice;

  const AddressPage({
    super.key,
    required this.productName,
    required this.productPrice,
  });

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  List<AddressModel> addresses = [
    AddressModel(
      name: "John Doe",
      phone: "9876543210",
      address: "123, Green Street",
      city: "Hyderabad",
      pincode: "500001",
      isDefault: true,
    ),
    AddressModel(
      name: "Jane Doe",
      phone: "9123456789",
      address: "456, Farm Lane",
      city: "Vijayawada",
      pincode: "520001",
      isDefault: false,
    ),
  ];

  int selectedIndex = 0;

  void _showAddEditDialog({AddressModel? existing, int? index}) {
    final nameCtrl =
    TextEditingController(text: existing?.name ?? '');
    final phoneCtrl =
    TextEditingController(text: existing?.phone ?? '');
    final addressCtrl =
    TextEditingController(text: existing?.address ?? '');
    final cityCtrl =
    TextEditingController(text: existing?.city ?? '');
    final pincodeCtrl =
    TextEditingController(text: existing?.pincode ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(existing == null ? "Add Address" : "Edit Address"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _buildField(nameCtrl, "Full Name", Icons.person),
              const SizedBox(height: 10),
              _buildField(phoneCtrl, "Phone Number", Icons.phone,
                  type: TextInputType.phone),
              const SizedBox(height: 10),
              _buildField(addressCtrl, "Street Address", Icons.home),
              const SizedBox(height: 10),
              _buildField(cityCtrl, "City", Icons.location_city),
              const SizedBox(height: 10),
              _buildField(pincodeCtrl, "Pincode", Icons.pin,
                  type: TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style:
            ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              setState(() {
                final newAddress = AddressModel(
                  name: nameCtrl.text,
                  phone: phoneCtrl.text,
                  address: addressCtrl.text,
                  city: cityCtrl.text,
                  pincode: pincodeCtrl.text,
                );
                if (existing == null) {
                  addresses.add(newAddress);
                } else {
                  addresses[index!] = newAddress;
                }
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Widget _buildField(
      TextEditingController ctrl, String label, IconData icon,
      {TextInputType type = TextInputType.text}) {
    return TextField(
      controller: ctrl,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green),
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.green),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Address"),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      backgroundColor: Colors.green.shade50,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final addr = addresses[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: RadioListTile(
                    value: index,
                    groupValue: selectedIndex,
                    activeColor: Colors.green,
                    onChanged: (val) {
                      setState(() => selectedIndex = val!);
                    },
                    title: Row(
                      children: [
                        Text(addr.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(width: 8),
                        if (addr.isDefault)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text("Default",
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.green.shade800)),
                          ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(addr.address),
                          Text("${addr.city} - ${addr.pincode}"),
                          Text("📞 ${addr.phone}"),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              OutlinedButton.icon(
                                onPressed: () => _showAddEditDialog(
                                    existing: addr, index: index),
                                icon: const Icon(Icons.edit,
                                    size: 14, color: Colors.green),
                                label: const Text("Edit",
                                    style:
                                    TextStyle(color: Colors.green)),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.green),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                ),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton.icon(
                                onPressed: () {
                                  setState(
                                          () => addresses.removeAt(index));
                                },
                                icon: const Icon(Icons.delete,
                                    size: 14, color: Colors.red),
                                label: const Text("Delete",
                                    style: TextStyle(color: Colors.red)),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.red),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
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
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _showAddEditDialog(),
                    icon: const Icon(Icons.add, color: Colors.green),
                    label: const Text("Add New Address",
                        style: TextStyle(color: Colors.green)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.green),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PaymentPage(
                            productName: widget.productName,
                            productPrice: widget.productPrice,
                            deliveryAddress:
                            "${addresses[selectedIndex].address}, ${addresses[selectedIndex].city} - ${addresses[selectedIndex].pincode}",
                          ),
                        ),
                      );
                    },
                    child: const Text("Proceed to Payment",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
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

// ═══════════════════════════════════════════
//              PAYMENT PAGE
// ═══════════════════════════════════════════

class PaymentPage extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String deliveryAddress;

  const PaymentPage({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.deliveryAddress,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPayment = "Cash on Delivery";
  final upiCtrl = TextEditingController();
  final cardNumberCtrl = TextEditingController();
  final cardNameCtrl = TextEditingController();
  final cardExpiryCtrl = TextEditingController();
  final cardCvvCtrl = TextEditingController();

  Widget _buildPaymentOption(
      String title, String subtitle, IconData icon) {
    final isSelected = selectedPayment == title;
    return GestureDetector(
      onTap: () => setState(() => selectedPayment = title),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade50 : Colors.white,
          border: Border.all(
              color: isSelected ? Colors.green : Colors.grey.shade300,
              width: isSelected ? 2 : 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: isSelected ? Colors.green : Colors.grey, size: 28),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: isSelected
                              ? Colors.green.shade800
                              : Colors.black)),
                  Text(subtitle,
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey.shade600)),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController ctrl, String label, IconData icon,
      {TextInputType type = TextInputType.text,
        bool obscure = false,
        int maxLength = 100}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: ctrl,
        keyboardType: type,
        obscureText: obscure,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.green),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.green),
          ),
          counterText: '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      backgroundColor: Colors.green.shade50,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Order Summary",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.productName,
                            style: const TextStyle(fontSize: 14)),
                        Text(widget.productPrice,
                            style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Delivery Fee",
                            style: TextStyle(fontSize: 14)),
                        Text("FREE",
                            style:
                            TextStyle(color: Colors.green.shade700)),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        Text(widget.productPrice,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.green.shade800)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Delivery Address
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.green),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Delivering To",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                          Text(widget.deliveryAddress,
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Payment Options
            const Text("Select Payment Method",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildPaymentOption("Cash on Delivery",
                "Pay when order arrives", Icons.money),
            _buildPaymentOption(
                "UPI", "Google Pay, PhonePe, Paytm", Icons.qr_code),
            _buildPaymentOption("Credit / Debit Card",
                "Visa, Mastercard, Rupay", Icons.credit_card),
            const SizedBox(height: 10),

            // UPI Input
            if (selectedPayment == "UPI") ...[
              const Text("Enter UPI ID",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              _buildTextField(
                  upiCtrl, "e.g. name@upi", Icons.alternate_email),
            ],

            // Card Input
            if (selectedPayment == "Credit / Debit Card") ...[
              const Text("Enter Card Details",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              _buildTextField(
                  cardNameCtrl, "Cardholder Name", Icons.person),
              _buildTextField(
                  cardNumberCtrl, "Card Number", Icons.credit_card,
                  type: TextInputType.number, maxLength: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                        cardExpiryCtrl, "MM/YY", Icons.calendar_today,
                        maxLength: 5),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                        cardCvvCtrl, "CVV", Icons.lock,
                        obscure: true, maxLength: 3),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 20),

            // Pay Now Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Confirm Payment"),
                      content: Text(
                          "Pay ${widget.productPrice} via $selectedPayment?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OrderSuccessPage(
                                    productName: widget.productName),
                              ),
                                  (route) => route.isFirst,
                            );
                          },
                          child: const Text("Confirm"),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  selectedPayment == "Cash on Delivery"
                      ? "Place Order"
                      : "Pay Now",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
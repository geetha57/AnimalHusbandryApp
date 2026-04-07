import 'package:flutter/material.dart';
import 'login.dart';

// ─────────────────────────────────────────────
//  COLORS
// ─────────────────────────────────────────────
const kGreen = Color(0xFF3CB648);
const kDarkGreen = Color(0xFF2A8F34);
const kLightGreen = Color(0xFFE8F5E9);
const kBg = Color(0xFFF4F6F8);

// ─────────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────────
class Order {
  final String id, buyer, animal, amount, status, date;
  Order({
    required this.id,
    required this.buyer,
    required this.animal,
    required this.amount,
    required this.status,
    required this.date,
  });
}

class Message {
  final String sender, preview, time, avatar;
  final bool unread;
  final List<ChatMessage> chat;
  Message({
    required this.sender,
    required this.preview,
    required this.time,
    required this.avatar,
    required this.unread,
    required this.chat,
  });
}

class ChatMessage {
  final String text, time;
  final bool isMe;
  ChatMessage({required this.text, required this.time, required this.isMe});
}

// ─────────────────────────────────────────────
//  SELLER DASHBOARD
// ─────────────────────────────────────────────
class SellerDashboard extends StatefulWidget {
  const SellerDashboard({super.key});
  @override
  State<SellerDashboard> createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  int _currentIndex = 0;

  final List<Order> _orders = [
    Order(id: '#001', buyer: 'Ramesh K.', animal: 'Holstein Cow', amount: '₹45,000', status: 'Delivered', date: '20 Mar'),
    Order(id: '#002', buyer: 'Vijay R.', animal: 'Desi Hen (x10)', amount: '₹3,200', status: 'Pending', date: '22 Mar'),
    Order(id: '#003', buyer: 'Suresh M.', animal: 'Murrah Buffalo', amount: '₹62,000', status: 'Delivered', date: '18 Mar'),
    Order(id: '#004', buyer: 'Anil T.', animal: 'Goat (Boer)', amount: '₹8,500', status: 'Cancelled', date: '12 Mar'),
    Order(id: '#005', buyer: 'Mohan D.', animal: 'Pig (Large White)', amount: '₹12,000', status: 'Pending', date: '21 Mar'),
    Order(id: '#006', buyer: 'Kiran P.', animal: 'Gir Cow', amount: '₹38,000', status: 'Delivered', date: '15 Mar'),
  ];

  final List<Message> _messages = [
    Message(
      sender: 'Ramesh K.', avatar: 'R', preview: 'Is the cow still available?',
      time: '10:32 AM', unread: true,
      chat: [
        ChatMessage(text: 'Hello! Is the Holstein cow still available?', time: '10:30 AM', isMe: false),
        ChatMessage(text: 'Yes it is! She is 4 years old and healthy.', time: '10:31 AM', isMe: true),
        ChatMessage(text: 'Is the cow still available?', time: '10:32 AM', isMe: false),
      ],
    ),
    Message(
      sender: 'Vijay R.', avatar: 'V', preview: 'When will you deliver the hens?',
      time: '9:15 AM', unread: true,
      chat: [
        ChatMessage(text: 'I placed an order for the hens. When will you deliver?', time: '9:10 AM', isMe: false),
        ChatMessage(text: 'Will deliver by tomorrow evening.', time: '9:14 AM', isMe: true),
        ChatMessage(text: 'When will you deliver the hens?', time: '9:15 AM', isMe: false),
      ],
    ),
    Message(
      sender: 'Suresh M.', avatar: 'S', preview: 'Thank you! Buffalo is great 👍',
      time: 'Yesterday', unread: false,
      chat: [
        ChatMessage(text: 'Buffalo received in good condition!', time: 'Yesterday', isMe: false),
        ChatMessage(text: 'Glad to hear that! Thank you.', time: 'Yesterday', isMe: true),
        ChatMessage(text: 'Thank you! Buffalo is great 👍', time: 'Yesterday', isMe: false),
      ],
    ),
    Message(
      sender: 'Anil T.', avatar: 'A', preview: 'Can I get a refund?',
      time: '12 Mar', unread: false,
      chat: [
        ChatMessage(text: 'I had to cancel my order. Can I get a refund?', time: '12 Mar', isMe: false),
        ChatMessage(text: 'Yes, refund will be processed in 3-5 days.', time: '12 Mar', isMe: true),
        ChatMessage(text: 'Can I get a refund?', time: '12 Mar', isMe: false),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      _OrdersTab(orders: _orders),
      _EarningsTab(orders: _orders),
      _MessagesTab(messages: _messages),
    ];

    final unreadCount = _messages.where((m) => m.unread).length;

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: Text(
          ['Orders', 'Earnings', 'Messages'][_currentIndex],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
              child: Text('S', style: TextStyle(color: kGreen, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),

      drawer: _buildDrawer(context),
      body: pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        selectedItemColor: kGreen,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: 'Orders'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.currency_rupee), label: 'Earnings'),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.message_outlined),
                if (unreadCount > 0)
                  Positioned(
                    right: 0, top: 0,
                    child: Container(
                      width: 8, height: 8,
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                    ),
                  ),
              ],
            ),
            label: 'Messages',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: kDarkGreen),
            accountName: const Text('Seller Account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            accountEmail: const Text('seller@animalhub.com'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.storefront, color: kDarkGreen, size: 32),
            ),
          ),
          _tile(Icons.shopping_cart_outlined, 'Orders', 0, context),
          _tile(Icons.currency_rupee, 'Earnings', 1, context),
          _tile(Icons.message_outlined, 'Messages', 2, context),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context); // close drawer
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _tile(IconData icon, String label, int index, BuildContext context) {
    final bool selected = _currentIndex == index;
    return ListTile(
      leading: Icon(icon, color: selected ? kGreen : kDarkGreen),
      title: Text(label,
          style: TextStyle(
            color: selected ? kGreen : Colors.black87,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          )),
      tileColor: selected ? kLightGreen : null,
      onTap: () {
        setState(() => _currentIndex = index);
        Navigator.pop(context);
      },
    );
  }
}

// ─────────────────────────────────────────────
//  TAB 1 — ORDERS
// ─────────────────────────────────────────────
class _OrdersTab extends StatefulWidget {
  final List<Order> orders;
  const _OrdersTab({required this.orders});
  @override
  State<_OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<_OrdersTab> {
  String _filter = 'All';

  Color _statusColor(String s) {
    switch (s) {
      case 'Delivered': return kGreen;
      case 'Pending': return Colors.orange;
      default: return Colors.red;
    }
  }

  IconData _statusIcon(String s) {
    switch (s) {
      case 'Delivered': return Icons.check_circle;
      case 'Pending': return Icons.access_time;
      default: return Icons.cancel;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filter == 'All'
        ? widget.orders
        : widget.orders.where((o) => o.status == _filter).toList();

    final pending = widget.orders.where((o) => o.status == 'Pending').length;
    final delivered = widget.orders.where((o) => o.status == 'Delivered').length;
    final cancelled = widget.orders.where((o) => o.status == 'Cancelled').length;

    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              _chip('All', Colors.grey),
              const SizedBox(width: 8),
              _chip('Pending', Colors.orange),
              const SizedBox(width: 8),
              _chip('Delivered', kGreen),
              const SizedBox(width: 8),
              _chip('Cancelled', Colors.red),
            ],
          ),
        ),
        Container(
          color: kLightGreen,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _countBadge('$pending', 'Pending', Colors.orange),
              _countBadge('$delivered', 'Delivered', kGreen),
              _countBadge('$cancelled', 'Cancelled', Colors.red),
            ],
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? const Center(child: Text('No orders', style: TextStyle(color: Colors.grey)))
              : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filtered.length,
            itemBuilder: (_, i) {
              final o = filtered[i];
              final color = _statusColor(o.status);
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border(left: BorderSide(color: color, width: 4)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: color.withOpacity(0.12),
                        radius: 22,
                        child: Icon(_statusIcon(o.status), color: color, size: 20),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(o.buyer,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                const SizedBox(width: 6),
                                Text(o.id, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(o.animal, style: const TextStyle(color: Colors.black87, fontSize: 13)),
                            Text('Date: ${o.date}', style: const TextStyle(color: Colors.grey, fontSize: 11)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(o.amount,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, color: kDarkGreen, fontSize: 15)),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                                color: color.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(o.status,
                                style: TextStyle(
                                    color: color, fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _chip(String label, Color color) {
    final selected = _filter == label;
    return GestureDetector(
      onTap: () => setState(() => _filter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color),
        ),
        child: Text(label,
            style: TextStyle(
                color: selected ? Colors.white : color,
                fontSize: 12,
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _countBadge(String value, String label, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: color)),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  TAB 2 — EARNINGS
// ─────────────────────────────────────────────
class _EarningsTab extends StatelessWidget {
  final List<Order> orders;
  const _EarningsTab({required this.orders});

  int _parse(String s) =>
      int.tryParse(s.replaceAll('₹', '').replaceAll(',', '')) ?? 0;

  String _format(int n) =>
      '₹${n.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},')}';

  @override
  Widget build(BuildContext context) {
    final delivered = orders.where((o) => o.status == 'Delivered').toList();
    final pending = orders.where((o) => o.status == 'Pending').toList();
    final total = delivered.fold(0, (s, o) => s + _parse(o.amount));
    final pendingTotal = pending.fold(0, (s, o) => s + _parse(o.amount));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [kGreen, kDarkGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: kGreen.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.account_balance_wallet, color: Colors.white70, size: 18),
                    SizedBox(width: 6),
                    Text('Total Earnings', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 10),
                Text(_format(total),
                    style: const TextStyle(
                        color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.access_time, color: Colors.white70, size: 14),
                      const SizedBox(width: 6),
                      Text('${_format(pendingTotal)} pending collection',
                          style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(children: [
            _summaryBox('${delivered.length}', 'Sales Done', kGreen),
            const SizedBox(width: 12),
            _summaryBox('${pending.length}', 'Pending', Colors.orange),
            const SizedBox(width: 12),
            _summaryBox(
                '${orders.where((o) => o.status == 'Cancelled').length}',
                'Cancelled', Colors.red),
          ]),
          const SizedBox(height: 24),
          const Text('Transaction History',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          ...delivered.map((o) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              leading: const CircleAvatar(
                backgroundColor: kLightGreen,
                child: Icon(Icons.currency_rupee, color: kDarkGreen, size: 20),
              ),
              title: Text(o.animal,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              subtitle: Text('${o.buyer}  •  ${o.date}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(o.amount,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: kGreen, fontSize: 15)),
                  const Text('Received',
                      style: TextStyle(color: Colors.grey, fontSize: 10)),
                ],
              ),
            ),
          )),
          if (pending.isNotEmpty) ...[
            const SizedBox(height: 8),
            const Text('Pending Collection',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            ...pending.map((o) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade200),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFFFF3E0),
                  child: Icon(Icons.access_time, color: Colors.orange, size: 20),
                ),
                title: Text(o.animal,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: Text('${o.buyer}  •  ${o.date}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(o.amount,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 15)),
                    const Text('Pending',
                        style: TextStyle(color: Colors.orange, fontSize: 10)),
                  ],
                ),
              ),
            )),
          ],
        ],
      ),
    );
  }

  Widget _summaryBox(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border(top: BorderSide(color: color, width: 3)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
        ),
        child: Column(children: [
          Text(value,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  TAB 3 — MESSAGES (Inbox + Chat)
// ─────────────────────────────────────────────
class _MessagesTab extends StatefulWidget {
  final List<Message> messages;
  const _MessagesTab({required this.messages});
  @override
  State<_MessagesTab> createState() => _MessagesTabState();
}

class _MessagesTabState extends State<_MessagesTab> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: widget.messages.length,
      separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
      itemBuilder: (_, i) {
        final m = widget.messages[i];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundColor: kGreen,
                radius: 24,
                child: Text(m.avatar,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              if (m.unread)
                Positioned(
                  right: 0, top: 0,
                  child: Container(
                    width: 12, height: 12,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(m.sender,
                  style: TextStyle(
                      fontWeight: m.unread ? FontWeight.bold : FontWeight.w500,
                      fontSize: 15)),
              Text(m.time,
                  style: TextStyle(
                      color: m.unread ? kGreen : Colors.grey,
                      fontSize: 11,
                      fontWeight: m.unread ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              m.preview,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: m.unread ? Colors.black87 : Colors.grey,
                  fontWeight: m.unread ? FontWeight.w500 : FontWeight.normal,
                  fontSize: 13),
            ),
          ),
          onTap: () {
            setState(() {
              widget.messages[i] = Message(
                sender: m.sender, avatar: m.avatar, preview: m.preview,
                time: m.time, unread: false, chat: m.chat,
              );
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => _ChatPage(message: widget.messages[i]),
              ),
            );
          },
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
//  CHAT PAGE
// ─────────────────────────────────────────────
class _ChatPage extends StatefulWidget {
  final Message message;
  const _ChatPage({required this.message});
  @override
  State<_ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<_ChatPage> {
  final TextEditingController _ctrl = TextEditingController();
  late List<ChatMessage> _chat;

  @override
  void initState() {
    super.initState();
    _chat = List.from(widget.message.chat);
  }

  void _send() {
    if (_ctrl.text.trim().isEmpty) return;
    setState(() {
      _chat.add(ChatMessage(text: _ctrl.text.trim(), time: 'Now', isMe: true));
      _ctrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kGreen,
        foregroundColor: Colors.white,
        title: Row(children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 16,
            child: Text(widget.message.avatar,
                style: const TextStyle(color: kGreen, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          Text(widget.message.sender,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ]),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _chat.length,
              itemBuilder: (_, i) {
                final c = _chat[i];
                return Align(
                  alignment: c.isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.72),
                    decoration: BoxDecoration(
                      color: c.isMe ? kGreen : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(c.isMe ? 16 : 4),
                        bottomRight: Radius.circular(c.isMe ? 4 : 16),
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 4)
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment:
                      c.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Text(c.text,
                            style: TextStyle(
                                color: c.isMe ? Colors.white : Colors.black87,
                                fontSize: 14)),
                        const SizedBox(height: 4),
                        Text(c.time,
                            style: TextStyle(
                                color: c.isMe ? Colors.white60 : Colors.grey,
                                fontSize: 10)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8)],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: kBg,
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _send,
                  child: Container(
                    width: 44, height: 44,
                    decoration: const BoxDecoration(color: kGreen, shape: BoxShape.circle),
                    child: const Icon(Icons.send, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
}
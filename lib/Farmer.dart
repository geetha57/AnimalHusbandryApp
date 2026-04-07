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
class Animal {
  String name, type, breed, age, health, milk;
  Animal({
    required this.name,
    required this.type,
    required this.breed,
    required this.age,
    required this.health,
    required this.milk,
  });
}

class FeedItem {
  final String time, feed, animals, qty;
  bool done;
  FeedItem({
    required this.time,
    required this.feed,
    required this.animals,
    required this.qty,
    required this.done,
  });
}

// ─────────────────────────────────────────────
//  FARMER DASHBOARD
// ─────────────────────────────────────────────
class FarmerDashboard extends StatefulWidget {
  const FarmerDashboard({super.key});
  @override
  State<FarmerDashboard> createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  int _currentIndex = 0;

  final List<Animal> _animals = [
    Animal(name: 'Lakshmi', type: 'Cow', breed: 'HF Cross', age: '4 yrs', health: 'Healthy', milk: '18L/day'),
    Animal(name: 'Nandi', type: 'Bull', breed: 'Ongole', age: '6 yrs', health: 'Healthy', milk: '—'),
    Animal(name: 'Kamala', type: 'Buffalo', breed: 'Murrah', age: '3 yrs', health: 'Sick', milk: '12L/day'),
    Animal(name: 'Chotu', type: 'Goat', breed: 'Boer', age: '1 yr', health: 'Healthy', milk: '2L/day'),
    Animal(name: 'Rani', type: 'Cow', breed: 'Gir', age: '5 yrs', health: 'Healthy', milk: '15L/day'),
  ];

  final List<FeedItem> _feedItems = [
    FeedItem(time: '6:00 AM', feed: 'Green Fodder', animals: 'All Cattle', qty: '20 kg', done: true),
    FeedItem(time: '10:00 AM', feed: 'Concentrate Mix', animals: 'Milking Cows', qty: '5 kg', done: true),
    FeedItem(time: '2:00 PM', feed: 'Dry Fodder', animals: 'All Animals', qty: '15 kg', done: false),
    FeedItem(time: '6:00 PM', feed: 'Green Fodder + Mineral', animals: 'All Cattle', qty: '22 kg', done: false),
  ];

  void _addAnimal(Animal a) => setState(() => _animals.add(a));
  void _toggleFeed(int i) => setState(() => _feedItems[i].done = !_feedItems[i].done);

  @override
  Widget build(BuildContext context) {
    final pages = [
      _AnimalsTab(animals: _animals, onAdd: _addAnimal),
      _FeedTab(feedItems: _feedItems, onToggle: _toggleFeed, onAdd: _showAddFeedSheet),
    ];

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
          ['My Animals', 'Feed Schedule'][_currentIndex],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
              child: Text('F', style: TextStyle(color: kGreen, fontWeight: FontWeight.bold)),
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'My Animals'),
          BottomNavigationBarItem(icon: Icon(Icons.grass), label: 'Feed Schedule'),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: kGreen,
        onPressed: () => _currentIndex == 0
            ? _showAddAnimalSheet(context)
            : _showAddFeedSheet(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // ── Drawer ──
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: kDarkGreen),
            accountName: const Text('Farmer Account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            accountEmail: const Text('farmer@animalhub.com'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.grass, color: kDarkGreen, size: 32),
            ),
          ),
          _tile(Icons.pets, 'My Animals', 0, context),
          _tile(Icons.grass, 'Feed Schedule', 1, context),
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

  // ── Add Animal Sheet ──
  void _showAddAnimalSheet(BuildContext context) {
    final nameCtrl = TextEditingController();
    final ageCtrl = TextEditingController();
    final milkCtrl = TextEditingController();
    String selectedType = 'Cow';
    String selectedBreed = 'HF Cross';
    String selectedHealth = 'Healthy';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            left: 20, right: 20, top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: StatefulBuilder(
          builder: (ctx, setSheet) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Register New Animal',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _field(nameCtrl, 'Animal Name', Icons.pets),
                const SizedBox(height: 12),
                _dropdown('Type', selectedType,
                    ['Cow', 'Bull', 'Buffalo', 'Goat', 'Pig', 'Sheep', 'Poultry'],
                        (v) => setSheet(() => selectedType = v!)),
                const SizedBox(height: 12),
                _dropdown('Breed', selectedBreed,
                    ['HF Cross', 'Ongole', 'Murrah', 'Boer', 'Gir', 'Other'],
                        (v) => setSheet(() => selectedBreed = v!)),
                const SizedBox(height: 12),
                _field(ageCtrl, 'Age (e.g. 3 yrs)', Icons.calendar_today),
                const SizedBox(height: 12),
                _dropdown('Health Status', selectedHealth,
                    ['Healthy', 'Sick', 'Under Treatment'],
                        (v) => setSheet(() => selectedHealth = v!)),
                const SizedBox(height: 12),
                _field(milkCtrl, 'Daily Production (e.g. 10L/day)', Icons.water_drop),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      if (nameCtrl.text.isNotEmpty) {
                        _addAnimal(Animal(
                          name: nameCtrl.text,
                          type: selectedType,
                          breed: selectedBreed,
                          age: ageCtrl.text.isEmpty ? '—' : ageCtrl.text,
                          health: selectedHealth,
                          milk: milkCtrl.text.isEmpty ? '—' : milkCtrl.text,
                        ));
                        Navigator.pop(ctx);
                      }
                    },
                    child: const Text('Register Animal',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Add Feed Sheet ──
  void _showAddFeedSheet(BuildContext context) {
    final feedCtrl = TextEditingController();
    final animalsCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();
    TimeOfDay selectedTime = TimeOfDay.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            left: 20, right: 20, top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: StatefulBuilder(
          builder: (ctx, setSheet) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Add Feed Schedule',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  final t = await showTimePicker(context: ctx, initialTime: selectedTime);
                  if (t != null) setSheet(() => selectedTime = t);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(children: [
                    const Icon(Icons.access_time, color: kGreen),
                    const SizedBox(width: 10),
                    Text('Time: ${selectedTime.format(ctx)}',
                        style: const TextStyle(fontSize: 15)),
                  ]),
                ),
              ),
              const SizedBox(height: 12),
              _field(feedCtrl, 'Feed Name (e.g. Green Fodder)', Icons.grass),
              const SizedBox(height: 12),
              _field(animalsCtrl, 'For which animals?', Icons.pets),
              const SizedBox(height: 12),
              _field(qtyCtrl, 'Quantity (e.g. 20 kg)', Icons.scale),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kGreen,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () {
                    if (feedCtrl.text.isNotEmpty) {
                      setState(() {
                        _feedItems.add(FeedItem(
                          time: selectedTime.format(context),
                          feed: feedCtrl.text,
                          animals: animalsCtrl.text.isEmpty ? 'All Animals' : animalsCtrl.text,
                          qty: qtyCtrl.text.isEmpty ? '—' : qtyCtrl.text,
                          done: false,
                        ));
                      });
                      Navigator.pop(ctx);
                    }
                  },
                  child: const Text('Add Schedule',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController ctrl, String label, IconData icon) {
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: kGreen),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _dropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      items: items.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
      onChanged: onChanged,
    );
  }
}

// ─────────────────────────────────────────────
//  TAB 1 — MY ANIMALS
// ─────────────────────────────────────────────
class _AnimalsTab extends StatelessWidget {
  final List<Animal> animals;
  final void Function(Animal) onAdd;
  const _AnimalsTab({required this.animals, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final healthy = animals.where((a) => a.health == 'Healthy').length;
    final sick = animals.where((a) => a.health != 'Healthy').length;

    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              _summaryChip('${animals.length} Total', Colors.grey),
              const SizedBox(width: 10),
              _summaryChip('$healthy Healthy', kGreen),
              const SizedBox(width: 10),
              _summaryChip('$sick Sick', Colors.red),
            ],
          ),
        ),
        Expanded(
          child: animals.isEmpty
              ? const Center(
              child: Text('No animals registered.\nTap + to add.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 15)))
              : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: animals.length,
            itemBuilder: (_, i) {
              final a = animals[i];
              final isSick = a.health != 'Healthy';
              final color = isSick ? Colors.orange : kGreen;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border(left: BorderSide(color: color, width: 4)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: isSick ? Colors.orange.shade50 : kLightGreen,
                        radius: 24,
                        child: Icon(Icons.pets,
                            color: isSick ? Colors.orange : kDarkGreen, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(a.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15)),
                            const SizedBox(height: 3),
                            Text('${a.type}  •  ${a.breed}  •  ${a.age}',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                            const SizedBox(height: 3),
                            Row(children: [
                              const Icon(Icons.water_drop, size: 12, color: Colors.blue),
                              const SizedBox(width: 4),
                              Text(a.milk,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black87)),
                            ]),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isSick ? '⚠️ ${a.health}' : '✅ ${a.health}',
                          style: TextStyle(
                              color: color,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
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

  Widget _summaryChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(label,
          style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}

// ─────────────────────────────────────────────
//  TAB 2 — FEED SCHEDULE
// ─────────────────────────────────────────────
class _FeedTab extends StatelessWidget {
  final List<FeedItem> feedItems;
  final void Function(int) onToggle;
  final void Function(BuildContext) onAdd;
  const _FeedTab({required this.feedItems, required this.onToggle, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final done = feedItems.where((f) => f.done).length;
    final total = feedItems.length;

    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Today's Progress",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700)),
                  Text('$done / $total completed',
                      style: const TextStyle(
                          color: kGreen, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: total == 0 ? 0 : done / total,
                  backgroundColor: Colors.grey.shade200,
                  color: kGreen,
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: feedItems.isEmpty
              ? const Center(
              child: Text('No feed schedule.\nTap + to add.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 15)))
              : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: feedItems.length,
            itemBuilder: (_, i) {
              final f = feedItems[i];
              return GestureDetector(
                onTap: () => onToggle(i),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: f.done ? kGreen.withOpacity(0.4) : Colors.grey.shade200,
                    ),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: f.done ? kGreen : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: f.done ? kGreen : Colors.grey.shade400,
                                width: 2),
                          ),
                          child: f.done
                              ? const Icon(Icons.check, color: Colors.white, size: 16)
                              : null,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(f.feed,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    decoration: f.done
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color: f.done ? Colors.grey : Colors.black87,
                                  )),
                              const SizedBox(height: 3),
                              Text('${f.animals}  •  ${f.qty}',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: kLightGreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(f.time,
                              style: const TextStyle(
                                  color: kDarkGreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
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
class Appointment {
  final String time, farmer, animal, issue, farm;
  String status;
  Appointment({
    required this.time,
    required this.farmer,
    required this.animal,
    required this.issue,
    required this.farm,
    required this.status,
  });
}

class Prescription {
  final String animal, farmer, diagnosis, medicine, followUp, severity, date;
  Prescription({
    required this.animal,
    required this.farmer,
    required this.diagnosis,
    required this.medicine,
    required this.followUp,
    required this.severity,
    required this.date,
  });
}

// ─────────────────────────────────────────────
//  VET DASHBOARD
// ─────────────────────────────────────────────
class VetDashboard extends StatefulWidget {
  const VetDashboard({super.key});
  @override
  State<VetDashboard> createState() => _VetDashboardState();
}

class _VetDashboardState extends State<VetDashboard> {
  int _currentIndex = 0;

  final List<Appointment> _appointments = [
    Appointment(time: '9:00 AM', farmer: 'Ravi Kumar', animal: 'HF Cow – Lakshmi', issue: 'Mastitis', farm: 'Guntur', status: 'Done'),
    Appointment(time: '10:30 AM', farmer: 'Suresh Babu', animal: 'Murrah Buffalo', issue: 'Routine Checkup', farm: 'Tenali', status: 'Done'),
    Appointment(time: '12:00 PM', farmer: 'Anand Rao', animal: 'Goat (x3)', issue: 'FMD Vaccination', farm: 'Vijayawada', status: 'Ongoing'),
    Appointment(time: '2:30 PM', farmer: 'Venkat Naidu', animal: 'Gir Cow – Rani', issue: 'Lameness', farm: 'Krishna Dist.', status: 'Upcoming'),
    Appointment(time: '4:00 PM', farmer: 'Mohan Das', animal: 'Pig (Large White)', issue: 'Skin Infection', farm: 'Eluru', status: 'Upcoming'),
  ];

  final List<Prescription> _prescriptions = [
    Prescription(animal: 'Holstein Cow', farmer: 'Ravi K.', diagnosis: 'Mastitis', medicine: 'Amoxicillin 500mg', followUp: '27 Mar', severity: 'Moderate', date: '20 Mar'),
    Prescription(animal: 'Goat x5', farmer: 'Priya S.', diagnosis: 'FMD Prevention', medicine: 'FMD Vaccine', followUp: 'Done', severity: 'Low', date: '19 Mar'),
    Prescription(animal: 'Buffalo Calf', farmer: 'Suresh B.', diagnosis: 'Pneumonia', medicine: 'Oxytetracycline', followUp: '25 Mar', severity: 'High', date: '18 Mar'),
    Prescription(animal: 'Sheep x8', farmer: 'Ramesh T.', diagnosis: 'Worm Infestation', medicine: 'Albendazole', followUp: '30 Mar', severity: 'Moderate', date: '15 Mar'),
  ];

  void _addPrescription(Prescription p) => setState(() => _prescriptions.insert(0, p));
  void _markAppointment(int i, String status) =>
      setState(() => _appointments[i].status = status);

  @override
  Widget build(BuildContext context) {
    final pages = [
      _AppointmentsTab(
        appointments: _appointments,
        onMark: _markAppointment,
        onAdd: _showAddAppointmentSheet,
      ),
      _PrescriptionsTab(
        prescriptions: _prescriptions,
        onAdd: _showAddPrescriptionSheet,
      ),
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
          ['Appointments', 'Prescriptions'][_currentIndex],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
              child: Text('V', style: TextStyle(color: kGreen, fontWeight: FontWeight.bold)),
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
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Appointments'),
          BottomNavigationBarItem(
              icon: Icon(Icons.medication), label: 'Prescriptions'),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: kGreen,
        onPressed: () => _currentIndex == 0
            ? _showAddAppointmentSheet(context)
            : _showAddPrescriptionSheet(context),
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
            accountName: const Text('Dr. Sharma',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            accountEmail: const Text('vet@animalhub.com'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.medical_services, color: kDarkGreen, size: 30),
            ),
          ),
          _tile(Icons.calendar_today, 'Appointments', 0, context),
          _tile(Icons.medication, 'Prescriptions', 1, context),
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

  // ── Add Appointment Sheet ──
  void _showAddAppointmentSheet(BuildContext context) {
    final farmerCtrl = TextEditingController();
    final animalCtrl = TextEditingController();
    final issueCtrl = TextEditingController();
    final farmCtrl = TextEditingController();
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
          builder: (ctx, setSheet) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('New Appointment',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () async {
                    final t = await showTimePicker(
                        context: ctx, initialTime: selectedTime);
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
                _field(farmerCtrl, 'Farmer Name', Icons.person),
                const SizedBox(height: 12),
                _field(animalCtrl, 'Animal / Patient', Icons.pets),
                const SizedBox(height: 12),
                _field(issueCtrl, 'Issue / Reason', Icons.medical_services),
                const SizedBox(height: 12),
                _field(farmCtrl, 'Farm Location', Icons.location_on),
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
                      if (farmerCtrl.text.isNotEmpty && animalCtrl.text.isNotEmpty) {
                        setState(() {
                          _appointments.add(Appointment(
                            time: selectedTime.format(context),
                            farmer: farmerCtrl.text,
                            animal: animalCtrl.text,
                            issue: issueCtrl.text.isEmpty ? '—' : issueCtrl.text,
                            farm: farmCtrl.text.isEmpty ? '—' : farmCtrl.text,
                            status: 'Upcoming',
                          ));
                        });
                        Navigator.pop(ctx);
                      }
                    },
                    child: const Text('Add Appointment',
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

  // ── Add Prescription Sheet ──
  void _showAddPrescriptionSheet(BuildContext context) {
    final animalCtrl = TextEditingController();
    final farmerCtrl = TextEditingController();
    final diagCtrl = TextEditingController();
    final medCtrl = TextEditingController();
    final followUpCtrl = TextEditingController();
    String selectedSeverity = 'Low';

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
                const Text('New Prescription',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _field(animalCtrl, 'Animal / Patient', Icons.pets),
                const SizedBox(height: 12),
                _field(farmerCtrl, 'Farmer Name', Icons.person),
                const SizedBox(height: 12),
                _field(diagCtrl, 'Diagnosis', Icons.coronavirus_outlined),
                const SizedBox(height: 12),
                _field(medCtrl, 'Medicine / Treatment', Icons.medication),
                const SizedBox(height: 12),
                _field(followUpCtrl, 'Follow-up Date (e.g. 30 Mar)', Icons.event),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedSeverity,
                  decoration: InputDecoration(
                    labelText: 'Severity',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  items: ['Low', 'Moderate', 'High']
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (v) => setSheet(() => selectedSeverity = v!),
                ),
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
                      if (animalCtrl.text.isNotEmpty && diagCtrl.text.isNotEmpty) {
                        _addPrescription(Prescription(
                          animal: animalCtrl.text,
                          farmer: farmerCtrl.text.isEmpty ? '—' : farmerCtrl.text,
                          diagnosis: diagCtrl.text,
                          medicine: medCtrl.text.isEmpty ? '—' : medCtrl.text,
                          followUp: followUpCtrl.text.isEmpty ? 'TBD' : followUpCtrl.text,
                          severity: selectedSeverity,
                          date: 'Today',
                        ));
                        Navigator.pop(ctx);
                      }
                    },
                    child: const Text('Save Prescription',
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
}

// ─────────────────────────────────────────────
//  TAB 1 — APPOINTMENTS
// ─────────────────────────────────────────────
class _AppointmentsTab extends StatelessWidget {
  final List<Appointment> appointments;
  final void Function(int, String) onMark;
  final void Function(BuildContext) onAdd;
  const _AppointmentsTab(
      {required this.appointments, required this.onMark, required this.onAdd});

  Color _statusColor(String s) {
    switch (s) {
      case 'Done': return kGreen;
      case 'Ongoing': return Colors.orange;
      default: return Colors.blue;
    }
  }

  IconData _statusIcon(String s) {
    switch (s) {
      case 'Done': return Icons.check_circle;
      case 'Ongoing': return Icons.timelapse;
      default: return Icons.schedule;
    }
  }

  @override
  Widget build(BuildContext context) {
    final done = appointments.where((a) => a.status == 'Done').length;
    final ongoing = appointments.where((a) => a.status == 'Ongoing').length;
    final upcoming = appointments.where((a) => a.status == 'Upcoming').length;

    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _countBox('$done', 'Done', kGreen),
              _countBox('$ongoing', 'Ongoing', Colors.orange),
              _countBox('$upcoming', 'Upcoming', Colors.blue),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: appointments.length,
            itemBuilder: (_, i) {
              final a = appointments[i];
              final color = _statusColor(a.status);
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            const Icon(Icons.access_time, size: 14, color: kDarkGreen),
                            const SizedBox(width: 4),
                            Text(a.time,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kDarkGreen,
                                    fontSize: 14)),
                            const SizedBox(width: 10),
                            Text(a.farmer,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14)),
                          ]),
                          GestureDetector(
                            onTap: () {
                              final next = a.status == 'Upcoming'
                                  ? 'Ongoing'
                                  : a.status == 'Ongoing'
                                  ? 'Done'
                                  : 'Done';
                              onMark(i, next);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(children: [
                                Icon(_statusIcon(a.status), color: color, size: 13),
                                const SizedBox(width: 4),
                                Text(a.status,
                                    style: TextStyle(
                                        color: color,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(a.animal,
                          style: const TextStyle(color: Colors.black87, fontSize: 13)),
                      const SizedBox(height: 3),
                      Row(children: [
                        const Icon(Icons.medical_services_outlined,
                            size: 12, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(a.issue,
                            style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        const SizedBox(width: 10),
                        const Icon(Icons.location_on, size: 12, color: Colors.grey),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(a.farm,
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ]),
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

  Widget _countBox(String value, String label, Color color) {
    return Column(children: [
      Text(value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
      Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
    ]);
  }
}

// ─────────────────────────────────────────────
//  TAB 2 — PRESCRIPTIONS
// ─────────────────────────────────────────────
class _PrescriptionsTab extends StatelessWidget {
  final List<Prescription> prescriptions;
  final void Function(BuildContext) onAdd;
  const _PrescriptionsTab({required this.prescriptions, required this.onAdd});

  Color _severityColor(String s) {
    switch (s) {
      case 'High': return Colors.red;
      case 'Moderate': return Colors.orange;
      default: return kGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return prescriptions.isEmpty
        ? const Center(
        child: Text('No prescriptions yet.\nTap + to add.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 15)))
        : ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: prescriptions.length,
      itemBuilder: (_, i) {
        final p = prescriptions[i];
        final color = _severityColor(p.severity);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(p.animal,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(p.severity,
                          style: TextStyle(
                              color: color,
                              fontSize: 11,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Farmer: ${p.farmer}  •  Date: ${p.date}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const Divider(height: 14),
                _infoRow(Icons.coronavirus_outlined, 'Diagnosis', p.diagnosis),
                const SizedBox(height: 6),
                _infoRow(Icons.medication, 'Medicine', p.medicine),
                const SizedBox(height: 6),
                _infoRow(
                  Icons.event,
                  'Follow-up',
                  p.followUp,
                  valueColor: p.followUp == 'Done' ? Colors.grey : kDarkGreen,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoRow(IconData icon, String label, String value,
      {Color? valueColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15, color: Colors.grey),
        const SizedBox(width: 6),
        Text('$label: ', style: const TextStyle(color: Colors.grey, fontSize: 13)),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: valueColor ?? Colors.black87)),
        ),
      ],
    );
  }
}
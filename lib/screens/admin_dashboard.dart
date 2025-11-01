import 'package:flutter/material.dart';
import '../models/donation_request_model.dart';
import '../widgets/custom_button.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  // 🔄 Mock donation requests (Replace with Firestore later)
  final List<DonationRequest> _requests = [
    DonationRequest(
      name: "Ali Khan",
      email: "ali@example.com",
      description: "Need funds for school supplies.",
      amount: 200,
      status: "Pending",
    ),
    DonationRequest(
      name: "Sara Malik",
      email: "sara@example.com",
      description: "Medical treatment assistance.",
      amount: 500,
      status: "Approved",
    ),
  ];

  void _approveRequest(int index) {
    setState(() {
      _requests[index].status = "Approved";
    });
  }

  void _rejectRequest(int index) {
    setState(() {
      _requests[index].status = "Rejected";
    });
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Donation Requests",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _requests.isEmpty
                  ? const Center(child: Text("No requests available."))
                  : ListView.builder(
                      itemCount: _requests.length,
                      itemBuilder: (context, index) {
                        final request = _requests[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  request.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("Email: ${request.email}"),
                                const SizedBox(height: 8),
                                Text("Reason: ${request.description}"),
                                Text("Amount: \$${request.amount}"),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Status: ${request.status}",
                                      style: TextStyle(
                                        color: request.status == "Approved"
                                            ? Colors.green
                                            : request.status == "Rejected"
                                                ? Colors.red
                                                : Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.check_circle,
                                              color: Colors.green),
                                          onPressed: () => _approveRequest(index),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.cancel,
                                              color: Colors.red),
                                          onPressed: () => _rejectRequest(index),
                                        ),
                                      ],
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
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.indigo,
        onPressed: () {},
        label: const Text("Add Admin"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

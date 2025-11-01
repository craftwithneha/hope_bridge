import 'package:flutter/material.dart';

class DonorFeed extends StatefulWidget {
  const DonorFeed({super.key});

  @override
  State<DonorFeed> createState() => _DonorFeedState();
}

class _DonorFeedState extends State<DonorFeed> {
  // Mock data for now — later will come from Firestore
  final List<Map<String, dynamic>> donationRequests = [
    {
      "name": "Ali Khan",
      "category": "Medical",
      "amount": "15,000 PKR",
      "description": "Need funds for surgery and post-operation treatment.",
      "status": "Pending",
    },
    {
      "name": "Sara Ahmed",
      "category": "Education",
      "amount": "8,000 PKR",
      "description":
          "Looking for help to pay university semester fee due this month.",
      "status": "Approved",
    },
    {
      "name": "Rizwan Malik",
      "category": "Food",
      "amount": "5,000 PKR",
      "description":
          "Providing ration packs to 10 families affected by floods.",
      "status": "Pending",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donor Feed"),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: donationRequests.length,
        itemBuilder: (context, index) {
          final request = donationRequests[index];
          return _buildDonationCard(request);
        },
      ),
    );
  }

  Widget _buildDonationCard(Map<String, dynamic> request) {
    Color statusColor =
        request["status"] == "Approved" ? Colors.green : Colors.orange;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                request["name"],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  request["status"],
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Text(
            "Category: ${request["category"]}",
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Text(
            "Required Amount: ${request["amount"]}",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            request["description"],
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  // TODO: Integrate donation action
                },
                icon: const Icon(Icons.favorite_border, color: Colors.indigo),
                label: const Text(
                  "Donate",
                  style: TextStyle(color: Colors.indigo),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

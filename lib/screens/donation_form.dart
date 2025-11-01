import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class DonationForm extends StatefulWidget {
  const DonationForm({super.key});

  @override
  State<DonationForm> createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isSubmitting = false;
  String? _selectedCategory;
  String? _uploadedFileName;

  final List<String> _categories = [
    "Medical",
    "Education",
    "Food",
    "Shelter",
    "Other"
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _reasonController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    // TODO: Connect with FirestoreService later
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isSubmitting = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Donation request submitted successfully 🎉"),
          backgroundColor: Colors.indigo,
        ),
      );
      Navigator.pop(context);
    }
  }

  void _pickFile() async {
    // TODO: Integrate with Firebase Storage later
    setState(() {
      _uploadedFileName = "document_proof.pdf";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donation Request Form"),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Fill out the form below to submit your request.",
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration("Full Name", Icons.person),
                validator: (value) =>
                    value!.isEmpty ? "Please enter your name" : null,
              ),
              const SizedBox(height: 16),

              // Reason Field
              TextFormField(
                controller: _reasonController,
                decoration: _inputDecoration("Reason for Donation", Icons.help),
                validator: (value) =>
                    value!.isEmpty ? "Please enter a reason" : null,
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: _inputDecoration("Category", Icons.category),
                items: _categories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) =>
                    value == null ? "Please select a category" : null,
              ),
              const SizedBox(height: 16),

              // Amount Field
              TextFormField(
                controller: _amountController,
                decoration: _inputDecoration("Required Amount", Icons.attach_money),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? "Please enter an amount" : null,
              ),
              const SizedBox(height: 16),

              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: _inputDecoration("Description", Icons.description),
                maxLines: 4,
                validator: (value) =>
                    value!.isEmpty ? "Please enter description" : null,
              ),
              const SizedBox(height: 20),

              // File Upload
              GestureDetector(
                onTap: _pickFile,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _uploadedFileName ?? "Upload supporting document",
                        style: TextStyle(
                          color: _uploadedFileName != null
                              ? Colors.black87
                              : Colors.grey[600],
                        ),
                      ),
                      const Icon(Icons.upload_file, color: Colors.indigo),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Submit Button
              CustomButton(
                text: "Submit Request",
                icon: Icons.send,
                isLoading: _isSubmitting,
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.indigo),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

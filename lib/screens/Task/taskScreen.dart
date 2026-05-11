import 'package:flutter/material.dart';
import '../../services/taskService.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() =>
      _TaskScreenState();
}

class _TaskScreenState
    extends State<TaskScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController =TextEditingController();
  final TextEditingController descriptionController =TextEditingController();
  final TextEditingController githubController = TextEditingController();

  bool isLoading = false;

  void handleSubmitTask() async {

    setState(() {
      isLoading = true;
    });

    bool success =
        await TaskService().submitTask(
      name: nameController.text,
      price: priceController.text,
      description: descriptionController.text,
      githubUrl: githubController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;

    if (success) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Tugas berhasil disubmit"),
        ),
      );

      Navigator.pop(context);

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Submit gagal"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:const Color(0xffeef2ff),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Submit Tugas",
          style: TextStyle(
            color: Color(0xff0f172a),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xff0f172a),
        ),
      ),

      body: Stack(
        children: [
          Positioned(
            top: -100,
            left: -80,
            child: Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    const Color(0xffc4b5fd)
                        .withOpacity(0.35),
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            right: -90,
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    const Color(0xff93c5fd).withOpacity(0.30),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Submit Project",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0f172a),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 35),
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.75),
                      borderRadius:
                          BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.black.withOpacity(0.08),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: "Nama Produk",
                            filled: true,
                            fillColor:const Color(0xfff8fafc),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                        TextField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Harga Produk",
                            filled: true,
                            fillColor:const Color(0xfff8fafc),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                        TextField(
                          controller:
                              descriptionController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText:
                                "Deskripsi Produk",
                            filled: true,
                            fillColor:const Color(0xfff8fafc),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                        TextField(
                          controller: githubController,
                          decoration: InputDecoration(
                            hintText:
                                "GitHub Repository URL",
                            filled: true,
                            fillColor:const Color(0xfff8fafc),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),
                        SizedBox(
                          width: double.infinity,
                          height: 58,
                          child: ElevatedButton(
                            onPressed:
                                isLoading
                                    ? null
                                    : handleSubmitTask,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:const Color(0xff111827),
                              foregroundColor:Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                  22,
                                ),
                              ),
                            ),

                            child:
                                isLoading
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child:
                                            CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color:Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        "Submit Tugas",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                              FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                      ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
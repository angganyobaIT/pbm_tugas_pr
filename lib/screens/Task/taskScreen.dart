import 'package:flutter/material.dart';
import '../../services/taskService.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() =>
      _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController nameController =TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController=TextEditingController();
  final TextEditingController githubController =TextEditingController();

  bool isLoading = false;
  void showMessage({
    required String title,
    required String message,
    required Color color,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(25),
          ),
          title: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: color,
              ),
              const SizedBox(width: 10),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "OK",
                style: TextStyle(
                  color: color,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  void handleSubmitTask() async {
    if (nameController.text.isEmpty || priceController.text.isEmpty || descriptionController.text.isEmpty || githubController.text.isEmpty) {
      showMessage(

        title: "Peringatan",
        message:
            "Semua data wajib diisi.",
        color: Colors.orange,
      );
      return;
    }

    if (int.tryParse(priceController.text) ==
        null) {
      showMessage(
        title: "Harga Tidak Valid",
        message:
            "Harga produk harus berupa angka.",
        color: Colors.red,
      );
      return;
    }
    if (!githubController.text.contains(
      "github.com",
    )) {
      showMessage(
        title: "Link GitHub Tidak Valid",
        message:
            "Masukkan link repository yang valid.",
        color: Colors.red,
      );
      return;
    }
    setState(() {
      isLoading = true;
    });

    bool success =
        await TaskService().submitTask(
      name: nameController.text,
      price: priceController.text,
      description:
          descriptionController.text,
      githubUrl:
          githubController.text,
    );
    setState(() {
      isLoading = false;
    });
    if (!mounted) return;
    if (success) {
      showMessage(
        title: "Berhasil",
        message:
            "Tugas berhasil disubmit.",
        color: Colors.green,
      );
      Future.delayed(
        const Duration(seconds: 1),
        () {
          Navigator.pop(context);
        },
      );
    } else {
      showMessage(
        title: "Submit Gagal",
        message:
            "Terjadi kesalahan saat submit tugas.",
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xffeef2ff),
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
                    const Color(0xff93c5fd)
                        .withOpacity(0.30),
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
                  const Text(
                    "Sudah Waktunya Submit Le.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff64748b),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 35),
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color:
                          Colors.white.withOpacity(
                        0.75,
                      ),
                      borderRadius:
                          BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.black.withOpacity(
                            0.08,
                          ),
                          blurRadius: 30,
                          offset:
                              const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller:
                              nameController,
                          decoration:
                              InputDecoration(
                            hintText:
                                "Nama Produk",
                            filled: true,
                            fillColor:
                                const Color(
                              0xfff8fafc,
                            ),
                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                20,
                              ),
                              borderSide:
                                  BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        TextField(
                          controller:
                              priceController,
                          keyboardType:
                              TextInputType.number,
                          decoration:
                              InputDecoration(
                            hintText:
                                "Harga Produk",
                            filled: true,
                            fillColor:
                                const Color(
                              0xfff8fafc,
                            ),
                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                20,
                              ),
                              borderSide:
                                  BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),
                        TextField(
                          controller:
                              descriptionController,
                          maxLines: 5,
                          decoration:
                              InputDecoration(
                            hintText:
                                "Deskripsi Produk",
                            filled: true,
                            fillColor:
                                const Color(
                              0xfff8fafc,
                            ),
                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                20,
                              ),
                              borderSide:
                                  BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),
                        TextField(
                          controller:
                              githubController,
                          decoration:
                              InputDecoration(
                            hintText:
                                "GitHub Repository URL",
                            filled: true,
                            fillColor:
                                const Color(
                              0xfff8fafc,
                            ),
                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                20,
                              ),
                              borderSide:
                                  BorderSide.none,
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
                            style:
                                ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                                  const Color(
                                0xff111827,
                              ),
                              foregroundColor:
                                  Colors.white,
                              shape:
                                  RoundedRectangleBorder(
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
                                          color:
                                              Colors.white,
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
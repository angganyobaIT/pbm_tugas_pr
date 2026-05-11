import 'package:flutter/material.dart';
import '../../services/productService.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() =>
      _ProductAddScreenState();
}

class _ProductAddScreenState
    extends State<ProductAddScreen> {
  final TextEditingController nameController =TextEditingController();
  final TextEditingController priceController =TextEditingController();
  final TextEditingController descriptionController =TextEditingController();

  bool isLoading = false;

  void handleAddProduct() async {

    setState(() {
      isLoading = true;
    });

    bool success =
        await ProductService().addProduct(
      name: nameController.text,
      price: int.parse(priceController.text),
      description: descriptionController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;

    if (success) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Produk berhasil ditambahkan"),
        ),
      );

      Navigator.pop(context);

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Gagal menambahkan produk"),
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
          "Tambah Produk",
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
                    const Color(0xffc4b5fd).withOpacity(0.35),
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
                    "Buat Produk Baru",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0f172a),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Waktunya tambahkan produk kamu.",
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
                          keyboardType:
                              TextInputType.number,
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
                            fillColor:
                                const Color(0xfff8fafc),
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
                                    : handleAddProduct,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                                  const Color(0xff111827),
                              foregroundColor:
                                  Colors.white,
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
                                          color:
                                              Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        "Tambah Produk",
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
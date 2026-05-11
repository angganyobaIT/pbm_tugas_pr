import 'package:flutter/material.dart';
import '../../models/productModel.dart';
import '../../services/productService.dart';
import '../../services/auth.dart';
import '../Auth/loginScreen.dart';
import '../Products/productAddScreen.dart';
import '../Task/taskScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}
class _HomeScreenState
    extends State<HomeScreen> {
  List<ProductModel> products = [];
  bool isLoading = true;
  void getProducts() async {
    products.clear();
    products =
        await ProductService().getProducts();
    setState(() {
      isLoading = false;
    });
  }
  void handleDelete(int id) async {
    bool success =
        await ProductService().deleteProduct(id);
    if (!mounted) return;
    if (success) {
      getProducts();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Produk berhasil dihapus"),
        ),
      );
    } 
    else 
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Gagal menghapus produk"),
        ),
      );
    }
  }
  void handleLogout() async {
    await AuthService().logout();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const LoginScreen(),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    getProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xffeef2ff),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Dashboard",
          style: TextStyle(
            color: Color(0xff0f172a),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 12,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: IconButton(
                onPressed: handleLogout,
                icon: const Icon(
                  Icons.logout,
                  color: Color(0xff0f172a),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment:
            MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "add",
            backgroundColor:const Color(0xff111827),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const ProductAddScreen(),
                ),
              );
              getProducts();
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: "submit",
            backgroundColor:const Color(0xff8b5cf6),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const TaskScreen(),
                ),
              );
            },
            child: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(
                  child:
                      CircularProgressIndicator(),
                )
              : products.isEmpty
                  ? const Center(
                      child:
                          Text("Belum ada produk"),
                    )
                  : Padding(
                      padding:
                          const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Produk Kamu",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight:
                                  FontWeight.bold,
                              color:
                                  Color(0xff0f172a),
                            ),
                          ),

                          const SizedBox(height: 8),
                          const Text(
                            "Kelola draft produk dengan mudah",
                            style: TextStyle(
                              fontSize: 15,
                              color:
                                  Color(0xff64748b),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Expanded(
                            child: ListView.builder(
                              itemCount:
                                  products.length,
                              itemBuilder:
                                  (context, index) {
                                ProductModel product =
                                    products[index];
                                return Container(
                                  margin:
                                      const EdgeInsets.only(
                                    bottom: 18,
                                  ),
                                  padding:
                                      const EdgeInsets.all(
                                    22,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(
                                      30,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withOpacity(
                                          0.05,
                                        ),
                                        blurRadius: 20,
                                        offset:
                                            const Offset(
                                          0,
                                          10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              product.name,
                                              style:
                                                  const TextStyle(
                                                fontSize: 20,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                                color:
                                                    Color(
                                                  0xff0f172a,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration:
                                                BoxDecoration(
                                              color:
                                                  const Color(
                                                0xffffe4e6,
                                              ),
                                              borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                15,
                                              ),
                                            ),
                                            child: IconButton(
                                              onPressed: () {
                                                handleDelete(
                                                  product.id,
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.delete_outline,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 18,
                                          vertical: 10,
                                        ),
                                        decoration:
                                            BoxDecoration(
                                          gradient:
                                              const LinearGradient(
                                            colors: [Color(0xff60a5fa,),Color(0xff8b5cf6,),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius
                                                  .circular(
                                            16,
                                          ),
                                        ),
                                        child: Text(
                                          "Rp ${product.price.replaceAll('.00', '')}",
                                          style:
                                              const TextStyle(
                                            color:
                                                Colors.white,
                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      Text(
                                        product.description,
                                        style:
                                            const TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color(0xff64748b),
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }
}
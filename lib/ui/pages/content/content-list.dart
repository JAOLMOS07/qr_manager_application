import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_manager_application/domain/models/content.dart';
import 'package:qr_manager_application/services/content_service.dart';

class ContentListPage extends StatefulWidget {
  const ContentListPage({super.key});

  @override
  _ContentListPageState createState() => _ContentListPageState();
}

class _ContentListPageState extends State<ContentListPage> {
  final TextEditingController _searchController = TextEditingController();
  final FireStoreContentService fireStoreContentService =
      FireStoreContentService();
  List<Content> _contents = [];
  List<Content> _allContents = [];
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchContents();
  }

  Future<void> _fetchContents() async {
    setState(() {
      _isLoading = true;
    });
    _allContents = await fireStoreContentService.getContents();
    _contents = List.from(_allContents);
    setState(() {
      _isLoading = false;
    });
  }

  void _filterContents(String query) {
    if (query.isEmpty) {
      setState(() {
        _contents = List.from(_allContents);
      });
    } else {
      setState(() {
        _contents = _allContents.where((content) {
          return content.title.toLowerCase().contains(query.toLowerCase()) ||
              content.description.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/fondo1.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      _filterContents(value);
                    },
                    style: TextStyle(
                      color: Color.fromARGB(251, 89, 123, 236),
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        color: Color.fromARGB(184, 89, 123, 236),
                      ),
                      hintText: "Buscar contenido",
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _isLoading
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                itemCount: _contents.length,
                                itemBuilder: (context, index) {
                                  return CustomContentItem(
                                    content: _contents[index],
                                  );
                                },
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.toNamed('/content/create');
          _fetchContents();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CustomContentItem extends StatelessWidget {
  final Content content;

  const CustomContentItem({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 5),
          leading: Container(
            width: 80,
            height: 80,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(content.logoUrl),
            ),
          ),
          title: Text(
            content.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            content.description,
            style: TextStyle(fontSize: 14),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ),
    );
  }
}

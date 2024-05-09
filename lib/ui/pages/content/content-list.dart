import 'package:flutter/material.dart';

class ContentListPage extends StatelessWidget {
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
                      hintText: "Type in your text",
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Card(
                      elevation: 4, // Añade una sombra a la card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          children: [
                            CustomContentItem(
                              title: 'Contenido 1',
                              subtitle: 'Descripción del contenido 1',
                              logo: 'assets/fondo1.png',
                            ),
                            CustomContentItem(
                              title: 'Contenido 2',
                              subtitle: 'Descripción del contenido 2',
                              logo: 'assets/fondo1.png',
                            ),
                            CustomContentItem(
                              title: 'Contenido 3',
                              subtitle: 'Descripción del contenido 3',
                              logo: 'assets/fondo1.png',
                            ),
                            // Agrega más CustomContentItem según sea necesario
                          ],
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
    );
  }
}

class CustomContentItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String logo;

  const CustomContentItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.logo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
      child: Container(
        height: 100, // Ajusta la altura del elemento
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 5),
          leading: Container(
            width: 80, // Ajusta el ancho del contenedor del logo
            height: 80, // Ajusta la altura del contenedor del logo
            child: CircleAvatar(
              radius: 20, // Ajusta el tamaño del logo
              backgroundImage: AssetImage(logo),
              backgroundColor: Colors.transparent,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold, // Ajusta el tamaño y estilo del título
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontSize: 14), // Ajusta el tamaño del subtítulo
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Acción al hacer clic en el elemento de contenido
          },
        ),
      ),
    );
  }
}

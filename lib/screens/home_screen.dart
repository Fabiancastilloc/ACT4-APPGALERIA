import 'package:flutter/material.dart';
import 'package:galeria_reales/models/image_model.dart';
import 'package:galeria_reales/models/video_model.dart';
import 'package:galeria_reales/providers/pixabay_provider.dart';
import 'package:galeria_reales/screens/image_details_screen.dart';
import 'package:galeria_reales/screens/video_details_screen.dart';
import 'package:galeria_reales/utilities/search_history.dart';
import 'package:galeria_reales/utilities/saved_images.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PixabayProvider _pixabayProvider = PixabayProvider();
  final TextEditingController _searchController = TextEditingController();
  late List<ImageModel> _images;
  late List<VideoModel> _videos;
  late bool _showImages;
  bool _loading = false;
  final SearchHistory _searchHistory = SearchHistory();
  final SavedImages _savedImages = SavedImages();

  @override
  void initState() {
    super.initState();
    _images = [];
    _videos = [];
    _showImages = true;
    _loadImages();
  }

  Future<void> _loadImages() async {
    setState(() {
      _loading = true;
    });
    final images = await _pixabayProvider.getImages('nature');
    setState(() {
      _images = images;
      _loading = false;
    });
  }

  Future<void> _loadVideos() async {
    setState(() {
      _loading = true;
    });
    final videos = await _pixabayProvider.getVideos('travel');
    setState(() {
      _videos = videos;
      _loading = false;
    });
  }

  Future<void> _searchMedia() async {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      setState(() {
        _loading = true;
        _searchHistory.addToHistory(query);
      });
      if (_showImages) {
        final images = await _pixabayProvider.getImages(query);
        setState(() {
          _images = images;
          _loading = false;
        });
      } else {
        final videos = await _pixabayProvider.getVideos(query);
        setState(() {
          _videos = videos;
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galería Reales'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              // Lógica para cerrar sesión
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
        backgroundColor: Colors.deepPurple,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Historial de búsqueda'),
              onTap: () {
                // Mostrar historial de búsqueda
                _showSearchHistory();
              },
            ),
            ListTile(
              title: Text('Imágenes Guardadas'),
              onTap: () {
                // Mostrar imágenes guardadas
                _showSavedImages();
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Buscar',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchMedia,
                ),
              ],
            ),
          ),
          ToggleButtons(
            color: Colors.deepPurple,
            selectedColor: Colors.white,
            fillColor: Colors.deepPurpleAccent,
            children: [
              Icon(Icons.image),
              Icon(Icons.videocam),
            ],
            isSelected: [_showImages, !_showImages],
            onPressed: (index) {
              setState(() {
                _showImages = index == 0;
                if (_showImages) {
                  if (_images.isEmpty) {
                    _loadImages();
                  }
                } else {
                  if (_videos.isEmpty) {
                    _loadVideos();
                  }
                }
              });
            },
          ),
          _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: _showImages
                      ? GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: _images.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageDetailsScreen(image: _images[index]),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                                        child: Image.network(
                                          _images[index].webformatURL,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _images[index].tags,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.favorite),
                                      onPressed: () {
                                        // Guardar la imagen
                                        _savedImages.addImage(_images[index]);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Imagen guardada'),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : _videos.isNotEmpty
                          ? ListView.builder(
                              itemCount: _videos.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text('Video ${_videos[index].id}'),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VideoDetailsScreen(video: _videos[index]),
                                      ),
                                    );
                                  },
                                );
                              },
                            )
                          : Center(
                              child: Text('No se encontraron videos'),
                            ),
                ),
        ],
      ),
    );
  }

  void _showSearchHistory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Historial de Búsqueda'),
          content: Column(
            children: _searchHistory.history.map((query) {
              return ListTile(
                title: Text(query),
                onTap: () {
                  Navigator.pop(context);
                  _searchController.text = query;
                  _searchMedia();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showSavedImages() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Imágenes Guardadas'),
          content: Column(
            children: _savedImages.savedImages.map((image) {
              return ListTile(
                title: Text(image.tags),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageDetailsScreen(image: image),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

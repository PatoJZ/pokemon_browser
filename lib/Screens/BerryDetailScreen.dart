import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokemon_browser/services/berryServices.dart';
import 'package:pokemon_browser/details/berrydetail.dart';

class BerryDetailScreen extends StatefulWidget {
  final String berryId;

  const BerryDetailScreen({super.key, required this.berryId});

  @override
  _BerryDetailScreenState createState() => _BerryDetailScreenState();
}

class _BerryDetailScreenState extends State<BerryDetailScreen> {
  late Future<BerryDetail> berryDetailFuture;

  @override
  void initState() {
    super.initState();
    berryDetailFuture = BerryService().fetchBerryDetail(widget.berryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Berry'),
      ),
      
      body: FutureBuilder<BerryDetail>(
        future: berryDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No se encontró información'));
          }

          final berry = snapshot.data!;

          return SingleChildScrollView(
            
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nombre: ${berry.name}', style: const TextStyle(fontSize: 18)),
                  Text('ID: ${berry.id}', style: const TextStyle(fontSize: 18)),
                  Text('Firmeza: ${berry.firmness}', style: const TextStyle(fontSize: 18)),
                  Text('Tiempo de Crecimiento: ${berry.growthTime}', style: const TextStyle(fontSize: 18)),
                  Text('Cosecha Máxima: ${berry.maxHarvest}', style: const TextStyle(fontSize: 18)),
                  Text('Tamaño: ${berry.size}', style: const TextStyle(fontSize: 18)),
                  Text('Suavidad: ${berry.smoothness}', style: const TextStyle(fontSize: 18)),
                  Text('Poder Regalo Natural: ${berry.naturalGiftPower}', style: const TextStyle(fontSize: 18)),
                  Text('Tipo Regalo Natural: ${berry.naturalGiftType}', style: const TextStyle(fontSize: 18)),

                  const SizedBox(height: 16),
                  CachedNetworkImage(
                    imageUrl: berry.imageUrl,
                    width: 100,
                    height: 100,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) {
                      return const Column(
                        children: [
                          Icon(Icons.error, color: Colors.red, size: 48),
                          Text('Imagen no disponible'),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

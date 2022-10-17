import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

/// A class that loads lists of information about Bob Ross's paintings
class BobRossData {
  /// A list of Strings containing only painting names. Initially empty while
  /// data is read from file.
  List<String> paintingNames = [
    "Deep Wilderness Home",
    "Haven in the Valley",
    "Wintertime Blues",
    "Pastel Seascape",
    "Country Creek",
    "Silent Forest",
    "Autumn Images",
    "Hint of Springtime",
    "Around the Bend",
    "Valley View",
    "Tranquil Dawn",
    "Royal Majesty",
    "Serenity",
    "Cabin at Trails End",
    "Mountain Rhapsody",
    "Wilderness Cabin",
  ];

  /// A list of BobRossPainting objects containing a variety of information about
  /// each painting. Initially an empty list while data is read from file.
  List<BobRossPainting> paintings = [];

  Future<List<BobRossPainting>> getPaintings() async {
    await _loadPaintingsFromFile();
    return paintings;
  }

  /// The constructor
  BobRossData() {
    _loadPaintingsFromFile();
  }

  /// Private method to load the data from a hardcoded CSV file.
  /// Dataset from https://github.com/jwilber/Bob_Ross_Paintings
  _loadPaintingsFromFile() async {
    String myData =
        await rootBundle.loadString("assets/csv/bob_ross_paintings.csv");

    // The Csv converter automatically casts string to int where appropriate
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(myData);

    // Skips the header row
    for (List<dynamic> t in csvTable.skip(1)) {
      // Index 0 is the painting number - corresponds to image "painting#.png"
      // Index 2 is the painting name
      // Index 3 is the show season
      // Index 4 is the show episode
      // Index 5 is the number of colors used in the painting
      paintingNames.add(t[2]);

      paintings.add(BobRossPainting(
          paintingId: t[0],
          title: t[2],
          season: t[3],
          episode: t[4],
          colorCount: t[5]));
      print(
          "BobRossPainting(paintingId: ${t[0]}, title: ${t[2]}, season: ${t[3]}, episode: ${t[4]}, colorCount: ${t[5]}),");
    }
    for (String s in paintingNames) {
      print('"$s",');
    }
  }
}

/// A data class that holds a painting id, title, show season, show episode, and
/// count of colors used in the painting.
class BobRossPainting {
  const BobRossPainting(
      {required this.paintingId,
      required this.title,
      required this.season,
      required this.episode,
      required this.colorCount});

  final int paintingId;
  final String title;
  final int season;
  final int episode;
  final int colorCount;
}

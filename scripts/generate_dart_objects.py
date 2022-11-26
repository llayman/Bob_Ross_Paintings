import csv
import os

from pathlib import Path

paintings = []
with open(Path('data') / 'bob_ross_paintings.csv', newline='') as csvfile, open('dart_objects.txt', 'w+') as outfile, open('painting_names.txt', 'w+') as namefile:

    reader = csv.reader(csvfile)
    next(reader)
    # Index 0 is the painting number - corresponds to image "painting#.png"
    # Index 3 is the painting name
    # Index 4 is the show season
    # Index 5 is the show episode
    # Index 6 is the number of colors used in the painting
    for row in reader:

        # Skip paintings that do not have an image file.
        if not os.path.exists(Path('data') / 'paintings' / f'painting{row[0]}.png'):
            print(f'painting{row[0]}.png does not exist. Skipping.')
        else:
            outfile.write(f'BobRossPainting(paintingId: {row[0]}, title: "{row[3]}", season: {row[4]}, episode: {row[5]}, colorCount: {row[6]}),\n')
            namefile.write(f'"{row[3]}",\n')
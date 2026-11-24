clc;
clear;

mkdir("Analyse");

Bild = imread("samplepic0324.ppm");
Bild = rgb2gray(Bild);

% DCT-Basisfunktionen generieren, anzeigen und als Bilddateien speichern
Basisfunktionen4 = BasisfunktionenGenerieren(4);
Basisfunktionen8 = BasisfunktionenGenerieren(8);
Basisfunktionen16 = BasisfunktionenGenerieren(16);

BasisfunktionenAnzeigenSpeichern(Basisfunktionen4, 4);
BasisfunktionenAnzeigenSpeichern(Basisfunktionen8, 8);
BasisfunktionenAnzeigenSpeichern(Basisfunktionen16, 16);

% Bild in Bloecke aufteilen und DCT auf jeden Block anwenden

BildBloecke = BildInBloeckeAufteilen(Bild);

DCTBloecke = DCTAufBlockMatrix(BildBloecke, Basisfunktionen8);

% DCT-Bloecke in Matrix umformen, hat wieder gleiche Groesse wie das Bild

DCTMatrix = cell2mat(DCTBloecke);

% DCTMatrix in Datei speichern
% Datei wird fuer die Transformationen nicht gebraucht,
% Datei-Erstellung wird aber in der Aufgabenstellung gefordert

writematrix(DCTMatrix, "Analyse/DCTMatrix.dat");

% Quantisierung durchfuehren

DCTBloeckeQuantisiertFaktor10 = BlockMatrixQuantisieren(DCTBloecke, 10);
DCTBloeckeQuantisiertFaktor20 = BlockMatrixQuantisieren(DCTBloecke, 20);
DCTBloeckeQuantisiertFaktor30 = BlockMatrixQuantisieren(DCTBloecke, 30);

% Inverse DCT durchfuehren

BildBloeckeAusQuantisierterDCTFaktor10 = InverseDCTAufBlockMatrix(DCTBloeckeQuantisiertFaktor10);
BildBloeckeAusQuantisierterDCTFaktor20 = InverseDCTAufBlockMatrix(DCTBloeckeQuantisiertFaktor20);
BildBloeckeAusQuantisierterDCTFaktor30 = InverseDCTAufBlockMatrix(DCTBloeckeQuantisiertFaktor30);

% Quantisierte Bilder aus den quantisierten DCT-Bild-Bloecken erstellen

QuantisiertesBildDCTFaktor10 = cell2mat(BildBloeckeAusQuantisierterDCTFaktor10);
QuantisiertesBildDCTFaktor20 = cell2mat(BildBloeckeAusQuantisierterDCTFaktor20);
QuantisiertesBildDCTFaktor30 = cell2mat(BildBloeckeAusQuantisierterDCTFaktor30);

% Original-Bild und quantisierte DCT-Bilder anzeigen

figure("Name", "Original-Bild und quantisierte DCT-Bilder");

nexttile;
imshow(Bild, []);
title("Original");

nexttile;
imshow(QuantisiertesBildDCTFaktor10, []);
title("DCT mit Quantisierungsfaktor 10");

nexttile;
imshow(QuantisiertesBildDCTFaktor20, []);
title("DCT mit Quantisierungsfaktor 20");

nexttile;
imshow(QuantisiertesBildDCTFaktor30, []);
title("DCT mit Quantisierungsfaktor 30");

% Quantisierung ohne DCT-Transformation durchfuehren

BildBloeckeQuantisiertFaktor50 = BlockMatrixQuantisieren(BildBloecke, 50);
BildBloeckeQuantisiertFaktor100 = BlockMatrixQuantisieren(BildBloecke, 100);
BildBloeckeQuantisiertFaktor200 = BlockMatrixQuantisieren(BildBloecke, 200);

% Quantisierte Bilder aus den quantisierten Bild-Bloecken erstellen

QuantisiertesBildFaktor50 = uint8(cell2mat(BildBloeckeQuantisiertFaktor50));
QuantisiertesBildFaktor100 = uint8(cell2mat(BildBloeckeQuantisiertFaktor100));
QuantisiertesBildFaktor200 = uint8(cell2mat(BildBloeckeQuantisiertFaktor200));

% Original-Bild und quantisierte Bilder anzeigen

figure("Name", "Original-Bild und quantisierte Bilder");

nexttile;
imshow(Bild, []);
title("Original");

nexttile;
imshow(QuantisiertesBildFaktor50, []);
title("Quantisierungsfaktor 50");

nexttile;
imshow(QuantisiertesBildFaktor100, []);
title("Quantisierungsfaktor 100");

nexttile;
imshow(QuantisiertesBildFaktor200, []);
title("Quantisierungsfaktor 200");
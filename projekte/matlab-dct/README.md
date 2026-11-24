# MATLAB-Labor – DCT und Quantisierung

Das Labor berechnet die diskrete Kosinustransformation blockweise und quantisiert die Koeffizienten. Die inverse DCT rekonstruiert das Bild.

Für die Demo in MATLAB den Ordner öffnen und **DemoDCT** ausführen. Das Skript erzeugt ein synthetisches Testbild, verwendet die Laborfunktionen für die Transformation und multipliziert die quantisierten Koeffizienten vor der Rücktransformation wieder mit dem Quantisierungsfaktor. Es speichert den Vergleich als **dct-vergleich.png**.

**Labor4.m** ist der ursprüngliche Laboreinstieg. Dafür ein eigenes PPM-Bild mit 640 × 480 Pixeln als **samplepic0324.ppm** ablegen.
`node render-demo.cjs dct-vergleich.png` erzeugt dieselbe Vorschau als JavaScript-Umsetzung der DCT-Berechnung. Node.js genügt, es werden keine npm-Pakete benötigt.

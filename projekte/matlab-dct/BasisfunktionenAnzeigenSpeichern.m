function  BasisfunktionenAnzeigenSpeichern(Basisfunktionen, N)

mkdir("Analyse/DCT" + N);

figure("Name", "Basisfunktionen " + N + " x " + N);

tiledlayout(N,N);

for i = 1:N
    for ii = 1:N

        Basisfunktion = Basisfunktionen{i, ii};

        nexttile;

        Basisfunktion = mat2gray(Basisfunktion);

        imshow(Basisfunktion);
        imwrite(Basisfunktion, "Analyse/DCT" + N + "/"  + i + "_" + ii + ".bmp");

    end

end

end
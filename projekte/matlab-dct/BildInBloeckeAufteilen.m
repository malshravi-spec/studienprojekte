function [BildBloecke] = BildInBloeckeAufteilen(Bild)

BreitenMatrix = repelem(8, 80); % 8*80 * 8*60 = 307200, 640*480 = 307200
HoehenMatrix = repelem(8, 60);

BildBloecke = mat2cell(Bild, HoehenMatrix, BreitenMatrix);

end
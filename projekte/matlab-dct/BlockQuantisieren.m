function [BlockQuantisiert] = BlockQuantisieren(Block, Quantisierungsfaktor)

BlockQuantisiert = Block /  Quantisierungsfaktor;

BlockQuantisiert = round(BlockQuantisiert);
BlockQuantisiert = int32(BlockQuantisiert);

end
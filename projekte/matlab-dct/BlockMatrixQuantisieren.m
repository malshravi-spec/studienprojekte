function [BlockMatrixQuantisiert] = BlockMatrixQuantisieren(BlockMatrix, Quantisierungsfaktor)

[HoeheBlockMatrix, BreiteBlockMatrix] = size(BlockMatrix);

for i_HoeheBlockMatrix = 1:HoeheBlockMatrix
    for i_BreiteBlockMatrix = 1:BreiteBlockMatrix

        Block = BlockMatrix{i_HoeheBlockMatrix, i_BreiteBlockMatrix};

        BlockQuantisiert = BlockQuantisieren(Block, Quantisierungsfaktor);

        BlockMatrixQuantisiert{i_HoeheBlockMatrix, i_BreiteBlockMatrix} = BlockQuantisiert;

    end
end

end
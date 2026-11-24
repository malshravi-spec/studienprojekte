function [DCTBlockMatrix] = DCTAufBlockMatrix(BlockMatrix, Basisfunktionen8)

[HoeheBlockMatrix, BreiteBlockMatrix] = size(BlockMatrix);

for i_HoeheBlockMatrix = 1:HoeheBlockMatrix
    for i_BreiteBlockMatrix = 1:BreiteBlockMatrix

        BildBlock = BlockMatrix{i_HoeheBlockMatrix, i_BreiteBlockMatrix};
        BildBlock = double(BildBlock);

        DCTBlock = DCTAufBlock(BildBlock, Basisfunktionen8);

        DCTBlockMatrix{i_HoeheBlockMatrix, i_BreiteBlockMatrix} = DCTBlock;

    end
end

end
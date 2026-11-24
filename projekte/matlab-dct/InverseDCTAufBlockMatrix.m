function [InverseDCTBlockMatrix] = InverseDCTAufBlockMatrix(BlockMatrix)

[HoeheBlockMatrix, BreiteBlockMatrix] = size(BlockMatrix);

for i_HoeheBlockMatrix = 1:HoeheBlockMatrix
    for i_BreiteBlockMatrix = 1:BreiteBlockMatrix

        Block = BlockMatrix{i_HoeheBlockMatrix, i_BreiteBlockMatrix};

        InverseDCTBlock = InverseDCTAufBlock(Block);
        InverseDCTBlock = uint8(InverseDCTBlock);

        InverseDCTBlockMatrix{i_HoeheBlockMatrix, i_BreiteBlockMatrix} = InverseDCTBlock;

    end
end

end
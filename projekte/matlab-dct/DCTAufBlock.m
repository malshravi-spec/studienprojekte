function [DCTBlock] = DCTAufBlock(BildBlock, Basisfunktionen8)

N = 8;

DCTBlock = [];

for k1 = 0:N -1 
    for k2 = 0:N -1

        DCTSumme = 0;
        DCTWert = 0;

        if k1 == 0
            KorrekturFaktor_k1 = ( 1 / sqrt(N) );
        else
            KorrekturFaktor_k1 = ( sqrt(2) / sqrt(N) );
        end

        if k2 == 0
            KorrekturFaktor_k2 = ( 1 / sqrt(N) );
        else
            KorrekturFaktor_k2 = ( sqrt(2) / sqrt(N) );
        end

        for i1 = 0:N - 1
            for i2 = 0:N -1                
                
                DCTWert = BildBlock(i1 + 1, i2 + 1) * Basisfunktionen8{k1 + 1, k2 + 1}(i1 + 1, i2 + 1);
                DCTSumme = DCTSumme + DCTWert;

            end
        end
        
        DCTBlock(k1 + 1, k2 + 1) =  KorrekturFaktor_k1 * KorrekturFaktor_k2 * DCTSumme;

    end
end

end
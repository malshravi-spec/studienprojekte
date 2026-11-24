function [BildBlock] = InverseDCTAufBlock(DCTBlock)

N = 8;

BildBlock = [];

for k1 = 0:N - 1
    for k2 = 0:N - 1

        DCTSumme = 0;
        DCTWert = 0;

        for i1 = 0:N - 1
            for i2 = 0:N - 1

                % in der Formel und in den Korrekturfaktoren i und k
                % vertauscht für inverse DCT

                if i1 == 0
                    KorrekturFaktor_i1 = ( 1 / sqrt(N) );
                else
                    KorrekturFaktor_i1 = ( sqrt(2) / sqrt(N) );
                end

                if i2 == 0
                    KorrekturFaktor_i2 = ( 1 / sqrt(N) );
                else
                    KorrekturFaktor_i2 = ( sqrt(2) / sqrt(N) );
                end

                DCTWert =   DCTBlock(i1 + 1, i2 + 1) * cos( ( (i1*pi) / (2*N) )  * (2*k1 + 1)  )   *   cos( ( (i2*pi) / (2*N) )  * (2*k2 + 1)  ) ;

                DCTSumme = DCTSumme + ( KorrekturFaktor_i1 * KorrekturFaktor_i2 * DCTWert);

            end
        end

        BildBlock(k1 + 1, k2 + 1) =  DCTSumme;

    end
end

end
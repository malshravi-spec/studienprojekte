function [Basisfunktionen] = BasisfunktionenGenerieren(N)

for k1 = 0:N - 1
    for k2 = 0:N - 1
        for i1 = 0:N -1
            for i2 = 0:N -1

                  Basisfunktionen{k1 + 1, k2 + 1}(i1 + 1, i2 + 1) = cos( ( (k1*pi) / (2*N) )  * (2*i1 + 1)  )   *   cos( ( (k2*pi) / (2*N) )  * (2*i2 + 1)  )  ; 

            end
        end
    end
end

end
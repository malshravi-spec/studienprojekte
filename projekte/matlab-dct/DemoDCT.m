function DemoDCT()
% Vergleicht das Testbild mit einer blockweisen DCT-Rekonstruktion.
[x, y] = meshgrid(0:127, 0:95);
wave = 14 * sin(x * 0.85) .* cos(y * 0.7);
circle = 72 * ((x - 87).^2 + (y - 44).^2 < 24^2);
stripes = 36 * (x < 50 & y > 51 & mod(x + y, 8) < 4);
original = uint8(32 + 0.8 * x + 0.5 * y + wave + circle + stripes);
blocks = mat2cell(original, repmat(8, 1, 12), repmat(8, 1, 16));
coefficients = DCTAufBlockMatrix(blocks, BasisfunktionenGenerieren(8));
factor = 80;
quantized = BlockMatrixQuantisieren(coefficients, factor);
dequantized = cellfun(@(block) factor * double(block), quantized, ...
    'UniformOutput', false);
reconstructed = cell2mat(InverseDCTAufBlockMatrix(dequantized));

assert(isequal(size(original), size(reconstructed)));
assert(any(original(:) ~= reconstructed(:)));
rmse = sqrt(mean((double(original(:)) - double(reconstructed(:))).^2));
fprintf('Reconstruction RMSE: %.2f gray levels\n', rmse);

fig = figure('Visible', 'off', 'Color', 'white', 'Position', [100 100 940 420]);
layout = tiledlayout(fig, 1, 2, 'Padding', 'compact', 'TileSpacing', 'compact');
ax = nexttile(layout);
imagesc(ax, original, [0 255]);
axis(ax, 'image', 'off');
title(ax, 'Synthetisches Original');
ax = nexttile(layout);
imagesc(ax, reconstructed, [0 255]);
axis(ax, 'image', 'off');
title(ax, sprintf('Rekonstruktion (Faktor %d)', factor));
colormap(fig, gray(256));
title(layout, 'Blockweise DCT und Quantisierung', 'FontWeight', 'bold');
exportgraphics(layout, 'dct-vergleich.png', 'Resolution', 144);
close(fig);
end
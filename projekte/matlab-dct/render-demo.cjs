const assert = require('node:assert/strict');
const fs = require('node:fs');
const zlib = require('node:zlib');

const width = 128;
const height = 96;
const side = 8;
const factor = 80;
const pixel = (value) => Math.max(0, Math.min(255, Math.floor(value + 0.5)));
const round = (value) => Math.sign(value) * Math.round(Math.abs(value));
const image = Array.from({length: height}, (_, y) =>
  Array.from({length: width}, (_, x) => {
    const wave = 14 * Math.sin(x * 0.85) * Math.cos(y * 0.7);
    const circle = (x - 87) ** 2 + (y - 44) ** 2 < 24 ** 2 ? 72 : 0;
    const stripes = x < 50 && y > 51 && (x + y) % 8 < 4 ? 36 : 0;
    return pixel(32 + 0.8 * x + 0.5 * y + wave + circle + stripes);
  }));
const basis = Array.from({length: side}, (_, k) =>
  Array.from({length: side}, (_, i) =>
    Math.sqrt((k === 0 ? 1 : 2) / side) *
    Math.cos(k * Math.PI * (2 * i + 1) / (2 * side))));
const reconstructed = image.map((row) => row.slice());
for (let y = 0; y < height; y += side) {
  for (let x = 0; x < width; x += side) {
    const coefficients = basis.map((vertical) => basis.map((horizontal) => {
      let sum = 0;
      for (let i = 0; i < side; i++) {
        for (let j = 0; j < side; j++) {
          sum += image[y + i][x + j] * vertical[i] * horizontal[j];
        }
      }
      return factor * round(sum / factor);
    }));
    for (let i = 0; i < side; i++) {
      for (let j = 0; j < side; j++) {
        let sum = 0;
        for (let ky = 0; ky < side; ky++) {
          for (let kx = 0; kx < side; kx++) {
            sum += coefficients[ky][kx] * basis[ky][i] * basis[kx][j];
          }
        }
        reconstructed[y + i][x + j] = pixel(sum);
      }
    }
  }
}
const squaredError = image.reduce((total, row, y) => total + row.reduce(
  (sum, value, x) => sum + (value - reconstructed[y][x]) ** 2, 0), 0);
const rmse = Math.sqrt(squaredError / (width * height));
assert(rmse > 0 && rmse < 30);

const scale = 3;
const margin = 12;
const panel = width * scale;
const pngWidth = panel * 2 + margin * 3;
const pngHeight = height * scale + margin * 2;
const stride = pngWidth + 1;
const bytes = Buffer.alloc(stride * pngHeight);
for (let y = 0; y < pngHeight; y++) {
  for (let x = 0; x < pngWidth; x++) {
    let value = 255;
    const row = Math.floor((y - margin) / scale);
    if (row >= 0 && row < height) {
      const colLeft = Math.floor((x - margin) / scale);
      const colRight = Math.floor((x - panel - 2 * margin) / scale);
      if (colLeft >= 0 && colLeft < width) value = image[row][colLeft];
      if (colRight >= 0 && colRight < width) value = reconstructed[row][colRight];
    }
    bytes[y * stride + x + 1] = value;
  }
}
function pngChunk(type, data) {
  const content = Buffer.concat([Buffer.from(type, 'ascii'), data]);
  let crc = 0xffffffff;
  for (const byte of content) {
    crc ^= byte;
    for (let bit = 0; bit < 8; bit++) {
      crc = (crc >>> 1) ^ ((crc & 1) ? 0xedb88320 : 0);
    }
  }
  const chunk = Buffer.alloc(content.length + 8);
  chunk.writeUInt32BE(data.length);
  content.copy(chunk, 4);
  chunk.writeUInt32BE((crc ^ 0xffffffff) >>> 0, 4 + content.length);
  return chunk;
}
const header = Buffer.alloc(13);
header.writeUInt32BE(pngWidth);
header.writeUInt32BE(pngHeight, 4);
header[8] = 8;
fs.writeFileSync(process.argv[2], Buffer.concat([
  Buffer.from([137, 80, 78, 71, 13, 10, 26, 10]),
  pngChunk('IHDR', header),
  pngChunk('IDAT', zlib.deflateSync(bytes)),
  pngChunk('IEND', Buffer.alloc(0)),
]));
console.log('RMSE:', rmse.toFixed(2), '| PNG:', pngWidth, 'x', pngHeight);

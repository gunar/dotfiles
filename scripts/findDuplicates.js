const leven = require('leven');
const fs = require('fs');
const confirm = require('inquirer-confirm');

function flatten(arr) {
  return [].concat(...arr);
}
const getTitle = x => x.split(' - ')[1].replace(/\([^)]+\)/g, '').replace(/\[[^\]]+\]/g, '').replace(/  /g, ' ');
const getArtist = x => x.split(' - ')[0];


const files = fs.readdirSync('.').filter(x => x.endsWith('.mp3'));

const stats = flatten(
  files.map(file =>
    files
      .filter(x => x !== file)
      .filter(x => x !== file)
      .map(otherFile => ({
        file,
        otherFile,
        leven:
          (Math.max(file.length, otherFile.length) -
            leven(getTitle(file), getTitle(otherFile)) -
            leven(getArtist(file), getArtist(otherFile))) /
          Math.max(file.length, otherFile.length),
      })),
  ),
).sort((a, b) => b.leven - a.leven);

const filesChecked = [];
(async () => {
  for (const {file, otherFile} of stats) {
    if (
      filesChecked.find(
        ([a, b]) =>
          (file === a && otherFile === b) || (file === b && otherFile === a),
      )
    )
      continue;
    try {
      console.log(file);
      console.log(otherFile);
      await confirm({
        question: 'Same file?', // 'Are you sure?' is default
        default: false, // true (yes) is default
      });
      fs.unlinkSync(file);
    } catch (e) {
    } finally {
      filesChecked.push([file, otherFile]);
    }
  }
})();

import { readFile, writeFile } from "fs/promises";

const inputFile = "sample_file";
const outputFile = "outfile";
const accountLength = 9;
const illegibleDigit = "?";
const invalidChecksumText = " ERR";
const illegibleDigitText = " ILL";

const strToDigits = { [" _ "+
                         "| |"+
                         "|_|" ]: 0,
                        ["   "+
                         "  |"+
                         "  |" ]: 1,
                        [" _ "+
                         " _|"+
                         "|_ " ]: 2,
                        [" _ "+
                         " _|"+
                         " _|" ]: 3,
                        ["   "+
                         "|_|"+
                         "  |" ]: 4,
                        [" _ "+
                         "|_ "+
                         " _|" ]: 5,
                        [" _ "+
                         "|_ "+
                         "|_|" ]: 6,
                        [" _ "+
                         "  |"+
                         "  |" ]: 7,
                        [" _ "+
                         "|_|"+
                         "|_|" ]: 8,
                        [" _ "+
                         "|_|"+
                         " _|" ]: 9 }

async function main() {
  // Async read contents of file into memory.
  const fileContents = await readFile(inputFile, {
    encoding: "utf8", // specifying an encoding returns the file contents as a string
  });

  const dataToSave = processFile(fileContents);

  // Async write data to a file, replacing the file if it already exists.
  await writeFile(outputFile, dataToSave, { encoding: "utf8" });
}

function processFile(fileContents) {
  const fileArr = fileContents.split(/\n/);
  let outStr = "";
  fileArr.length;
  for (
    let accountCount = 0;
    accountCount < fileArr.length / 4;
    accountCount++
  ) {
    let numStr = entryToDigits(accountCount, fileArr);
    outStr += numStr;
    outStr += validationStr(numStr);
    outStr += "\n";
  }
  return outStr;
}

function entryToDigits(accountCount, fileArr) {
  const acctStrArr = accountEntryString(accountCount, fileArr);
  let digits = "";
  for (let position = 0; position < accountLength; position++) {
    const digitString = digitStringForPosition(acctStrArr, position);
    digits += charactersToDigits(digitString);
  }
  return digits;
}

// returns array of strings that make up the account number from the file
//
// for example:
//
//   ["    _  _  _  _  _  _     _ ",
//    "|_||_|| ||_||_   |  |  | _ ",
//    "  | _||_||_||_|  |  |  | _|"]
function accountEntryString(accountCount, fileArr) {
  const lineNum = accountCount * 4;
  return [fileArr[lineNum], fileArr[lineNum + 1], fileArr[lineNum + 2]];
}

// each account entry is made up of a series 3x3 matrix of pipes and underscores.
// This will return a single digit string with no line breaks
//
// for example:
//
// '_ | ||_|'
//
// a.k.a
//
// ' _ '\
// '| |'\
// '|_|'

function digitStringForPosition(acctStr, position) {
  const ind = position * 3;
  let digitStr = "";
  for (let row = 0; row < 3; row++) {
    digitStr += acctStr[row].substring(ind, ind + 3);
  }
  return digitStr;
}

function charactersToDigits(str) {
  return strToDigits[str] ?? illegibleDigit;
}

function validationStr(numStr) {
  if (!containsLegibleDigits(numStr)) {
    return illegibleDigitText;
  } else if (!checksumIsCorect(numStr)) {
    return invalidChecksumText;
  } else {
    return "";
  }
}

function containsLegibleDigits(numStr) {
  return !numStr.includes(illegibleDigit);
}

function checksumIsCorect(numStr) {
  let checksum = 0;
  for (let i = 0; i < 9; i++) {
    checksum += parseInt(numStr.substring(9 - i, 8 - i)) * (i + 1);
  }
  return checksum % 11 == 0;
}

await main();

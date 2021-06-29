#!/usr/bin/env node
const Domain = require("domain-check").Domain;
const fs = require("fs");
const readline = require("readline");

const name = process.argv[2];

if (!name) {
  console.log("Usage: ./tlds.js <domain-name>");
  process.exit(0);
}

const rl = readline.createInterface({
  input: fs.createReadStream("tlds.dat"),
  output: process.stdout,
  terminal: false,
});

rl.on("line", (line) => {
  const domain = `${name.substr(0, name.length - line.length)}.${line}`;
  if (domain.replace(".", "") === name) {
    Domain.isFree(domain).then(
      (isFree) => {
        if (isFree) {
          console.log(domain);
        }
      },
      () => undefined
    );
  }
});

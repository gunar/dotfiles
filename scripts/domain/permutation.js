const Domain = require("domain-check").Domain;
const percom = require("percom");

const letters = "abcdefghijklmnopqrstuvwxyz";

percom.per(letters.split(""), 3).forEach(async (array) => {
  const domain = `${array.join('')}.email`;
  try {
    const isFree = await Domain.isFree(domain);
    if (isFree) {
      console.log(domain);
    }
  } catch (e) {}
});

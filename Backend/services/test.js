const cheerio = require("cheerio");

// const judgements = [];
const url = "https://indiankanoon.org";

// const main = async () => {
//   let nextPage =
//     url +
//     "/search/?formInput=sortby%3A%20mostrecent%20year%3A%202026+doctypes:supremecourt,scorders,highcourts";
//   let i = 0;
//   while (i < 50) {
//     console.log(nextPage+"&pagenum="+i);
//     const res = await fetch(nextPage+"&pagenum="+i);
//     const data = await res.text();
//     const page = cheerio.load(data);
//     const container = page(".results-list > .result");

//     container.each((i, el) => {
//       const titleWithDate = page(el).find("h4 > a").text();
//       const title = titleWithDate.split(" on ")[0];
//       const date = titleWithDate.split(" on ")[1];
//       const detailedUrl = page(el).find("h4 > a").attr("href");
//       const courtName = page(el).find(".hlbottom > .docsource").text();
//       judgements.push({
//         title,
//         date,
//         courtName,
//         detailedUrl,
//         titleWithDate,
//       });
//     });
//     i=i+1;
//   }
//   console.log(judgements);
// };

// main();


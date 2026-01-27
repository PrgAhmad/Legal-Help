import * as cheerio from "cheerio";

const url = "https://indiankanoon.org";

export const getJudgment = async ({
  search = "",
  courtName,
  year="2026",
  options = "mostrecent",
}) => {
  const judgements = [];
  let nextPage = `${url}/search/?formInput=${search}&filters=sortby%3A%20mostrecent%20year%3A${year}+doctypes:"${courtName}sortby%3A${options}`;
  let i = 0;
  while (i < 2) {
    console.log(nextPage + "&pagenum=" + i);
    const res = await fetch(nextPage + "&pagenum=" + i);
    const data = await res.text();
    const page = cheerio.load(data);
    const container = page(".results-list > .result");

    container.each((i, el) => {
      const titleWithDate = page(el).find("h4 > a").text();
      const title = titleWithDate.split(" on ")[0].replaceAll("...");
      const firstParty = title.split(" vs ")[0];
      const secondParty = title.split(" vs ")[1];
      const date = titleWithDate.split(" on ")[1];
      const detailedUrl = url + page(el).find("h4 > a").attr("href");
      const courtName = page(el).find(".hlbottom > .docsource").text();
      judgements.push({
        title,
        date,
        firstParty,
        secondParty,
        courtName,
        detailedUrl,
        titleWithDate,
      });
    });
    i = i + 1;
  }
  return judgements;
};

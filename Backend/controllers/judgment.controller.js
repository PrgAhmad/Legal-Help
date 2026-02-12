import * as cheerio from "cheerio";
import { getDates } from "../helpers/judgment.helper.js";

const url = "https://indiankanoon.org";

console.log(getDates());

export const getJudgment = async ({
  search = "",
  courtName,
  fromDate = getDates().fromDate,
  toDate = getDates().toDate,
  options = "mostrecent",
}) => {
  const judgements = [];
  let nextPage = `${url}/search/?formInput=${search}&filters=doctypes:${courtName}%20sortby%3A${options}%20fromdate:${fromDate}%20todate:${toDate}`;
  let i = 0;
  console.log(url);
  console.log(courtName);

  while (i < 2) {
    console.log(nextPage + "&pagenum=" + i);
    const res = await fetch(nextPage + "&pagenum=" + i);
    const data = await res.text();
    const page = cheerio.load(data);
    const container = page(".results-list > .result");
    console.log(res);

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

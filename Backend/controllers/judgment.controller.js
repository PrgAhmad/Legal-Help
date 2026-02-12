import * as cheerio from "cheerio";
import { getDates } from "../helpers/judgment.helper.js";

const BASE_URL = "https://indiankanoon.org";

export const getJudgment = async ({
  search = "",
  courtName,
  fromDate = getDates().fromDate,
  toDate = getDates().toDate,
  options = "mostrecent",
}) => {
  const judgements = [];

  for (let i = 0; i < 2; i++) {
    const targetUrl =
      `${BASE_URL}/search/?formInput=${search}` +
      `&filters=doctypes:${courtName}%20sortby:${options}` +
      `%20fromdate:${fromDate}%20todate:${toDate}` +
      `&pagenum=${i}`;

    console.log("Fetching:", targetUrl);

    const res = await fetch(targetUrl, {
      headers: {
        "User-Agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
      },
    });

    const html = await res.text();
    console.log(res);

    const page = cheerio.load(html);

    page(".results-list > .result").each((_, el) => {
      const anchor = page(el).find("h4 > a");

      const titleWithDate = anchor.text().trim();
      const title = titleWithDate.split(" on ")[0].replaceAll("...", "");

      const [firstParty, secondParty] = title.split(" vs ");
      const date = titleWithDate.split(" on ")[1];

      const detailedUrl = BASE_URL + anchor.attr("href");
      const courtName = page(el).find(".docsource").text().trim();

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

    await new Promise((r) => setTimeout(r, 1500));
  }

  return judgements;
};

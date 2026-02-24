import * as cheerio from "cheerio";
import { getDates } from "../helpers/judgment.helper.js";

const BASE_URL = "https://indiankanoon.org";

export const getJudgment = async ({
  search = "",
  courtName,
  fromDate = getDates().fromDate,
  toDate = getDates().toDate,
  options = "mostrecent",
  pageIdx = 0,
}) => {
  const judgements = [];
  let totalDoc = 0;
  // for (let i = 0; i < 1; i++) {
  const targetUrl =
    `${BASE_URL}/search/?formInput=${search}` +
    `&filters=doctypes:${courtName == "all_courts" ? "supremecourt,highcourts" : courtName}%20sortby:${options}` +
    `%20fromdate:${fromDate}%20todate:${toDate}` +
    `&pagenum=${pageIdx}`;

  console.log("Fetching:", targetUrl);

  const res = await fetch(targetUrl, {
    headers: {
      "User-Agent":
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
    },
  });

  const html = await res.text();
  // console.log(res);

  const page = cheerio.load(html);

  totalDoc = Math.round(
    parseInt(page(".results_middle").find("span > b").text().split(" of ")[1]) /
      10,
  );
  console.log(totalDoc);

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
  // }

  return {
    totalDoc,
    judgements,
  };
};

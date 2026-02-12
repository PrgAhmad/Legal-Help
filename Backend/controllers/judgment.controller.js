import * as cheerio from "cheerio";
import { getDates } from "../helpers/judgment.helper.js";

const url = "https://indiankanoon.org";

// Pick the right launcher depending on environment
let launchBrowser;
if (process.env.VERCEL) {
  const playwrightLambda = await import("playwright-aws-lambda");
  launchBrowser = () => playwrightLambda.launchChromium({ headless: true });
} else {
  const { chromium } = await import("playwright");
  launchBrowser = () => chromium.launch({ headless: true });
}

export const getJudgment = async ({
  search = "",
  courtName,
  fromDate = getDates().fromDate,
  toDate = getDates().toDate,
  options = "mostrecent",
}) => {
  const judgements = [];
  const browser = await launchBrowser();
  const web = await browser.newPage();

  let nextPage = `${url}/search/?formInput=${search}&filters=doctypes:${courtName}%20sortby%3A${options}%20fromdate:${fromDate}%20todate:${toDate}`;
  let i = 0;

  while (i < 2) {
    const targetUrl = nextPage + "&pagenum=" + i;
    console.log("Fetching:", targetUrl);

    await web.goto(targetUrl, { waitUntil: "domcontentloaded" });
    const data = await web.content();
    const page = cheerio.load(data);

    const container = page(".results-list > .result");
    container.each((i, el) => {
      const titleWithDate = page(el).find("h4 > a").text();
      const title = titleWithDate.split(" on ")[0].replaceAll("...", "");
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

    i++;
    await new Promise(r => setTimeout(r, 2000)); // polite delay
  }

  await browser.close();
  return judgements;
};
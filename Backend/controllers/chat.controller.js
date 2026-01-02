import { SYSTEM_PROMPT, ANSWER_STYLE, ANSWER_TYPE } from "../chatbot_style.js";

const previousReponse = [];

export const generateResponse = async ({ question, style, type }) => {
  let previous = "\nPrevious Conversation Take Context from Here :- \n";
  if (previousReponse.length >= 2) {
    const length = previousReponse.length;
    previous +=
      "Strictly Saying :- take context from here for question which dependent to this\n";
    previous +=
      JSON.stringify(previousReponse[length - 2]) +
      JSON.stringify(previousReponse[length - 1]);
  }

  const query =
    SYSTEM_PROMPT +
    "\n\n" +
    ANSWER_STYLE[style] +
    ANSWER_TYPE[type] +
    previous +
    "\n\nUser Question : " +
    question;

  console.log(query);
  const res = await fetch(`${process.env.AI_API_URL}/${query}`);
  const data = (await res.text())
    .replaceAll("```", "")
    .replaceAll("json", "")
    .replace(
      "--- **Support Pollinations.AI:** --- 🌸 **Ad** 🌸 Powered by Pollinations.AI free text APIs. [Support our mission](https://pollinations.ai/redirect/kofi) to keep AI accessible for everyon",
      ""
    );
  await summarize(question, data);
  console.log();

  return data;
};

const summarize = async (question, data) => {
  const res = await fetch(
    `${process.env.AI_API_URL}/${data}\nSummarize in simple word`
  );
  const data1 = await res.text();
  previousReponse.push({ user: question }, { assistant: data1 });
  console.log(previousReponse);
};

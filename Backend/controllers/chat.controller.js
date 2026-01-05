import { SYSTEM_PROMPT, ANSWER_STYLE, ANSWER_TYPE } from "../chatbot_style.js";
import { summarize, getPrevious, randomSeed } from "../helpers/chat.helper.js";

export const generateResponse = async ({ question, style, type }) => {
  const previous = getPrevious();
  const query =
    SYSTEM_PROMPT +
    "\n\n" +
    ANSWER_STYLE[style] +
    ANSWER_TYPE[type] +
    previous +
    "\n\nUser Question : " +
    question;

  console.log(query);
  const res = await fetch(`${process.env.AI_API_URL}/${query}&seed=${randomSeed()}`);
  let data = await res.text();
  data = data.replaceAll("```", "").replaceAll("json", "");
  await summarize(question, data);
  return data;
};

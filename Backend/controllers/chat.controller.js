import { SYSTEM_PROMPT, ANSWER_STYLE, ANSWER_TYPE } from "../chatbot_style.js";
import { gemini } from "../gemini.js";
import { summarize, getPrevious, randomSeed } from "../helpers/chat.helper.js";

export const generateResponse = async ({ question, style, type, isGemini }) => {
  const previous = getPrevious();
  const query =
    SYSTEM_PROMPT +
    "\n\n" +
    ANSWER_STYLE[style] +
    ANSWER_TYPE[type] +
    previous +
    "\nUser Question : " +
    question;
  console.log(query);
  let data;
  if (isGemini == "true") {
    data = await gemini(query);
    console.log(data);
  } else {
    const res = await fetch(
      `${process.env.AI_API_URL}/${query}&seed=${randomSeed()}`
    );
    data = await res.text();
  }
  data = data.replaceAll("```", "").replaceAll("json", "");
  await summarize(question, data);
  return data;
};

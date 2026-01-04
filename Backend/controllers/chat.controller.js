import { SYSTEM_PROMPT, ANSWER_STYLE, ANSWER_TYPE } from "../chatbot_style.js";
import { summarize, getPrevious } from "../helpers/chat.helper.js";

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
  try {
    const res = await fetch(`${process.env.AI_API_URL}/${query}`);
    let data = await res.text();
    data = data.replaceAll("```", "").replaceAll("json", "");
    await summarize(question, data);
    return data;
  } catch (e) {
    return { error: "error from chat" };
  }
};

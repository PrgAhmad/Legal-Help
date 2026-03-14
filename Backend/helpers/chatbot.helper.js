import { SYSTEM_PROMPT, ANSWER_TYPE, ANSWER_STYLE } from "../constants/chatbot_style.js";

let previousReponse = [];

//for summarizing the previous chat to pass as context
export const summarize = async (question, data) => {
  const res = await fetch(
    `${process.env.AI_API_URL}/${data}\nSummarize in simple word with few words`
  );
  const data1 = await res.text();
  previousReponse.push({ user: question }, { ai: data1 });
};

//for accessing previous chatsfd
export const getPrevious = () => {
  let previous = "";
  if (previousReponse.length >= 2) {
    const length = previousReponse.length;
    previous +=
      "\nPrevious Conversation Take Context from Here :- \n" +
      JSON.stringify(previousReponse[length - 2]) +
      JSON.stringify(previousReponse[length - 1]);
  }
  return previous;
};

export const randomSeed = () => {
  const number = (Math.random() * 100000).toFixed(0);
  return number;
};

export const queryBuilder = (question, style, type) => {
  const previous = getPrevious();
  const query = `
${SYSTEM_PROMPT}
${ANSWER_TYPE[type]}
Response Style: ${ANSWER_STYLE[style]}
${previous != "" ? previous : ""}
User Question : ${question}
`;
  return query;
};

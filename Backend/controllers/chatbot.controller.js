import {
  summarize,
  randomSeed,
  queryBuilder,
} from "../helpers/chatbot.helper.js";
import {
  createChatbot,
  getChatbot,
  getChatbotById,
  updateChatbot,
} from "../services/chatbot.service.js";

export const generateResponse = async (
  { chatId, question, style, type },
  userId,
) => {
  let data;
  let finalData;
  let chatData = [];
  let isVisual = type == "visual" ? true : false;
  let error = { error: "Error while generating responses" };

  try {
    const query = queryBuilder(question, style, type);
    const res = await fetch(
      `${process.env.AI_API_URL}/${query}&seed=${randomSeed()}`,
    );
    data = await res.text();
    console.log(data);

    if (res.ok) {
      data = data.replaceAll("```", "").replaceAll("json", "");
      let jsonData = JSON.parse(data);

      if (
        Object.keys(jsonData).includes("content") &&
        Object.keys(jsonData).includes("title")
      ) {
        console.log("RESPONSE FROM AI : ", data);

        if (chatId != null && chatId != "") {
          let chatData = await getChatbotById(chatId, userId);
          let chatDataContent = JSON.parse(chatData[0].content);
          chatDataContent.push({
            user: question,
            ai: jsonData["content"],
            isVisual,
          });
          console.log("call in update");

          console.log("chatData", chatData);

          jsonData["content"] = JSON.stringify(chatDataContent);
          console.log("jsonData", jsonData["content"]);

          finalData = await updateChatbot(chatId, jsonData);
        } else {
          chatData = [];
          chatData.push({
            user: question,
            ai: jsonData["content"],
            isVisual,
          });
          jsonData["content"] = JSON.stringify(chatData);
          finalData = await createChatbot(jsonData, userId);
        }
        console.log("finalData", finalData);
        summarize(question, data);
      }
    }
  } catch (err) {
    console.log("Error generating response:", err);
    return error;
  }
  return finalData ?? error;
};

export const getChatsList = async (userId) => {
  let error = "Error while fetching chats";
  try {
    const data = await getChatbot(userId);
    return data;
  } catch (err) {
    return error;
  }
};

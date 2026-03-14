import { chatbotModel } from "../models/chatbot.model.js";

export const createChatbot = async (data, userId) => {
  const chatbot = await chatbotModel.create({ ...data, userId});
  return chatbot;
};

export const getChatbot = async (userId) => {
  const chatbot = await chatbotModel.find({ userId });
  return chatbot;
};

export const getChatbotById = async (chatId, userId) => {
  const chatbot = await chatbotModel.find({ _id: chatId, userId });
  return chatbot;
}

export const deleteChatbot = async (chatId) => {
  const chatbot = await chatbotModel.findByIdAndDelete(chatId);
  console.log("data deleted ", chatbot);
  return chatbot;
};

export const updateChatbot = async (chatId, data) => {
  const chatbot = await chatbotModel.findByIdAndUpdate(chatId, data, { new: true });
  console.log("data updated ", chatbot);
  return chatbot;
};

import { GoogleGenAI } from "@google/genai";

const ai = new GoogleGenAI({
  apiKey: "AIzaSyB58XM_YDnpgEJbqcIuPYWvp4Gk6Zo61AE",
});

export async function gemini(text) {
  const response = await ai.models.generateContent({
    model: "gemini-2.5-flash",
    contents: text,
  });
  return response.candidates[0].content.parts[0].text;
}

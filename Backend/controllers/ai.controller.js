export const optimizePrompt = async (prompt) => {
  const SYSTEM_PROMPT =
    "You are a Legal Prompt Enhancement AI. Refine the given prompt to be clearer, shorter, precise, and accurate for Indian law use cases. Preserve original intent, legal scope (Acts, Sections, Articles), jurisdiction, and language rules. Expand short forms when used: BNS = Bharatiya Nyay Sanhita, BNSS = Bharatiya Nagarik Suraksha Sanhita, BSA = Bharatiya Sakshya Adhiniyam. Do NOT add explanations or extra text. Return ONLY the enhanced prompt as plain text.";
  try {
    const res = await fetch(
      `${process.env.AI_API_URL}/${SYSTEM_PROMPT}"${prompt}"`
    );
    const data = await res.text();
    return data;
  } catch (e) {
    return { error: "error from optimize" };
  }
};

export const predictPrompts = async (prompt) => {
  const SYSTEM_PROMPT = `
You are a Prompt Predicor AI for Indian legal queries.

Predict next words or sentences according to legal-related query predicts and return ONLY valid JSON:
combine user prompt with predicted prompt and generate only 5 list of prompts
{"predicts":["prompt1","prompt2",etc],}

Rules:
- Prediction must relate only to Indian laws and Problems.
- Expand short forms:
  BNS = Bharatiya Nyay Sanhita
  BNSS = Bharatiya Nagarik Suraksha Sanhita
  BSA = Bharatiya Sakshya Adhiniyam
- No explanations, no extra text, JSON only.
`;
  try {
    const res = await fetch(
      `${process.env.AI_API_URL}/${SYSTEM_PROMPT}\nHere is "${prompt}"`
    );
    const data = await res.text();
    return data;
  } catch (e) {
    return { error: "error from prediction" };
  }
};

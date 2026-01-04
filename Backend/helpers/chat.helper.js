let previousReponse = [];

//for summarizing the previous chat to pass as context 
export const summarize = async (question, data) => {
  const res = await fetch(
    `${process.env.AI_API_URL}/${data}\nSummarize in simple word`
  );
  const data1 = await res.text();
  previousReponse.push({ user: question }, { assistant: data1 });
};

//for accessing previous chats
export const getPrevious = () => {
  let previous = "\nPrevious Conversation Take Context from Here :- \n";
  if (previousReponse.length >= 2) {
    const length = previousReponse.length;
    previous +=
      "Strictly Saying :- take context from here for question which dependent to this\n";
    previous +=
      JSON.stringify(previousReponse[length - 2]) +
      JSON.stringify(previousReponse[length - 1]);
  }
  return previous;
};

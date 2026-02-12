export const getDates = () => {
  const date = new Date();
  console.log(date);
  
  const toDate = `${date.getDate()}-${date.getMonth()+1}-${date.getFullYear()}`;
  date.setMonth(date.getMonth() - 2);
  const fromDate = `${date.getDate()}-${date.getMonth()+1}-${date.getFullYear()}`;
  return { fromDate, toDate };
};

// console.log(getDates());


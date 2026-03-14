import mongoose from "mongoose";

export const connectToDB = async () => {
  try {
    const conn = await mongoose.connect(process.env.MONGO_DB_URL);
    console.log("Connected to Database");
  } catch (err) {
    console.log("Error while connecting to Database");
    console.log(err);
  }
};

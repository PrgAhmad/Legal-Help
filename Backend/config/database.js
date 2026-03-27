import mongoose from "mongoose";

export const connectToDB = async () => {
  const url = process.env.MONGO_DB_URL;

  if (!url) {
    console.error("❌ ERROR: MONGO_DB_URL is undefined. Check your .env file!");
    return;
  }

  try {
    const conn = await mongoose.connect(url);
    console.log(`✅ Connected to Database`);
    console.log(process.env.CLOUDINARY_NAME);
    
  } catch (err) {
    console.error("❌ Error while connecting to Database");
    console.error(err.message);
  }
};
import mongoose from "mongoose";

const chatbotSchema = mongoose.Schema(
  {
    title: {
      type: String,
      required: true,
    },
    content: {
      type: Object,
      required: true,
    },
    userId: {
      type: mongoose.Schema.ObjectId,
      required: true,
    },
  },
  { timestamps: true },
);

export const chatbotModel = mongoose.model("chatbots", chatbotSchema);

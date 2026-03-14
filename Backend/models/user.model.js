import mongoose from "mongoose";

const userSchema = mongoose.Schema({
    fullName: {
        type: String,
        required: true,
    },

    emailId: {
        type: String,
        required: true,
        unique: true
    },

    password: {
        type: String,
        required: true
    },

    mobileNumber: {
        type: String,
        required: true,
        unique: true
    },

    dateOfBirth: {
        type: Date,
        reuired: true,
    },

    gender: {
        type: String,
        enum: ["Male", "Femail", "Other"],
        required: true,
    },

    profession: {
        type: String,
    },

    field: {
        type: String
    }
}, { timestamps: true });

export const userModel = mongoose.model("users", userSchema);
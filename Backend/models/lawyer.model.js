import mongoose from "mongoose";

const lawyerSchema = new mongoose.Schema({
    fullName: {
        type: String,
        required: true
    },

    emailId: {
        type: String,
        required: true,
        unique: true
    },

    mobileNumber: {
        type: String,
        required: true
    },

    password: {
        type: String,
        required: true
    },

    dateOfBirth: {
        type: Date,
        required: true
    },

    gender: {
        type: String,
        enum: ["Male", "Female", "Other"]
    },

    address: {
        officeAddress: String,
        pincode: String,
        city: String,
        state: String,
        practiceCourt: String
    },

    professional: {
        barCouncilId: String,
        fees: Number,
        specialization: String,
        expertise: [
            {
                type: String
            }
        ]
    },

    introduction: {
        profilePhoto: String,
        yearOfExperience: Number,
        shortIntro: String,
        detailedIntro: String
    }

}, { timestamps: true });

export const lawyerModel = mongoose.model("lawyers", lawyerSchema);
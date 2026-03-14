import { lawyerModel } from "../models/lawyer.model.js";

export const createLawyer = async (data) => {
    const lawyer = await lawyerModel.create(data);
    return lawyer;
}

export const getLawyer = async (emailId) => {
    const lawyer = await lawyerModel.findOne({ emailId });
    return lawyer;
}

export const getLawyerByEmailAndMobile = async (emailId, mobileNumber) => {
    let lawyer = await lawyerModel.findOne({ emailId });
    if (lawyer) {
        return lawyer;
    } else {
        lawyer = await lawyerModel.findOne({ mobileNumber });
        return lawyer;
    }
}

export const listLawyers = async () => {
    const lawyers = await lawyerModel.find();
    return lawyers;
}

export const deleteLawyer = async (lawyerId) => {
    const lawyer = await lawyerModel.findByIdAndDelete(lawyerId);
    return lawyer;
}

export const updateLawyer = async (data) => {
    const lawyer = await lawyerModel.findByIdAndUpdate(id, data, { new: true });
    return lawyer;
}
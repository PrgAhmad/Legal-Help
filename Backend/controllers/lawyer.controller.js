import { createLawyer, getLawyer, getLawyerByEmailAndMobile, listLawyers } from "../services/lawyer.service.js"

export const createNewLawyer = async (lawyerData) => {
    const error = { "error": "Error while creating new lawyer" };
    try {
        console.log(lawyerData);
        const isLawyer = await getLawyerByEmailAndMobile(lawyerData.emailId, lawyerData.mobileNumber);
        if (isLawyer) {
            return { "message": "lawyer is already exist" };
        }
        const lawyer = await createLawyer(lawyerData);
        return lawyer;
    } catch (err) {
        console.log(err);
        return error;
    }
}

export const verifyLawyer = async (lawyerData) => {
    const error = { "error": "Error while finding lawyer" };
    try {
        const { emailId, password } = lawyerData;
        const lawyer = await getLawyer(emailId);
        console.log(lawyer);

        if (lawyer) {
            if (lawyer.password === password) {
                return lawyer;
            }
            return { "message": "Password is not match" };
        }
        return { "message": "lawyer is not exist" };
    } catch (err) {
        console.log(err);
        return error;
    }
}

export const getAllLawyers = async () => {
    const error = { "error": "Error while fetching lawyers" };
    try {
        const lawyers = await listLawyers();
        return lawyers;
    } catch (err) {
        return error;
    }
}
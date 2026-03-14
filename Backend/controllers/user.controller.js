import { createUser, getUser, getUserByEmailAndMobile } from "../services/user.service.js"

export const createNewUser = async (userData) => {
    const error = { "error": "Error while creating new user" };
    try {
        const { fullName, emailId, password, mobileNumber, dateOfBirth, gender, profession, field } = userData;
        console.log(userData);
        const exsitUser = await getUserByEmailAndMobile(emailId,mobileNumber);
        if(exsitUser){
            return {"error":"User already exist"};
        }else{
            const user = await createUser(userData);
        return user;
        }
    } catch (err) {
        console.log(err);
        return error;
    }
}

export const verifyUser = async (userData) => {
    const error = { "error": "Error while finding user" };
    try {
        const { emailId, password } = userData;
        const user = await getUser(emailId);
        console.log(user);
        
        if (user) {
            if (user.password === password) {
                return user;
            }
            return { "message": "Password is not match" };
        }
        return { "message": "User is not exist" };
    } catch (err) {
        console.log(err);
        return error;
    }
}
import { userModel } from "../models/user.model.js";

export const createUser = async (data) => {
   const user = await userModel.create(data);
   return user;
}

export const getUser = async (emailId) => {
   const user = await userModel.findOne({ emailId });
   return user;
}

export const getUserByEmailAndMobile = async (emailId, mobileNumber) => {
   let user = await userModel.findOne({ emailId });
   if(user){
      return user;
   }else{
      user = await userModel.findOne({mobileNumber});
      return user;
   }
}

export const updateUser = async (userId, data) => {
   const user = await userModel.findByIdAndUpdate(userId, data, { new: true });
   return user;
}

export const deleteUser = async (userId) => {
   const user = await userModel.findByIdAndDelete(userId);
   return user;
}
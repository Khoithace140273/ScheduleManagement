'use strict';

const firebase = require('../db');
const User = require('../models/userAcc');
const firestore = firebase.firestore();
const usersArray=[];

//call function
const updateUser = fcUpdateUser();
const getAllUsers = fcGetAllUser();
const addUser = fcAddUser(); 
const getUserById =fcGetUserById();



//function
function fcGetUserById(){
  const fcGetUserById  = async (req, res, next) => {
        try {
            const id = req.params.id;
            const student = await firestore.collection('User').doc(id);
            const data = await student.get();
            if(!data.exists) {
                res.status(404).send('User with the given ID not found');
            }else {
                res.send(data.data());
            }
        } catch (error) {
            res.status(400).send(error.message);
        }
    }
    return fcGetUserById;
}

function fcAddUser(){

  const fcAddUser  = async (req, res, next) => {
       var b = usersArray.length;
       console.log(b);
       var a = parseInt(usersArray[usersArray.length - 1].id)+1;
       try {
           const data = req.body;
           await firestore.collection("User").doc(a.toString()).set(data);
           res.send('Record saved successfuly');
       } catch (error) {
           res.status(400).send(error.message);
       }
   }
   return fcAddUser;
}

function fcGetAllUser (){
    const fcArrAllUser =  async (req, res, next) => {
        try {
            const users = await firestore.collection("User");
            const data = await users.get();
            if(data.empty) {
                res.status(404).send('No user record found');
            }else {
                data.forEach(doc => {
                    const user = new User(
                        doc.id,
                        doc.data().Username,
                        doc.data().Password,
                        doc.data().Uidfacebook,
                        doc.data().Uidgoogle
                    );
                    usersArray.push(user);
                });
                res.send(usersArray);
            }
        } catch (error) {
            res.status(400).send(error.message);
        }
        console.log("check here");
    }
    return fcArrAllUser;
}

function fcUpdateUser(){
 const fcupdate = async (req, res, next) => {
        try {
            const id = req.params.id;
            const data = req.body;
            const user =  await firestore.collection('User').doc(id);
            await user.update(data);
            res.send('User record updated successfuly');        
        } catch (error) {
            res.status(400).send(error.message);
        }
    }
    return fcupdate;
}

module.exports = {
    addUser,
    getAllUsers,
    updateUser
}
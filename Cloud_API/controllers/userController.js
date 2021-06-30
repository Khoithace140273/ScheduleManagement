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
 return async (req, res, next) => {
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
}

function fcAddUser(){
 return async (req, res, next) => {
       try {
        const users = await firestore.collection("User");
        const dataGetAllUser = await users.get();
        if(dataGetAllUser.empty) {
            res.status(404).send('No user record found');
        }else {
            dataGetAllUser.forEach(doc => {
                const user = new User(
                    doc.id,
                    doc.data().Username,
                    doc.data().Password,
                    doc.data().Uidfacebook,
                    doc.data().Uidgoogle
                );
                usersArray.push(user);
            });
        }
        var a = parseInt(usersArray[usersArray.length - 1].id)+1;
           const dataPostUser = req.body;
           await firestore.collection("User").doc(a.toString()).set(dataPostUser);
           res.send('Record saved successfuly');
       } catch (error) {
           res.status(400).send(error.message);
       }
   }
}

function fcGetAllUser (){
 return async (req, res, next) => {
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
            }
        } catch (error) {
            res.status(400).send(error.message);
        }
        console.log("check here");
    }
}

function fcUpdateUser(){
 return async (req, res, next) => {
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
}

module.exports = {
    addUser,
    getAllUsers,
    updateUser
}
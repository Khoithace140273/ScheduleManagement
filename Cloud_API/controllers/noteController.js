"use strict";

const firebase = require("../db");
const Note = require("../models/node");
const firestore = firebase.firestore();
const User = require("../models/userAcc");
const updateNote = fcUpdateNote();
const removeNote = fcRemoveNote();
const getAllNote = fcGetAllNoteByUserId();
const addNewNote = fcAddNewNote();
// db.collection("users").get().then((querySnapshot) => {
//     querySnapshot.forEach((doc) => {
//         console.log(`${doc.id} => ${doc.data()}`);
//     });
function fcGetAllNoteByUserId() {
    return async (req, res, next) => {
        try {
            const note = await firestore.collection("Note").doc("1");
            const noteArray = [];
            const dataGetAllUser = await note.get().then(value => {
                const objectArray = Object.entries(value.data());
                objectArray.forEach(([key, valueInMap]) => {
                    const note = new Note(
                        key,
                        valueInMap[0],
                        valueInMap[1],
                        valueInMap[2],
                    );
                    noteArray.push(note);
                });
            });
            res.send(noteArray);
        }
        catch (error) {
            res.status(400).send(error.message);
        }
    };
}

function fcAddNewNote() {
    return async (req, res, next) => {
        try {
            const note = await firestore.collection("Note").doc("1");
            console.log(req.body);
            const noteArray = [];
            const dataGetAllUser = await note.get().then(value => {
                const objectArray = Object.entries(value.data());
                objectArray.forEach(([key, valueInMap]) => {
                    const note = [
                        valueInMap[0],
                        valueInMap[1],
                        valueInMap[2],
                    ];
                    noteArray.push(note);

                });

            });
            var noteLength = (noteArray.length + 1);
            const newNote = [
                req.body.titleNote,
                req.body.content,
                req.body.dateCreate
            ];
            noteArray.push(newNote);
            console.log(Object.assign({}, noteArray));
            note.set(Object.assign({}, noteArray));
        }
        catch (error) {
            console.log(error);
            res.status(400).send(error.message);
        }
    };
}
function fcRemoveNote() {
    return async (req, res, next) => {
        try {
            const note= await firestore.collection("Note").doc("1");
            console.log(req.body);
            const noteArray = [];
            const dataGetAllUser = await note.get().then(value => {
                if(value.data() != null){ 
                    const objectArray = Object.entries(value.data());
                    objectArray.forEach(([key, valueInMap]) => {
                        if(key != req.body.idNote){
                        const note = [
                            valueInMap[0],
                            valueInMap[1],
                            valueInMap[2],
                        ];
                        noteArray.push(note);
                    }
    
                    });}
            });

            // let id = req.body.idNote;
            // const deleteNote = [
            //      req.body.titleNote,
            //        req.body.content,
            //       req.body.dateCreate
            // ];
        //   
            // console.log(idNote);

            console.log(noteArray);
            
            // console.log(noteArray.filter(element => element[0] != idNote));
            note.set(Object.assign({}, noteArray));
            // note.update();
            // console.log(Object.assign({}, noteArray));
            // note.set(Object.assign({}, noteArray));
        }
        catch (error) {
            console.log(error);
            res.status(400).send(error.message);
        }
    };
}
function fcUpdateNote() {
    return async (req, res, next) => {
        try {
            const note = await firestore.collection("Note").doc("1");
            console.log(req.body);
            let idNote = req.body.idNote;

            const updatedNote = [
                req.body.titleNote,
                req.body.content,
                req.body.dateCreate
            ];
          
            console.log(idNote);
            console.log(updatedNote);

            note.update(idNote, updatedNote);
            res.status(200);
        }
        catch (error) {
            console.log(error);
            res.status(400).send(error.message);
        }
    };
}
module.exports = {
    getAllNote,
    addNewNote,
    removeNote,
    updateNote
};


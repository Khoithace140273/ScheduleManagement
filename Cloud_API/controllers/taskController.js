"use strict";
const firebase = require("../db");
const Task = require("../models/Task");
const firestore = firebase.firestore();
const User = require("../models/userAcc");

const getAllTask = fcGetAllTaskByUserId();
const addNewTask = fcAddNewTask();
const updateTask = fcUpdateTask();
const removeTask = fcRemoveTask();

// db.collection("users").get().then((querySnapshot) => {
//     querySnapshot.forEach((doc) => {
//         console.log(`${doc.id} => ${doc.data()}`);
//     });
function fcGetAllTaskByUserId() {
    return async (req, res, next) => {
        try {
            const task = await firestore.collection("Task").doc("1");
            const taskArray = [];
            const dataGetAllUser = await task.get().then(value => {
                const objectArray = Object.entries(value.data());
                objectArray.forEach(([key, valueInMap]) => {
                   
                    const task = new Task(
                        key,
                        valueInMap[0],
                        valueInMap[1],
                        valueInMap[2],
                        valueInMap[3],
                    );
                
                    taskArray.push(task);
                });
            });
            res.send(taskArray);
        }
        catch (error) {
            res.status(400).send(error.message);
        }
    };
}

function fcAddNewTask() {
    return async (req, res, next) => {
        try {
            const task = await firestore.collection("Task").doc("1");
            console.log(req.body);
            const taskArray = [];
            const dataGetAllUser = await task.get().then(value => {
                if(value.data() != null){ const objectArray = Object.entries(value.data());
                    objectArray.forEach(([key, valueInMap]) => {
                        const task = [
    
                            valueInMap[0],
                            valueInMap[1],
                            valueInMap[2],
                            valueInMap[3],
                        ];
                        taskArray.push(task);
    
                    });}
            });
            var taskLength = (taskArray.length + 1);
            const newTask = [

                req.body.done == 'true' ? true : false,
                req.body.titleTask,
                req.body.reminderTime,
                req.body.lastEditedTime
            ];
            taskArray.push(newTask);
            console.log(Object.assign({}, taskArray));
            task.set(Object.assign({}, taskArray));
        }
        catch (error) {
            console.log(error);
            res.status(400).send(error.message);
        }
    };
}


function fcUpdateTask() {
    return async (req, res, next) => {
        try {
            const task = await firestore.collection("Task").doc("1");
            console.log(req.body);
            let id = req.body.id;

            const updatedTask = [
                req.body.done == 'true' ? true : false,
                req.body.titleTask,
                req.body.reminderTime,
                req.body.lastEditedTime
            ];
          
            console.log(id);
            console.log(updatedTask);

            task.update(id, updatedTask);
            res.status(200);
        }
        catch (error) {
            console.log(error);
            res.status(400).send(error.message);
        }
    };
}

function fcRemoveTask() {
    return async (req, res, next) => {
        try {
            const task = await firestore.collection("Task").doc("1");
            console.log(req.body);
            const taskArray = [];
            const dataGetAllUser = await task.get().then(value => {
                if(value.data() != null){ 
                    const objectArray = Object.entries(value.data());
                    objectArray.forEach(([key, valueInMap]) => {
                        if(key != req.body.id){
                        const task = [
                            valueInMap[0],
                            valueInMap[1],
                            valueInMap[2],
                            valueInMap[3],
                        ];
                        taskArray.push(task);
                    }
    
                    });}
            });

            // let id = req.body.id;
            // const deleteTask = [
            //     req.body.done == 'true' ? true : false,
            //     req.body.titleTask,
            //     req.body.reminderTime,
            //     req.body.lastEditedTime
            // ];
        //   
            // console.log(id);

            console.log(taskArray);
            
            // console.log(taskArray.filter(element => element[0] != id));
            task.set(Object.assign({}, taskArray));
            // task.update();
            // console.log(Object.assign({}, taskArray));
            // task.set(Object.assign({}, taskArray));
        }
        catch (error) {
            console.log(error);
            res.status(400).send(error.message);
        }
    };
}



module.exports = {
    getAllTask,
    addNewTask,
    updateTask,
    removeTask
};


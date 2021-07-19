const express = require('express');
const { addUser,
    checkUser,
    updateUser
} = require('../controllers/userController');
const {
    getAllNote,
    addNewNote,
    removeNote,
    updateNote
} = require('../controllers/noteController');

const {
    getAllTask,
    addNewTask,
    updateTask,
    removeTask
} = require('../controllers/taskController');


const router = express.Router();

router.post('/user', addUser);
router.post('/loginuser', checkUser);
router.put('/user/:id', updateUser);
router.get('/task', getAllTask);
router.post('/task/addtask', addNewTask);
router.post('/task/updatetask', updateTask);
router.delete('/task/deletetask', removeTask);
router.get('/note', getAllNote);
router.post('/note/addnote', addNewNote);
router.post('/note/updatenote', updateNote);
router.delete('/note/deletenote', removeNote);
module.exports = {
    routes: router
}
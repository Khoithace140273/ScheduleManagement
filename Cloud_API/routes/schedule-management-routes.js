const express = require('express');
const { addUser,
    checkUser,
    updateUser
} = require('../controllers/userController');

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

module.exports = {
    routes: router
}
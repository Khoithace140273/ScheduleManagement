const express = require('express');
const {addUser, 
       getAllUsers, 
       getStudent,
       updateStudent,
       deleteStudent
      } = require('../controllers/userController');

const router = express.Router();

router.post('/student', addUser);
router.get('/users', getAllUsers);
router.get('/student/:id', getStudent);
router.put('/student/:id', updateStudent);
router.delete('/student/:id', deleteStudent);


module.exports = {
    routes: router
}
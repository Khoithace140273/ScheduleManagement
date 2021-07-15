const express = require('express');
const {
    addUser, 
    checkUser, 
    updateUser,
    getAllUser
      } = require('../controllers/userController');


const router = express.Router();

router.post('/user', addUser);
router.post('/loginuser', checkUser);
router.put('/user/:id', updateUser);
router.get('/users', getAllUser);


module.exports = {
    routes: router
}
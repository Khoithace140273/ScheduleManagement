const express = require('express');
const {
    addUser, 
    checkUser, 
    updateUser
      } = require('../controllers/userController');


const router = express.Router();

router.post('/user', addUser);
router.post('/loginuser', checkUser);
router.put('/userpass', updateUser);

module.exports = {
    routes: router
}
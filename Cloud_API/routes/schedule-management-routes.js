const express = require('express');
const {addUser, 
       getAllUsers, 
       updateUser
      } = require('../controllers/userController');

const router = express.Router();

router.post('/user', addUser);
router.get('/users', getAllUsers);
router.put('/user/:id', updateUser);


module.exports = {
    routes: router
}
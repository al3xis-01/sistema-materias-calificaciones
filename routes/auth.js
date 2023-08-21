var express = require('express');
var router = express.Router();


const notRequireAuth = require('../middleware/notAuthMiddleware');
const requireAuth = require('../middleware/authMiddleware');
const AuthController    =   require('../controllers/AuthController');



/* GET login page. */
router.get('/login', notRequireAuth,function (req, res, next) {
    res.render('login')
});

router.post('/auth', notRequireAuth,AuthController.to_login) ;



router.get('/logout', requireAuth, function (req, res, next) {
    req.session = null
    res.redirect('/login');
})


module.exports = router;


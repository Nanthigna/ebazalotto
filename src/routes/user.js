const express = require('express');
const router = express.Router();
const users = require('../services/user');


/* GET Users */
router.get('/', async function (req, res, next) {
    try {
        res.json(await users.getMultiple(req.query.page));
    } catch (err) {
        console.error(`Error while getting users `, err.message);
        next(err);
    }
});

/* POST User */
router.post('/', async function (req, res, next) {
    try {
        res.json(await users.createUser(req.body));
    } catch (err) {
        console.error(`Error while creating user`, err.message);
        next(err);
    }
});

/* POST User from referral: update tables users + members + member_profiles*/
router.post('/:par', async function (req, res, next) {
    if (req.params.par == 'submit_registration') {
        try {
            res.json(await users.createFromReferral(req.body));
        } catch (err) {
            console.error(`Error while creating user & member`, err.message);
            next(err);
        }
    }
});

/* PUT User */
router.put('/:id', async function (req, res, next) {
    try {
        res.json(await users.update(req.params.id, req.body));
    } catch (err) {
        console.error(`Error while updating user`, err.message);
        next(err);
    }
});

/* DELETE User */
router.delete('/:id', async function (req, res, next) {
    try {
        res.json(await users.remove(req.params.id));
    } catch (err) {
        console.error(`Error while deleting user`, err.message);
        next(err);
    }
});

/* FIND User OR FIND similar Usernames */
router.get('/:par', async function (req, res, next) {
    try {
        var reqId = req.params.par;
        var fieldName = reqId.substring(0, reqId.lastIndexOf('='));
        var fieldValue = '';

        if (reqId.indexOf('"') > -1) {
            fieldValue = reqId.substring(
                reqId.indexOf('"') + 1,
                reqId.lastIndexOf('"')
            );
        } else {
            fieldValue = reqId.substring(reqId.lastIndexOf('=') + 1);
        }

        //console.log(`routes: ${reqId}`);
        //console.log(`routes: ${fieldName}`);
        //console.log(`routes: ${fieldValue}`);
        switch (fieldName) {
            case 'id':
                res.json(await users.search(fieldValue));
                break;
            case 'username':
                if (fieldValue.includes('*')) {
                    res.json(await users.searchUsernames(fieldValue.replace("*", "")));
                } else if (fieldValue.includes('$')) {
                    var token = fieldValue.replace("$", "").split(/\&(.*)/s);
                    var username = token[0];
                    var password = token[1] == undefined ? '' : token[1];

                    //console.log(fieldValue);
                    //console.log(username);
                    //console.log(password);

                    res.json(await users.authenticate(username, password));
                } else {
                    res.json(await users.searchUsername(fieldValue));
                }
                break;
            default:
        }
    } catch (err) {
        console.error(`Error while searching user `, err.message);
        next(err);
    }
});

module.exports = router;
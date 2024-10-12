const express = require('express');
const router = express.Router();
const member_profiles = require('../services/member_profile');

/* GET Member Profiles */
router.get('/', async function (req, res, next) {
    try {
        res.json(await member_profiles.getMultiple(req.query.page));
    } catch (err) {
        console.error(`Error while getting member profiles `, err.message);
        next(err);
    }
});

/* FIND Member Profile */
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
                res.json(await member_profiles.search(fieldValue));
                break;
            case 'membername':
                if (fieldValue.includes('*')) {
                    res.json(await member_profiles.searchProfiles(fieldValue.replace("*", "")));
                } else {
                    res.json(await member_profiles.searchProfile(fieldValue));
                }
                break;
            default:
        }
    } catch (err) {
        console.error(`Error while searching member profile`, err.message);
        next(err);
    }
});

/* POST Member Profile */
router.post('/', async function (req, res, next) {
    try {
        res.json(await member_profiles.createMemberProfile(req.body));
    } catch (err) {
        console.error(`Error while creating member profile`, err.message);
        next(err);
    }
});

/* PUT Member Profile */
router.put('/:par', async function (req, res, next) {
    try {
        var reqId = req.params.par;
        var fieldValue = '';
        if (reqId.indexOf('"') > -1) {
            fieldValue = reqId.substring(
                reqId.indexOf('"') + 1,
                reqId.lastIndexOf('"')
            );
        }
        //console.log(req.body);

        res.json(await member_profiles.updateMemberProfile(req.body));
    } catch (err) {
        console.error(`Error while updating member profile`, err.message);
        next(err);
    }
});

/* DELETE Member Profile */
router.delete('/:id', async function (req, res, next) {
    try {
        res.json(await member_profiles.remove(req.params.id));
    } catch (err) {
        console.error(`Error while deleting member profile`, err.message);
        next(err);
    }
});

module.exports = router;
const express = require('express');
const router = express.Router();
const members = require('../services/member');

/* GET Members */
/*router.get('/', async function (req, res, next) {
    try {
        res.json(await members.getMultiple(req.query.page));
    } catch (err) {
        console.error(`Error while getting members`, err.message);
        next(err);
    }
});*/

router.get('/', async function (req, res, next) {
    try {
        res.json(await members.getMembers());
    } catch (err) {
        console.error(`Error while getting members`, err.message);
        next(err);
    }
});

/* FIND Member OR FIND similar Membernames */
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
        } else if (reqId.indexOf('filter') > -1) {
            fieldValue = reqId.substring(reqId.indexOf('=') + 1);
        } else {
            fieldValue = reqId.substring(reqId.lastIndexOf('=') + 1);
        }

        //console.log(`routes: ${reqId}`);
        //console.log(`routes: ${fieldName}`);
        //console.log(`routes: ${fieldValue}`);
        switch (fieldName) {
            case 'id':
                res.json(await members.search(fieldValue));
                break;
            case 'membername':
                if (fieldValue.includes('*')) {
                    res.json(await members.searchMembernames(fieldValue.replace("*", "")));
                } else {
                    res.json(await members.searchMembername(fieldValue));
                }
                break;
            case 'filter':
                res.json(await members.filterMemberstatus(fieldValue));
                break;
            default:
        }
    } catch (err) {
        console.error(`Error while searching members`, err.message);
        next(err);
    }
});

/* POST Member */
/*router.post('/:par', async function (req, res, next) {
    try {
        var reqId = req.params.par;
        var fieldValue = '';
        if (reqId.indexOf('"') > -1) {
            fieldValue = reqId.substring(
                reqId.indexOf('"') + 1,
                reqId.lastIndexOf('"')
            );
        }
        console.log(req.body);

        if (reqId.indexOf('>') > -1) {
            res.json(await members.createMemberWithSignup(req.body));
        } else {
            res.json(await members.createMemberFromBlank(req.body));
        }
    } catch (err) {
        console.error(`Error while creating member`, err.message);
        next(err);
    }
});*/

router.post('/', async function (req, res, next) {
    try {
        res.json(await members.createMemberFromBlank(req.body));
    } catch (err) {
        console.error(`Error while creating member`, err.message);
        next(err);
    }
});

router.post('/:par', async function (req, res, next) {
    try {
        res.json(await members.createMemberWithSignup(req.body));
    } catch (err) {
        console.error(`Error while creating member`, err.message);
        next(err);
    }
});

/* PUT Member */
router.put('/:par', async function (req, res, next) {
    try {
        // In our model, for 'members' table, update only 'approved' field (registers members)
        var reqId = req.params.par;
        var fieldValue = '';
        if (reqId.indexOf('"') > -1) {
            fieldValue = reqId.substring(
                reqId.indexOf('"') + 1,
                reqId.lastIndexOf('"')
            );
        }
        //console.log(req.body);

        if (reqId.indexOf('>') > -1) {
            res.json(await members.updateUserCredentials(req.body));
        } else if (reqId.indexOf('*') > -1) {
            res.json(await members.updateBatchApproval(req.body['memberids']));
        } else {
            res.json(await members.updateMemberApproval(fieldValue));
        }
    } catch (err) {
        console.error(`Error while updating member`, err.message);
        next(err);
    }
});

/* DELETE Member */
router.delete('/:id', async function (req, res, next) {
    try {
        res.json(await members.remove(req.params.id));
    } catch (err) {
        console.error(`Error while deleting member`, err.message);
        next(err);
    }
});

module.exports = router;
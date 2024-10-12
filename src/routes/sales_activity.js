const express = require('express');
const router = express.Router();
const sales_activities = require('../services/sales_activity');

/* GET Sales Activities */
router.get('/', async function (req, res, next) {
    try {
        res.json(await sales_activities.getMultiple(req.query.page));
    } catch (err) {
        console.error(`Error while getting sales activities `, err.message);
        next(err);
    }
});

router.get('/:par', async function (req, res, next) {
    try {
        var reqId = req.params.par;
        var body = req.body;
        var txType = /@([^;]+)%/.exec(reqId)[1];

        /*console.log(`routes-reqId: ${reqId}`);
        console.log(`routes-body: ${JSON.stringify(body)}`);
        console.log(`routes-txType: ${txType}`);*/

        switch (txType) {
            case 'remittance':
                res.json(await sales_activities.getRemittances());
                break;
            case 'currentremittance':
                res.json(await sales_activities.getCurrentRemittance());
                break;
            default:
        }
    } catch (err) {
        console.error(`Error while searching sales activities`, err.message);
        next(err);
    }
});

/* POST Sales Activity */
router.post('/', async function (req, res, next) {
    try {
        res.json(await sales_activities.create(req.body));
    } catch (err) {
        console.error(`Error while creating sales activity`, err.message);
        next(err);
    }
});

router.post('/:par', async function (req, res, next) {
    try {
        var reqId = req.params.par;
        var body = req.body;
        var txType = /@([^;]+)%/.exec(reqId)[1];

        /*console.log(`routes-reqId: ${reqId}`);
        console.log(`routes-body: ${JSON.stringify(body)}`);
        console.log(`routes-txType: ${txType}`);*/

        switch (txType) {
            case 'paytickets':
                var fieldset = req.body;

                var objFieldSet = Object.values(fieldset);
                res.json(await sales_activities.payTickets(objFieldSet[0], objFieldSet[1], objFieldSet[2], objFieldSet[3]));
                break;
            default:
        }
    } catch (err) {
        console.error(`Error while creating sales activity`, err.message);
        next(err);
    }
});

/* PUT Sales Activity */
/*router.put('/:id', async function (req, res, next) {
    try {
        res.json(await sales_activities.update(req.params.id, req.body));
    } catch (err) {
        console.error(`Error while updating sales activity`, err.message);
        next(err);
    }
});*/

router.put('/:par', async function (req, res, next) {
    try {
        var reqId = req.params.par;
        var body = req.body;
        var txType = /@([^;]+)%/.exec(reqId)[1];

        switch (txType) {
            case 'remittance':
                var fieldset = req.body;

                if (fieldset['settled'] = true) { res.json(await sales_activities.addRemittance()); }
                break;
            default:
        }
    } catch (err) {
        console.error(`Error while searching sales activities`, err.message);
        next(err);
    }
});

/* DELETE Sales Activity */
router.delete('/:id', async function (req, res, next) {
    try {
        res.json(await sales_activities.remove(req.params.id));
    } catch (err) {
        console.error(`Error while deleting sales activity`, err.message);
        next(err);
    }
});

/* FIND Sales Activity */
router.get('/:id', async function (req, res, next) {
    try {
        res.json(await sales_activities.search(req.params.id));
    } catch (err) {
        console.error(`Error while searching sales activity `, err.message);
        next(err);
    }
});

module.exports = router;
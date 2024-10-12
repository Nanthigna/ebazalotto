const express = require('express');
const router = express.Router();
const member_revenues = require('../services/member_revenue');

/* GET Member Revenues */
router.get('/', async function (req, res, next) {
    try {
        res.json(await member_revenues.getMultiple(req.query.page));
    } catch (err) {
        console.error(`Error while getting member revenues `, err.message);
        next(err);
    }
});

router.get('/:par', async function (req, res, next) {
    try {
        var reqId = req.params.par;
        var txType = /@([^;]+)%/.exec(reqId)[1];
        var fieldValue = /[^%]*$/.exec(reqId)[0];

        /*console.log(`routes-reqId: ${reqId}`);
        console.log(`routes-fieldValue: ${fieldValue}`);
        console.log(`routes-txType: ${txType}`);*/

        switch (txType) {
            case 'current':
                var filter = fieldValue.split('&');
                res.json(await member_revenues.getCurrentRevenues(filter[0], filter[1], filter[2]));
                break;
            case 'lineage':
                res.json(await member_revenues.getLineageRevenues(fieldValue));
                break;
            case 'current_sys':
                var filter = fieldValue.split('&');
                res.json(await member_revenues.getCurrentSysRevenues(filter[0], filter[1], filter[2]));
                break;
            case 'lineage_sys':
                res.json(await member_revenues.getLineageSysRevenues(fieldValue));
                break;
            case 'sales_commissions':
                //TODO
                break;
            case 'royalties':
                //TODO
                break;
            case 'new_members':
                //TODO
                break;
            case 'cumul_revenues':
                //TODO
                break;
            case 'batch_chartrvn':
                var filter = fieldValue.split('&');
                res.json(await member_revenues.getBatchChartRevenues(filter[0], filter[1], filter[2]));
                break;
            default:
        }
    } catch (err) {
        console.error(`Error while searching member revenues`, err.message);
        next(err);
    }
});

/* POST Member Revenue */
router.post('/', async function (req, res, next) {
    try {
        res.json(await member_revenues.create(req.body));
    } catch (err) {
        console.error(`Error while creating member revenue`, err.message);
        next(err);
    }
});

/* PUT Member Revenue */
router.put('/:id', async function (req, res, next) {
    try {
        res.json(await member_revenues.update(req.params.id, req.body));
    } catch (err) {
        console.error(`Error while updating member revenue`, err.message);
        next(err);
    }
});

/* DELETE Member Revenue */
router.delete('/:id', async function (req, res, next) {
    try {
        res.json(await member_revenues.remove(req.params.id));
    } catch (err) {
        console.error(`Error while deleting member revenue`, err.message);
        next(err);
    }
});

module.exports = router;
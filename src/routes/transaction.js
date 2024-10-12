const express = require('express');
const router = express.Router();
const transactions = require('../services/transaction');

/* GET Transactions */
router.get('/:par', async function (req, res, next) {
    try {
        var reqId = req.params.par;
        //var fieldName = reqId.split('%').pop().split('=')[0]; // Good
        var fieldName = reqId.indexOf('=') > -1 ? /%([^;]+)=/.exec(reqId)[1] : '';
        var fieldValue = '';

        if (reqId.indexOf('"') > -1) {
            fieldValue = reqId.substring(
                reqId.indexOf('"') + 1,
                reqId.lastIndexOf('"')
            );
        } else if (reqId.indexOf('filter') > -1) {
            fieldValue = reqId.substring(reqId.indexOf('=') + 1);
        } else if (reqId.indexOf('=') > -1) {
            fieldValue = reqId.substring(reqId.lastIndexOf('=') + 1);
        }
        var txType = /@([^;]+)%/.exec(reqId)[1];

        /*console.log(`routes-reqId: ${reqId}`);
        console.log(`routes-fieldName: ${fieldName}`);
        console.log(`routes-fieldValue: ${fieldValue}`);
        console.log(`routes-txType: ${txType}`);*/

        switch (txType) {
            case 'deposit':
                switch (fieldName) {
                    case 'id':
                        res.json(await transactions.searchDeposit(fieldValue));
                        break;
                    case 'filter':
                        var filter = fieldValue.split('&');
                        res.json(await transactions.filterDeposits(filter[0]));
                        break;
                    case '':
                        if (reqId.indexOf('*') > -1) {
                            res.json(await transactions.getDeposits());
                        }
                        break;
                    default:
                }
                break;
            case 'withdraw':
                switch (fieldName) {
                    case 'id':
                        res.json(await transactions.searchWithdrawal(fieldValue));
                        break;
                    case 'filter':
                        var filter = fieldValue.split('&');
                        res.json(await transactions.filterWithdrawals(filter[0], filter[1]));
                        break;
                    case '':
                        if (reqId.indexOf('*') > -1) {
                            res.json(await transactions.getWithdrawals());
                        }
                        break;
                    default:
                }
                break;
            case 'transfer':
                switch (fieldName) {
                    case 'id':
                        res.json(await transactions.searchTransfer(fieldValue));
                        break;
                    case 'filter':
                        var filter = fieldValue.split('&');
                        res.json(await transactions.filterTransfers(filter[0]));
                        break;
                    case '':
                        if (reqId.indexOf('*') > -1) {
                            res.json(await transactions.getTransfers());
                        }
                        break;
                    default:
                }
                break;
            case 'history':
                switch (fieldName) {
                    case 'filter':
                        var filter = fieldValue.split('&');
                        res.json(await transactions.getFilterTXHistory(filter[0], filter[1], filter[2], filter[3]));
                        break;
                    case '':
                        if (reqId.indexOf('*') > -1) {
                            var filter = reqId.substring(reqId.lastIndexOf('*') + 1).split('&');
                            res.json(await transactions.getTXHistory(filter[0], filter[1], filter[2]));
                        }
                        break;
                    default:
                }
                break;
            case 'account':
                if (fieldName = 'filter') {
                    var filter = fieldValue.split('&');
                    switch (filter[0]) {
                        case 'balance':
                            res.json(await transactions.getAccountBalance(filter[1]));
                            break;
                        default:
                    }
                }
                break;
            default:
        }
    } catch (err) {
        console.error(`Error while searching transactions`, err.message);
        next(err);
    }
});

/* POST Transaction */
router.post('/:par', async function (req, res, next) {
    try {
        var reqId = req.params.par;
        var body = req.body;
        var txType = /@([^;]+)%/.exec(reqId)[1];
        var txSubType = body.txsubtype;

        /*console.log(`routes-reqId: ${reqId}`);
        console.log(`routes-body: ${JSON.stringify(body)}`);
        console.log(`routes-txType: ${txType}`);
        console.log(`routes-txSubType: ${body.txtype}`);*/

        switch (txType) {
            case 'deposit':
                break;
            case 'withdraw':
                break;
            case 'transfer':
                break;
            case 'history':
                switch (txSubType) {
                    case 'deposit':
                        var fieldset = req.body;

                        delete fieldset.txsubtype;
                        var objFieldSet = Object.values(fieldset);
                        res.json(await transactions.createDeposit(objFieldSet[0], objFieldSet[1]));
                        break;
                    case 'withdraw':
                        var fieldset = req.body;

                        delete fieldset.txsubtype;
                        var objFieldSet = Object.values(fieldset);
                        res.json(await transactions.createWithdrawal(objFieldSet[0], objFieldSet[1]));
                        break;
                    case 'transfer':
                        var fieldset = req.body;

                        delete fieldset.txsubtype;
                        var objFieldSet = Object.values(fieldset);
                        res.json(await transactions.createTransfer(objFieldSet[0], objFieldSet[1], objFieldSet[2]));
                        break;
                    default:
                }
            case 'account':
                break;
            default:
        }
    } catch (err) {
        console.error(`Error while creating transaction`, err.message);
        next(err);
    }
});

/* PUT Transaction */
router.put('/:par', async function (req, res, next) {
    try {
        var reqId = req.params.par;
        //var fieldName = reqId.split('%').pop().split('=')[0]; // Good
        var fieldName = reqId.indexOf('=') > -1 ? /%([^;]+)=/.exec(reqId)[1] : '';
        var fieldValue = '';

        if (reqId.indexOf('"') > -1) {
            fieldValue = reqId.substring(
                reqId.indexOf('"') + 1,
                reqId.lastIndexOf('"')
            );
        } else if (reqId.indexOf('=') > -1) {
            fieldValue = reqId.substring(reqId.lastIndexOf('=') + 1);
        }
        var txType = /@([^;]+)%/.exec(reqId)[1];

        switch (txType) {
            case 'deposit':
                switch (fieldName) {
                    case 'id':
                        res.json(await transactions.updateDeposit(fieldValue));
                        break;
                    case '':
                        if (reqId.indexOf('*') > -1) {
                            res.json(await transactions.updateBatchDeposit(req.body['ids']));
                        }
                        break;
                    default:
                }
                break;
            case 'withdraw':
                switch (fieldName) {
                    case 'id':
                        res.json(await transactions.updateWithdrawal(fieldValue));
                        break;
                    case '':
                        if (reqId.indexOf('*') > -1) {
                            res.json(await transactions.updateBatchWithdrawal(req.body['ids']));
                        }
                        break;
                    default:
                }
                break;
            case 'transfer':
                switch (fieldName) {
                    case 'id':
                        res.json(await transactions.updateTransfer(fieldValue));
                        break;
                    case '':
                        if (reqId.indexOf('*') > -1) {
                            res.json(await transactions.updateBatchTransfer(req.body['ids']));
                        }
                        break;
                    default:
                }
                break;
            default:
        }
    } catch (err) {
        console.error(`Error while updating transaction`, err.message);
        next(err);
    }
});

/* DELETE Transaction */


/* TRANSACTION Module */




module.exports = router;
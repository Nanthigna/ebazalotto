const express = require('express');
const router = express.Router();
const lotto_draws = require('../services/lotto_draw');

/* GET Lotto Draws */
router.get('/', async function (req, res, next) {
    try {
        res.json(await lotto_draws.getMultiple(req.query.page));
    } catch (err) {
        console.error(`Error while getting lotto draws `, err.message);
        next(err);
    }
});

/* POST Lotto Draw */
router.post('/', async function (req, res, next) {
    try {
        res.json(await lotto_draws.create(req.body));
    } catch (err) {
        console.error(`Error while creating lotto draw`, err.message);
        next(err);
    }
});

/* PUT Lotto Draw */
router.put('/:id', async function (req, res, next) {
    try {
        res.json(await lotto_draws.update(req.params.id, req.body));
    } catch (err) {
        console.error(`Error while updating lotto draw`, err.message);
        next(err);
    }
});

/* DELETE Lotto Draw */
router.delete('/:id', async function (req, res, next) {
    try {
        res.json(await lotto_draws.remove(req.params.id));
    } catch (err) {
        console.error(`Error while deleting lotto draw`, err.message);
        next(err);
    }
});

/* FIND Lotto Draw */
router.get('/:id', async function (req, res, next) {
    try {
        res.json(await lotto_draws.search(req.params.id));
    } catch (err) {
        console.error(`Error while searching lotto draw `, err.message);
        next(err);
    }
});

module.exports = router;
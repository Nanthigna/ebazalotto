const express = require('express');
const router = express.Router();
const grades = require('../services/grade');

/* GET Grades */
router.get('/', async function (req, res, next) {
    try {
        res.json(await grades.getMultiple(req.query.page));
    } catch (err) {
        console.error(`Error while getting grades `, err.message);
        next(err);
    }
});

/* POST Grade */
router.post('/', async function (req, res, next) {
    try {
        res.json(await grades.create(req.body));
    } catch (err) {
        console.error(`Error while creating grade`, err.message);
        next(err);
    }
});

/* PUT Grade */
router.put('/:id', async function (req, res, next) {
    try {
        res.json(await grades.update(req.params.id, req.body));
    } catch (err) {
        console.error(`Error while updating grade`, err.message);
        next(err);
    }
});

/* DELETE Grade */
router.delete('/:id', async function (req, res, next) {
    try {
        res.json(await grades.remove(req.params.id));
    } catch (err) {
        console.error(`Error while deleting grade`, err.message);
        next(err);
    }
});

/* FIND Grade */
router.get('/:id', async function (req, res, next) {
    try {
        res.json(await grades.search(req.params.id));
    } catch (err) {
        console.error(`Error while searching grade `, err.message);
        next(err);
    }
});

module.exports = router;
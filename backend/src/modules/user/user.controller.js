const userService = require('./user.service');
const { successResponse, errorResponse } = require('../../utils/response');

const getList = async (req, res) => {
    try {
        const users = await userService.getList();
        return successResponse(res, users);
    } catch (err) {
        return errorResponse(res, err.message);
    }
};

const getAll = async (req, res) => {
    console.log('DEBUG_USER:', req.user);
    if (req.user.user_type !== 'admin') return res.sendStatus(403);
    try {
        const users = await userService.getAll();
        return successResponse(res, users);
    } catch (err) {
        return errorResponse(res, err.message);
    }
};

const getById = async (req, res) => {
    if (req.user.user_type !== 'admin') return res.sendStatus(403);
    try {
        const user = await userService.getById(req.params.id);
        return successResponse(res, user);
    } catch (err) {
        return errorResponse(res, err.message, err.status || 500);
    }
};

const createOrUpdate = async (req, res) => {
    if (req.user.user_type !== 'admin') return res.sendStatus(403);
    try {
        const result = await userService.createOrUpdate(req.body);
        return successResponse(res, result, 'User saved', 201);
    } catch (err) {
        return errorResponse(res, err.message);
    }
};

const getProcessAssignments = async (req, res) => {
    try {
        const assignments = await userService.getProcessAssignments(req.params.id);
        return successResponse(res, assignments);
    } catch (err) {
        return errorResponse(res, err.message, err.status || 500);
    }
};

const saveProcessAssignments = async (req, res) => {
    if (req.user.user_type !== 'admin') return res.sendStatus(403);
    try {
        const result = await userService.saveProcessAssignments(req.params.id, req.body.assignments);
        return successResponse(res, result, 'Process assignments saved successfully');
    } catch (err) {
        return errorResponse(res, err.message, err.status || 500);
    }
};

module.exports = {
    getList,
    getAll,
    getById,
    createOrUpdate,
    getProcessAssignments,
    saveProcessAssignments
};

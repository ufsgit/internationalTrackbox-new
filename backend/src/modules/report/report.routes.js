const db = require('../../config/db');
const { successResponse, errorResponse } = require('../../utils/response');
const express = require('express');

const router = express.Router();

const authenticateToken = require('../../middlewares/auth.middleware');

router.use(authenticateToken);

router.get('/enquiry', (req, res) => {

    const {
        fromDate,
        toDate,
        search,
        branchId,
        staffId,
        page,
        limit
    } = req.query;

    const pageNumber = Number(page || 1);
    const pageLimit = Number(limit || 10);

    const offset = (pageNumber - 1) * pageLimit;

    const params = [
        fromDate || null,
        toDate || null,
        search || null,
        branchId || null,
        staffId || null,
        pageLimit,
        offset
    ];

    db.query(
        'CALL sp_GetEnquiryReport(?, ?, ?, ?, ?, ?, ?)',
        params,
        (err, results) => {

            if (err) {
                return errorResponse(res, err.message);
            }

            successResponse(res, {
                data: results[0],
                total: results[1][0].total
            });

        }
    );

});

router.get('/assessment', (req, res) => {
    const { fromDate, toDate, search, branchId, staffId, page, limit } = req.query;
    const pageNumber = Number(page || 1);
    const pageLimit = Number(limit || 10);
    const offset = (pageNumber - 1) * pageLimit;

    let baseQuery = `
        FROM suggested_programs sp
        JOIN student_applications sa ON sp.application_id = sa.application_id
        JOIN students s ON sa.student_id = s.student_id
        LEFT JOIN branches b ON IFNULL(sp.branch_id, s.branch_id) = b.branch_id
        LEFT JOIN users u_to ON IFNULL(sp.assigned_to, s.assigned_to) = u_to.user_id
        LEFT JOIN users u_by ON s.created_by = u_by.user_id
        WHERE 1=1
    `;
    const params = [];

    if (fromDate) {
        baseQuery += ` AND DATE(sp.created_at) >= ?`;
        params.push(fromDate);
    }
    if (toDate) {
        baseQuery += ` AND DATE(sp.created_at) <= ?`;
        params.push(toDate);
    }
    if (search) {
        baseQuery += ` AND (s.student_name LIKE ? OR s.mobile_number LIKE ? OR sp.program LIKE ?)`;
        params.push(`%${search}%`, `%${search}%`, `%${search}%`);
    }
    if (branchId) {
        baseQuery += ` AND (sp.branch_id = ? OR (sp.branch_id IS NULL AND s.branch_id = ?))`;
        params.push(branchId, branchId);
    }
    if (staffId) {
        baseQuery += ` AND (sp.assigned_to = ? OR (sp.assigned_to IS NULL AND s.assigned_to = ?))`;
        params.push(staffId, staffId);
    }

    const countQuery = `SELECT COUNT(*) as total ${baseQuery}`;
    
    const dataQuery = `
        SELECT 
            sp.sug_program_id,
            sp.created_at as created_date,
            s.student_id,
            s.student_name,
            CONCAT(IFNULL(s.mobile_country_code, ''), ' ', IFNULL(s.mobile_number, '')) as mobile,
            sp.program_type as type,
            sp.program as program,
            sp.applied_for as country_or_course,
            sp.details as program_details,
            sp.details2 as intake_or_batch,
            sp.status as current_status,
            sp.remarks as last_remark,
            b.branch_name,
            u_to.username as assigned_to,
            u_by.username as created_by
        ${baseQuery}
        ORDER BY sp.created_at DESC
        LIMIT ? OFFSET ?
    `;

    db.query(countQuery, params, (err, countResult) => {
        if (err) return errorResponse(res, err.message);
        
        db.query(dataQuery, [...params, pageLimit, offset], (err, dataResult) => {
            if (err) return errorResponse(res, err.message);
            
            successResponse(res, {
                data: dataResult,
                total: countResult[0].total
            });
        });
    });
});

router.get('/registration', (req, res) => {
    const { fromDate, toDate, search, branchId, staffId, page, limit } = req.query;
    const pageNumber = Number(page || 1);
    const pageLimit = Number(limit || 10);
    const offset = (pageNumber - 1) * pageLimit;

    let baseQuery = `
        FROM registration_suggested_programs rsp
        JOIN student_registrations sr ON rsp.registration_id = sr.registration_id
        JOIN students s ON sr.student_id = s.student_id
        LEFT JOIN branches b ON IFNULL(rsp.branch_id, s.branch_id) = b.branch_id
        LEFT JOIN users u_to ON IFNULL(rsp.assigned_to, s.assigned_to) = u_to.user_id
        LEFT JOIN users u_by ON s.created_by = u_by.user_id
        WHERE 1=1
    `;
    const params = [];

    if (fromDate) {
        baseQuery += ` AND DATE(rsp.created_at) >= ?`;
        params.push(fromDate);
    }
    if (toDate) {
        baseQuery += ` AND DATE(rsp.created_at) <= ?`;
        params.push(toDate);
    }
    if (search) {
        baseQuery += ` AND (s.student_name LIKE ? OR s.mobile_number LIKE ? OR rsp.program LIKE ?)`;
        params.push(`%${search}%`, `%${search}%`, `%${search}%`);
    }
    if (branchId) {
        baseQuery += ` AND (rsp.branch_id = ? OR (rsp.branch_id IS NULL AND s.branch_id = ?))`;
        params.push(branchId, branchId);
    }
    if (staffId) {
        baseQuery += ` AND (rsp.assigned_to = ? OR (rsp.assigned_to IS NULL AND s.assigned_to = ?))`;
        params.push(staffId, staffId);
    }

    const countQuery = `SELECT COUNT(*) as total ${baseQuery}`;
    
    const dataQuery = `
        SELECT 
            rsp.sug_program_id,
            rsp.created_at as created_date,
            s.student_id,
            s.student_name,
            CONCAT(IFNULL(s.mobile_country_code, ''), ' ', IFNULL(s.mobile_number, '')) as mobile,
            rsp.program_type as type,
            rsp.program as program,
            rsp.applied_for as country_or_course,
            rsp.details as program_details,
            rsp.details2 as intake_or_batch,
            rsp.status as current_status,
            rsp.remarks as last_remark,
            b.branch_name,
            u_to.username as assigned_to,
            u_by.username as created_by
        ${baseQuery}
        ORDER BY rsp.created_at DESC
        LIMIT ? OFFSET ?
    `;

    db.query(countQuery, params, (err, countResult) => {
        if (err) return errorResponse(res, err.message);
        
        db.query(dataQuery, [...params, pageLimit, offset], (err, dataResult) => {
            if (err) return errorResponse(res, err.message);
            
            successResponse(res, {
                data: dataResult,
                total: countResult[0].total
            });
        });
    });
});

module.exports = router;
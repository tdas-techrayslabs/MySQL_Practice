import express from 'express';
import { createStudent, deleteStudent, getStudentByID, getStudents, updateStudent } from '../controller/studentController.js';

// router object
const route = express.Router()

// routes

// Get all students
route.get('/students', getStudents)

// Get studnet By Id
route.get('/student/:id', getStudentByID)

// Create Student
route.post('/create', createStudent)

// Update Student
route.put('/update/:id', updateStudent)

// Delete Student
route.delete('/delete/:id', deleteStudent)

export default route;
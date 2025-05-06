// import { db } from "../config/db.js";
import Student from "../model/Student.js";

// GET all studnets list
export const getStudents = async (req, res) => {
  try {
    const data = await Student.findAll();

    if (!data || data?.length === 0) {
      return res.status(404).send({
        success: false,
        message: "No records found",
      });
    }

    res.status(200).send({
      success: true,
      message: "All Students Record",
      TotalStudents: data.length,
      data,
    });
  } catch (error) {
    console.log(error);

    res.status(500).send({
      success: false,
      message: "Error fetching the students",
      error,
    });
  }
};

// GET Student By Id
export const getStudentByID = async (req, res) => {
  try {
    const data = await Student.findByPk(req.params.id);

    if (!data) {
      return res.status(404).send({
        success: false,
        message: "No record found",
      });
    }

    res.status(200).send({
      success: true,
      message: `Record of student with id: ${req.params.id}`,
      data,
    });
  } catch (error) {
    console.log(error);

    res.status(500).send({
      success: false,
      message: "Error fetching the student",
      error,
    });
  }
};

// CREATE student
export const createStudent = async (req, res) => {
    try {
      const { name, roll_no, className, city } = req.body;
  
      if (!name || !roll_no || !className || !city) {
        return res.status(400).send({
          success: false,
          message: "Please provide all required details",
        });
      }
  
      // Check if a student with the same roll_no already exists
      const existing = await Student.findOne({ where: { roll_no } });
  
      if (existing) {
        return res.status(409).send({
          success: false,
          message: "A student with this roll number already exists",
        });
      }
  
      const data = await Student.create({
        name,
        roll_no,
        className,
        city,
      });
  
      return res.status(201).send({
        success: true,
        message: "Student created successfully",
      });
  
    } catch (error) {
      console.log(error);
  
      return res.status(500).send({
        success: false,
        message: "Error in creating the student",
        error,
      });
    }
  };
  

// UPDATE student
export const updateStudent = async (req, res) => {
  try {
    const { name, roll_no, className, city } = req.body;

    if (!name || !roll_no || !className || !city) {
      return res.status(500).send({
        success: false,
        message: "Please provide all required details",
      });
    }

    const data = await Student.findByPk(req.params.id);

    if (!data) {
      return res.status(404).send({
        success: false,
        message: "EStudent not found",
      });
    }

    await data.update({
      name,
      roll_no,
      className,
      city,
    });

    res.status(200).send({
      success: true,
      message: "Student's details updated successfully",
      data,
    });
  } catch (error) {
    console.log(error);

    if (error.name === "SequelizeUniqueConstraintError") {
      return res.status(400).send({
        success: false,
        message: "Roll number must be unique",
      });
    }

    res.status(500).send({
      success: false,
      message: "Error in updating the student",
      error,
    });
  }
};

// DELETE Student
export const deleteStudent = async (req, res) => {
  try {
    const data = await Student.findByPk(req.params.id);

    if (!data) {
      return res.status(404).send({
        success: false,
        message: "Student not found",
      });
    }

    await data.destroy();

    res.status(200).send({
      success: true,
      message: "Student deleted successfully",
    });
  } catch (error) {
    console.log(error);

    res.status(500).send({
      success: false,
      message: "Error deleting the student",
      error,
    });
  }
};

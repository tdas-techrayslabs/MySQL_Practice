// import mysql from 'mysql2/promise';
import { Sequelize } from 'sequelize';
import dotenv from "dotenv";

dotenv.config();

const sequelize = new Sequelize('students_db', process.env.User, process.env.Password, {
    host: process.env.HOST,
    dialect: 'mysql',
});

export default sequelize;
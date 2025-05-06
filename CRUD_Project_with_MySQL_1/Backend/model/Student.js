import { DataTypes } from "sequelize";
import sequelize from "../config/db.js";

const Student = sequelize.define('Student', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    name: {
        type: DataTypes.STRING(50),
        allowNull: false,
    },
    roll_no: {
        type: DataTypes.INTEGER,
        allowNull: false,
        unique: true,
    },
    className: {
        type: DataTypes.STRING(20),
        allowNull: false,
    },
    city: {
        type: DataTypes.STRING(50),
        allowNull: false,
    }
}, {
    tableName: 'students1',
    timestamps: false,
});

export default Student;
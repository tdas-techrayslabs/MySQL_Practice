import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import dotenv from "dotenv";
import colors from "colors";
import morgan from 'morgan';
// import { db} from './config/db.js';
import sequelize from './config/db.js';
import Student from './model/Student.js';
import route from './routes/studentRoutes.js';


dotenv.config()

const app = express()

// Middleware
app.use(cors())
app.use(bodyParser.json())
app.use(express.json())
app.use(morgan('dev'))

// Test Route
app.get("/test", (req, res) => {
    res.status(200).send("<h1>Nodejs MySQL App</h1>")
})

const PORT = process.env.PORT || 7000;

// // conditionally listen
// db
// .query('SELECT 1')
// .then(() => {
//     // MySQL
//     console.log('MySQL DB connected'.bgCyan.white);
    
//     // listen
//     app.listen(PORT, () => {
//         console.log(`Server running on port ${PORT}`.bgMagenta.white);
//     })
// })
// .catch((error) => {
//     console.log(error);        
// });


// Initialize Sequelize
const startServer = async () => {
    try {

        await sequelize.authenticate();
        console.log('✅ MySQL DB connected'.bgCyan.white);

        await sequelize.sync(); 

        app.listen(PORT, () => {
            console.log(`Server running on port ${PORT}`.bgMagenta.white);
        });
                
    } catch (error) {
        console.error('❌ Unable to connect to the database:', error);
    }
}


// Start server
startServer();


// Routes
app.use("/api", route)
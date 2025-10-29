import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import pino from "pino";
const logger = pino({ transport: { target: 'pino-pretty' } });
logger.info('Server started...');
dotenv.config({ path: "./.env" });


const app = express();
app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.send("Server berjalan dengan TypeScript!");
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => console.log(`✅ Server aktif di http://127.0.0.1:${PORT}`));

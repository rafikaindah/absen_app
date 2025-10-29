import { defineConfig, env } from "prisma/config";
import * as path from "path";
import * as dotenv from "dotenv";

// 🔹 tambahkan ini agar Prisma tahu lokasi .env kamu
dotenv.config({ path: path.resolve(__dirname, ".env") });

export default defineConfig({
  schema: "prisma/schema.prisma",
  migrations: {
    path: "prisma/migrations",
  },
  engine: "classic",
  datasource: {
    url: env("DATABASE_URL"),
  },
});


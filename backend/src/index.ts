import 'reflect-metadata';
import express from 'express';
import { createConnection } from 'typeorm';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';
import { createServer } from 'http';
import { config } from './config';
import { errorHandler } from './core/middleware/error.middleware';
import { logger, stream } from './core/utils/logger';
import { apiRouter } from './presentation/routes';

class App {
  public app: express.Application;
  public env: string;
  public port: string | number;

  constructor() {
    this.app = express();
    this.env = process.env.NODE_ENV || 'development';
    this.port = process.env.PORT || 3000;

    this.initializeDatabase();
    this.initializeMiddlewares();
    this.initializeRoutes();
    this.initializeErrorHandling();
  }

  public async listen() {
    const server = createServer(this.app);
    server.listen(this.port, () => {
      logger.info(`=================================`);
      logger.info(`======= ENV: ${this.env} =======`);
      logger.info(`🚀 App listening on port ${this.port}`);
      logger.info(`=================================`);
    });
  }

  private async initializeDatabase() {
    try {
      await createConnection();
      logger.info('🟢 Database connected');
    } catch (error) {
      logger.error(`🔴 Database connection error: ${error}`);
      process.exit(1);
    }
  }

  private initializeMiddlewares() {
    this.app.use(helmet());
    this.app.use(cors({ origin: config.cors.origin, credentials: true }));
    this.app.use(express.json());
    this.app.use(express.urlencoded({ extended: true }));
    this.app.use(morgan(config.log.format, { stream }));
  }

  private initializeRoutes() {
    this.app.use('/api', apiRouter);
    
    // Health check endpoint
    this.app.get('/health', (req, res) => {
      res.status(200).json({ status: 'OK', timestamp: new Date() });
    });
  }

  private initializeErrorHandling() {
    this.app.use(errorHandler);
  }
}

const app = new App();
app.listen();

export { app };

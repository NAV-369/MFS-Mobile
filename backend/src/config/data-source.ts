import 'reflect-metadata';
import { DataSource, DataSourceOptions } from 'typeorm';
import { config } from './';
import { User } from '../domain/entities/user.entity';
import { Loan } from '../domain/entities/loan.entity';
import { Saving } from '../domain/entities/saving.entity';
import { Transaction } from '../domain/entities/transaction.entity';

export const AppDataSource = new DataSource({
  type: 'postgres',
  host: config.db.host,
  port: config.db.port,
  username: config.db.username,
  password: config.db.password,
  database: config.db.database,
  synchronize: config.db.synchronize,
  logging: config.db.logging,
  entities: [User, Loan, Saving, Transaction],
  migrations: ['src/infrastructure/database/migrations/*.ts'],
  subscribers: [],
  migrationsRun: false,
} as DataSourceOptions);

// For CLI usage
export const dataSource = AppDataSource;

import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './infrastructure/prisma/prisma.module';
import { WinstonModule } from 'nest-winston';
import { loggerConfig } from './shared/logger/logger.config';

@Module({
  imports: [
    PrismaModule,
    WinstonModule.forRoot(loggerConfig),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}

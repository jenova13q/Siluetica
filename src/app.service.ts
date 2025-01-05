import { Injectable, Logger } from '@nestjs/common';

@Injectable()
export class AppService {
  private readonly logger = new Logger(AppService.name);

  getHello(): string {
    this.logger.log('Тестовый лог - проверка настройки логирования');
    this.logger.error('Тестовая ошибка - проверка настройки логирования');
    return 'Hello World!';
  }
}

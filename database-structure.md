# Структура баз данных Siluetica

## PostgreSQL (Prisma)

### Основные таблицы

#### 1. users (Пользователи)
| Поле           | Тип       | Описание                    |
|----------------|-----------|----------------------------|
| id             | INTEGER   | Уникальный идентификатор   |
| email          | TEXT      | Почта (уникальный логин)   |
| password_hash  | TEXT      | Хэш пароля                 |
| created_at     | TIMESTAMP | Дата регистрации           |
| updated_at     | TIMESTAMP | Дата последнего обновления |

#### 2. user_preferences (Предпочтения пользователя)
| Поле             | Тип      | Описание                           |
|------------------|----------|-----------------------------------|
| id               | INTEGER  | Уникальный идентификатор          |
| user_id          | INTEGER  | Ссылка на users(id)               |
| favorite_colors  | TEXT[]   | Любимые цвета                     |
| preferred_styles | TEXT[]   | Предпочитаемые стили              |
| disliked_items   | TEXT[]   | Нежелательные элементы            |

#### 3. interaction_history (История взаимодействий)
| Поле         | Тип       | Описание                      |
|--------------|-----------|-------------------------------|
| id           | INTEGER   | Уникальный идентификатор     |
| user_id      | INTEGER   | Ссылка на users(id)          |
| request      | TEXT      | Текст запроса пользователя   |
| response     | TEXT      | Текст ответа агента          |
| timestamp    | TIMESTAMP | Время запроса                |

#### 4. trends (Модные тренды)
| Поле          | Тип      | Описание                     |
|---------------|----------|-----------------------------|
| id            | INTEGER  | Уникальный идентификатор    |
| name          | TEXT     | Название тренда             |
| type          | TEXT     | Тип (стиль/цвет/материал)   |
| popularity    | INTEGER  | Условная популярность (1-100)|
| source        | TEXT     | Источник информации         |

#### 5. categories (Категории одежды)
| Поле        | Тип      | Описание                           |
|-------------|----------|-------------------------------------|
| id          | INTEGER  | Уникальный идентификатор           |
| name        | TEXT     | Название категории                  |
| parent_id   | INTEGER  | Ссылка на родительскую категорию   |

#### 6. wardrobe_items (Основная таблица вещей)
| Поле          | Тип       | Описание                          |
|---------------|-----------|-----------------------------------|
| id            | INTEGER   | Уникальный идентификатор          |
| user_id       | INTEGER   | Ссылка на users(id)               |
| type_id       | INTEGER   | Ссылка на categories(id)          |
| season        | TEXT[]    | Массив сезонов                    |
| style         | TEXT[]    | Массив стилей                     |
| warmth_level  | INTEGER   | Условная теплотность (1-5)        |
| description   | TEXT      | Пользовательское описание         |
| set_id        | INTEGER   | Ссылка на sets(id)                |
| created_at    | TIMESTAMP | Дата добавления                   |

#### 7. photos (Фотографии вещей)
| Поле              | Тип      | Описание                        |
|-------------------|----------|----------------------------------|
| id                | INTEGER  | Уникальный идентификатор        |
| wardrobe_item_id  | INTEGER  | Ссылка на wardrobe_items(id)    |
| angle             | TEXT     | Угол съемки (front/back/side)   |
| image_url         | TEXT     | Ссылка на фото                  |

#### 8. materials (Справочник материалов)
| Поле        | Тип      | Описание                     |
|-------------|----------|-----------------------------|
| id          | INTEGER  | Уникальный идентификатор    |
| name        | TEXT     | Название материала          |
| properties  | TEXT[]   | Свойства материала          |

#### 9. textures (Текстуры)
| Поле     | Тип      | Описание                     |
|----------|----------|-----------------------------|
| id       | INTEGER  | Уникальный идентификатор    |
| name     | TEXT     | Название текстуры           |

#### 10. patterns (Принты)
| Поле     | Тип      | Описание                     |
|----------|----------|-----------------------------|
| id       | INTEGER  | Уникальный идентификатор    |
| name     | TEXT     | Название принта             |

#### 11. item_materials (Состав вещей)
| Поле              | Тип      | Описание                        |
|-------------------|----------|----------------------------------|
| id                | INTEGER  | Уникальный идентификатор        |
| wardrobe_item_id  | INTEGER  | Ссылка на wardrobe_items(id)    |
| material_id       | INTEGER  | Ссылка на materials(id)         |
| percentage        | FLOAT    | Процент материала (1-100)       |
| texture_id        | INTEGER  | Ссылка на textures(id)          |
| pattern_id        | INTEGER  | Ссылка на patterns(id)          |

#### 12. attributes (Справочник атрибутов)
| Поле     | Тип      | Описание                     |
|----------|----------|-----------------------------|
| id       | INTEGER  | Уникальный идентификатор    |
| name     | TEXT     | Название атрибута           |

#### 13. item_attributes (Значения атрибутов)
| Поле              | Тип      | Описание                        |
|-------------------|----------|----------------------------------|
| id                | INTEGER  | Уникальный идентификатор        |
| wardrobe_item_id  | INTEGER  | Ссылка на wardrobe_items(id)    |
| attribute_id      | INTEGER  | Ссылка на attributes(id)        |
| value             | TEXT     | Значение атрибута               |

#### 14. sets (Комплекты)
| Поле         | Тип       | Описание                        |
|--------------|-----------|----------------------------------|
| id           | INTEGER   | Уникальный идентификатор        |
| name         | TEXT      | Название комплекта              |
| user_id      | INTEGER   | Ссылка на users(id)             |
| added_date   | TIMESTAMP | Дата создания                   |

#### 15. outfits (Образы)
| Поле           | Тип       | Описание                        |
|----------------|-----------|----------------------------------|
| id             | INTEGER   | Уникальный идентификатор        |
| user_id        | INTEGER   | Ссылка на users(id)             |
| name           | TEXT      | Название образа                 |
| event_desc     | TEXT      | Описание события                |
| weather        | TEXT      | Погодные условия                |
| created_at     | TIMESTAMP | Дата создания                   |

#### 16. outfit_items (Связь образов и вещей)
| Поле              | Тип      | Описание                        |
|-------------------|----------|----------------------------------|
| id                | INTEGER  | Уникальный идентификатор        |
| outfit_id         | INTEGER  | Ссылка на outfits(id)           |
| wardrobe_item_id  | INTEGER  | Ссылка на wardrobe_items(id)    |
| layer_order       | INTEGER  | Порядок слоя                    |

## Weaviate (Векторная БД)

### Классы (Classes)

#### 1. ClothingItem
```json
{
  "class": "ClothingItem",
  "vectorizer": "text2vec-transformer",
  "properties": [
    {
      "name": "itemId",
      "dataType": ["int"],
      "description": "ID из PostgreSQL wardrobe_items"
    },
    {
      "name": "description",
      "dataType": ["text"],
      "description": "Текстовое описание для векторизации"
    },
    {
      "name": "style",
      "dataType": ["text[]"],
      "description": "Массив стилей"
    },
    {
      "name": "season",
      "dataType": ["text[]"],
      "description": "Массив сезонов"
    },
    {
      "name": "imageVector",
      "dataType": ["vector"],
      "description": "Эмбеддинг изображения (CLIP/ResNet)"
    }
  ]
}
```

#### 2. OutfitCombination
```json
{
  "class": "OutfitCombination",
  "vectorizer": "text2vec-transformer",
  "properties": [
    {
      "name": "outfitId",
      "dataType": ["int"],
      "description": "ID из PostgreSQL outfits"
    },
    {
      "name": "description",
      "dataType": ["text"],
      "description": "Описание образа"
    },
    {
      "name": "occasion",
      "dataType": ["text"],
      "description": "Тип события"
    },
    {
      "name": "styleVector",
      "dataType": ["vector"],
      "description": "Эмбеддинг стиля образа"
    }
  ]
}
```

## Изменения и обновления

### Версия 1.0 (Начальная)
- Базовая структура PostgreSQL (16 таблиц)
- Основные классы Weaviate (ClothingItem, OutfitCombination)

### Версия 1.1 (Планируемая)
- Добавление поддержки множественных фото
- Расширение метаданных в Weaviate
- Оптимизация связей между таблицами

### Версия 1.2 (Будущая)
- Добавление таблиц для сезонных коллекций
- Расширение системы атрибутов
- Улучшение структуры хранения трендов 
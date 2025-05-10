# NyaCAST UI Library

<div align="center">
  <img src="https://i.imgur.com/7MggZ5a.png" alt="NyaCAST UI Logo" width="200"/>
  <br>
  <br>
  <p>
    <strong>Современная и стильная UI библиотека для Roblox</strong>
  </p>
  <p>
    <a href="#особенности">Особенности</a> •
    <a href="#установка">Установка</a> •
    <a href="#примеры-использования">Примеры</a> •
    <a href="#документация">Документация</a> •
    <a href="#темы">Темы</a> •
    <a href="#лицензия">Лицензия</a>
  </p>
  <br>
  
  ![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
  ![License](https://img.shields.io/badge/license-MIT-green.svg)
  ![Roblox](https://img.shields.io/badge/platform-Roblox-red.svg)
</div>

## 🌟 Особенности

- **Современный дизайн** — Стильный и удобный интерфейс с плавными анимациями
- **Настраиваемые темы** — 5 предустановленных тем: стандартная, темная, светлая, фиолетовая, синяя
- **Богатый набор компонентов** — Кнопки, переключатели, слайдеры, выпадающие списки, текстовые поля и многое другое
- **Анимации и эффекты** — Плавные переходы и эффект ряби при нажатии
- **Система уведомлений** — Встроенные уведомления для информирования пользователей
- **Простой API** — Интуитивно понятный и легкий в использовании интерфейс
- **Легкая интеграция** — Простая установка с помощью одной строки кода

<div align="center">
  <img src="https://i.imgur.com/ZFNa9XE.png" alt="NyaCAST UI Preview" width="600"/>
</div>

## 📦 Установка

```lua
local NyaCAST = loadstring(game:HttpGet("https://raw.githubusercontent.com/lolow2e/NyaCast-UI/main/NyaCAST.lua"))()
```

## 🚀 Примеры использования

### Базовые элементы

```lua
-- Создание окна с фиолетовой темой
local window = NyaCAST.createWindow("NyaCAST Demo", "Моё приложение", {
    draggable = true,
    theme = "purple" -- "default", "dark", "light", "purple", "blue"
})

-- Создание вкладки
local homeTab = window.createTab("Главная", "rbxassetid://3926305904") -- Иконка необязательна

-- Добавление текста
homeTab.createText("Добро пожаловать!", {size = 18, color = Color3.fromRGB(190, 135, 255)})

-- Добавление кнопки
homeTab.createButton("Нажми меня", function()
    window.notification("Событие", "Вы нажали на кнопку!")
end)

-- Добавление переключателя
local toggle = homeTab.createToggle("Включи меня", false, function(value)
    print("Переключатель:", value)
end)

-- Добавление слайдера
local slider = homeTab.createSlider("Значение", {min = 0, max = 100, default = 50}, function(value)
    print("Слайдер:", value)
end)
```

### Секции и группировка

```lua
-- Создание секции (true = развернута, false = свернута)
local section = homeTab.createSection("Настройки", true)

-- Добавление элементов в секцию
section.createButton("Настройка 1", function() print("Настройка 1") end)
section.createButton("Настройка 2", function() print("Настройка 2") end)

-- Выпадающий список
section.createDropdown("Выберите опцию", 
    {"Опция 1", "Опция 2", "Опция 3"}, 
    "Опция 1", 
    function(selected)
        print("Выбрано:", selected)
    end
)

-- Текстовое поле
section.createTextBox("Имя", "Введите ваше имя...", function(text, enterPressed)
    if enterPressed then
        print("Имя:", text)
    end
end)
```

### Управление элементами через API

```lua
-- Изменение значения слайдера
slider:SetValue(75)

-- Получение значения слайдера
local value = slider:GetValue()

-- Изменение состояния переключателя
toggle:SetValue(true)

-- Обновление опций выпадающего списка
dropdown:UpdateOptions({"Новая опция 1", "Новая опция 2", "Новая опция 3"})
```

## 📘 Документация

### Основные функции

#### `createWindow(name, title, config)`
Создает основное окно библиотеки

**Параметры:**
- `name` (string) - Имя окна
- `title` (string) - Заголовок окна
- `config` (table) - Конфигурация окна
  - `draggable` (boolean) - Можно ли перетаскивать окно
  - `theme` (string) - Тема оформления ("default", "dark", "light", "purple", "blue")

**Возвращает:** Объект окна с методами

#### `window.createTab(name, icon)`
Создает новую вкладку в окне

**Параметры:**
- `name` (string) - Имя вкладки
- `icon` (string, опционально) - ID иконки Roblox

**Возвращает:** Объект вкладки с методами

#### `window.notification(title, text, duration)`
Показывает уведомление

**Параметры:**
- `title` (string) - Заголовок уведомления
- `text` (string) - Текст уведомления
- `duration` (number, опционально) - Длительность показа в секундах (по умолчанию: 5)

### Полный список компонентов

<details>
<summary>Развернуть список всех компонентов</summary>

#### Кнопки
```lua
tab.createButton(text, callback)
section.createButton(text, callback)
```

#### Текстовые метки
```lua
tab.createText(text, config)
section.createText(text, config)
```

#### Переключатели
```lua
tab.createToggle(text, default, callback)
section.createToggle(text, default, callback)
```

#### Слайдеры
```lua
tab.createSlider(text, config, callback)
section.createSlider(text, config, callback)
```

#### Выпадающие списки
```lua
tab.createDropdown(text, options, default, callback)
section.createDropdown(text, options, default, callback)
```

#### Текстовые поля
```lua
tab.createTextBox(text, placeholder, callback)
section.createTextBox(text, placeholder, callback)
```

#### Секции
```lua
tab.createSection(text, isOpen)
```
</details>

## 🎨 Темы

NyaCAST UI поддерживает 5 встроенных тем:

<div align="center">
  <table>
    <tr>
      <td align="center"><strong>Default</strong></td>
      <td align="center"><strong>Dark</strong></td>
      <td align="center"><strong>Light</strong></td>
    </tr>
    <tr>
      <td><img src="https://i.imgur.com/ZFNa9XE.png" width="200"></td>
      <td><img src="https://i.imgur.com/ZFNa9XE.png" width="200"></td>
      <td><img src="https://i.imgur.com/ZFNa9XE.png" width="200"></td>
    </tr>
    <tr>
      <td align="center"><strong>Purple</strong></td>
      <td align="center"><strong>Blue</strong></td>
      <td></td>
    </tr>
    <tr>
      <td><img src="https://i.imgur.com/ZFNa9XE.png" width="200"></td>
      <td><img src="https://i.imgur.com/ZFNa9XE.png" width="200"></td>
      <td></td>
    </tr>
  </table>
</div>

## 📝 Лицензия

Этот проект распространяется под лицензией MIT. См. файл `LICENSE` для получения дополнительной информации.

## 🤝 Вклад в проект

Вклады в проект приветствуются! Если у вас есть идеи или предложения, пожалуйста, создайте issue или pull request.

## 📞 Контакты

- GitHub: [@lolow2e](https://github.com/lolow2e)
- Discord: lolow2e

---

<div align="center">
  <p>Сделано с ❤️ by lolow2e</p>
</div>

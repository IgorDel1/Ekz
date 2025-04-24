-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Апр 24 2025 г., 06:41
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `cafe_management`
--

-- --------------------------------------------------------

--
-- Структура таблицы `dishes`
--

CREATE TABLE `dishes` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `dishes`
--

INSERT INTO `dishes` (`id`, `name`, `price`, `is_active`) VALUES
(1, 'Суп грибной', 250.00, 1),
(2, 'Стейк говяжий', 650.00, 1),
(3, 'Салат Цезарь', 350.00, 1),
(4, 'Пицца Маргарита', 450.00, 1),
(5, 'Кофе латте', 180.00, 1),
(6, 'Чай черный', 100.00, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `role` enum('admin','waiter','cook') NOT NULL,
  `login` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `hire_date` date NOT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `employees`
--

INSERT INTO `employees` (`id`, `full_name`, `role`, `login`, `password`, `hire_date`, `is_active`) VALUES
(1, 'Иванов Алексей Петрович', 'admin', 'admin1', '123', '2023-01-15', 1),
(2, 'Смирнова Елена Владимировна', 'waiter', 'waiter1', '$2a$10$X5v5XJz9UQ3eO3k1V2LQ3uJd5Xv5XJz9UQ3eO3k1V2LQ3uJd5Xv5XJz9', '2023-02-20', 1),
(3, 'Кузнецов Дмитрий Сергеевич', 'cook', 'cook1', '$2a$10$X5v5XJz9UQ3eO3k1V2LQ3uJd5Xv5XJz9UQ3eO3k1V2LQ3uJd5Xv5XJz9', '2023-03-10', 1),
(4, 'Петрова Анна Игоревна', 'waiter', 'waiter2', '$2a$10$X5v5XJz9UQ3eO3k1V2LQ3uJd5Xv5XJz9UQ3eO3k1V2LQ3uJd5Xv5XJz9', '2023-04-05', 1),
(5, 'Соколов Михаил Андреевич', 'cook', 'cook2', '$2a$10$X5v5XJz9UQ3eO3k1V2LQ3uJd5Xv5XJz9UQ3eO3k1V2LQ3uJd5Xv5XJz9', '2023-05-12', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `waiter_id` int(11) NOT NULL,
  `cook_id` int(11) NOT NULL,
  `total_sum` decimal(10,2) DEFAULT 0.00,
  `status` enum('created','in_progress','ready','paid','closed') DEFAULT 'created',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`id`, `shift_id`, `waiter_id`, `cook_id`, `total_sum`, `status`, `created_at`) VALUES
(1, 1, 2, 3, 800.00, 'paid', '2025-04-24 08:19:55'),
(2, 1, 2, 3, 1050.00, 'closed', '2025-04-24 08:19:55'),
(3, 2, 4, 5, 530.00, 'ready', '2025-04-24 08:19:55'),
(4, 3, 2, 3, 180.00, 'created', '2025-04-24 08:19:55');

-- --------------------------------------------------------

--
-- Структура таблицы `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `dish_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `dish_id`, `quantity`) VALUES
(1, 1, 2, 1),
(2, 1, 3, 1),
(3, 2, 4, 1),
(4, 2, 5, 2),
(5, 3, 1, 1),
(6, 3, 6, 1),
(7, 4, 5, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `shifts`
--

CREATE TABLE `shifts` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `shifts`
--

INSERT INTO `shifts` (`id`, `date`, `start_time`, `end_time`) VALUES
(1, '2023-10-01', '08:00:00', '16:00:00'),
(2, '2023-10-01', '16:00:00', '00:00:00'),
(3, '2023-10-02', '08:00:00', '16:00:00');

-- --------------------------------------------------------

--
-- Структура таблицы `shift_employees`
--

CREATE TABLE `shift_employees` (
  `id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `shift_employees`
--

INSERT INTO `shift_employees` (`id`, `shift_id`, `employee_id`) VALUES
(1, 1, 2),
(2, 1, 3),
(3, 2, 4),
(4, 2, 5),
(5, 3, 2),
(6, 3, 3);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `dishes`
--
ALTER TABLE `dishes`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shift_id` (`shift_id`),
  ADD KEY `waiter_id` (`waiter_id`),
  ADD KEY `cook_id` (`cook_id`);

--
-- Индексы таблицы `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `dish_id` (`dish_id`);

--
-- Индексы таблицы `shifts`
--
ALTER TABLE `shifts`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `shift_employees`
--
ALTER TABLE `shift_employees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shift_id` (`shift_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `dishes`
--
ALTER TABLE `dishes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `shifts`
--
ALTER TABLE `shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `shift_employees`
--
ALTER TABLE `shift_employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`waiter_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`cook_id`) REFERENCES `employees` (`id`);

--
-- Ограничения внешнего ключа таблицы `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`id`);

--
-- Ограничения внешнего ключа таблицы `shift_employees`
--
ALTER TABLE `shift_employees`
  ADD CONSTRAINT `shift_employees_ibfk_1` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `shift_employees_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

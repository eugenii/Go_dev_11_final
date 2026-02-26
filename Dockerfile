# Сборка
FROM golang:1.25.3-alpine AS builder

WORKDIR /app

# Копируем файлы зависимостей
COPY go.mod go.sum ./
RUN go mod download


# Копируем остальные файлы
COPY . .

# Собираем бинарник
RUN go build -o main .

# Запуск
FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/main .

CMD ["./main"]

# Всё запускается корректно, в приложении обновлены зависимости (go 1.25.3)
# Добавлена инициализация базы данных при запуске в файле main.go
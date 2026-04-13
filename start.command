#!/bin/bash
# ── Carousel Builder Launcher ──
# Двойной клик → открывает приложение + показывает адрес для iPhone/iPad

cd "$(dirname "$0")"

PORT=8787
if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
  PORT=8788
fi

# Узнаём локальный IP (для доступа с iPhone/iPad по WiFi)
LOCAL_IP=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null || echo "неизвестен")

clear
echo "╔══════════════════════════════════════════╗"
echo "║      Carousel Builder — EA Б.Р           ║"
echo "╠══════════════════════════════════════════╣"
echo "║                                          ║"
echo "║  На этом Mac:                            ║"
printf "║  %-40s  ║\n" "http://localhost:$PORT"
echo "║                                          ║"
echo "║  На iPhone / iPad (тот же WiFi):         ║"
printf "║  %-40s  ║\n" "http://$LOCAL_IP:$PORT"
echo "║                                          ║"
echo "║  Чтобы остановить — закройте это окно    ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# Открываем браузер на Mac через 1 секунду
(sleep 1 && open "http://localhost:$PORT") &

# Сервер на всех интерфейсах (0.0.0.0) — доступен и локально и по сети
python3 -m http.server $PORT --bind 0.0.0.0

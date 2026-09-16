#!/bin/bash

# Đảm bảo script đang được chạy bên trong một session Tmux
if [[ -z "$TMUX" ]]; then
  notify-send "Lỗi" "Script này phải được chạy bên trong Tmux!"
  exit 1
fi

# 1. Lấy thông tin Session, Window, và Pane hiện tại của Tmux
T_SESSION=$(tmux display-message -p '#S')
T_WINDOW=$(tmux display-message -p '#I')
T_PANE=$(tmux display-message -p '#P')

# Nội dung thông báo (hỗ trợ truyền argument từ command line)
TITLE="Tmux: $T_SESSION"
MSG="${1:-Cần phê duyệt lệnh tại Window: $T_WINDOW (Pane: $T_PANE)}"

# 2. Chạy subshell ngầm để terminal hiện tại không bị block (treo)
(
  # Tạo một tên ứng dụng (app-name) ngẫu nhiên/khác biệt cho từng Pane
  # Điều này giúp OS hiểu đây là các thông báo độc lập, không gộp chúng lại
  APP_ID="TmuxAlert_${T_SESSION}_${T_WINDOW}_${T_PANE}_$$"

  # Thêm cờ -a (app-name) và -u critical (đẩy độ ưu tiên lên cao nhất)
  ACTION=$(notify-send -a "$APP_ID" -u critical "$TITLE" "$MSG" --action="default=Mở" --wait)

  # Nếu user click vào thông báo (action trả về 'default')
  if [[ "$ACTION" == "default" ]]; then

    # Bước A: Yêu cầu Tmux nhảy về đúng Window và Pane đó
    tmux select-window -t "${T_SESSION}:${T_WINDOW}"
    tmux select-pane -t "${T_SESSION}:${T_WINDOW}.${T_PANE}"

    # Bước B: Lấy đường dẫn Socket và Window ID MỚI NHẤT trực tiếp từ Tmux
    # (Loại bỏ lỗi cache biến môi trường của Bash)
    LATEST_LISTEN_ON=$(tmux show-environment KITTY_LISTEN_ON 2>/dev/null | cut -d= -f2)
    LATEST_WINDOW_ID=$(tmux show-environment KITTY_WINDOW_ID 2>/dev/null | cut -d= -f2)

    if [[ -n "$LATEST_LISTEN_ON" && -n "$LATEST_WINDOW_ID" ]]; then
      kitty @ --to "$LATEST_LISTEN_ON" focus-window --match id:$LATEST_WINDOW_ID
    fi
  fi
) &
# VÔ CÙNG QUAN TRỌNG: Phải giữ lại dấu & ở ngay dòng trên để khối lệnh này chạy ngầm!

# 🌸 Zen Temple Live — Chánh Điện Tịnh Tâm Pro

> **Chánh điện online tương tác 2.5D dành cho TikTok LIVE & OBS Studio.**  
> Mỗi người xem bình luận sẽ tự động bước vào chánh điện an tọa tụng kinh. Người tặng quà sẽ được xướng danh hồi hướng công đức bằng giọng đọc tiếng Việt truyền cảm, trang nghiêm. Tích hợp nhạc thiền, chuông, mõ và đọc kinh luân phiên.

Dự án được fork, tái cấu trúc và tối ưu hóa chuyên sâu từ bản gốc `kentjuno/chanh-dien-online`, bổ sung cơ chế chống đụng độ cổng mạng, cache giọng đọc Edge TTS, vá lỗ hổng bảo mật và hỗ trợ kịch bản khởi chạy 1-click cho máy tính phát stream.

---

## ⚡ Các Điểm Cải Tiến & Tối Ưu Nổi Bật (Bản Pro)

| Hạng mục | Bản gốc | Bản Zen Temple Live Pro | Lợi ích thực tế |
|---|---|---|---|
| **Cổng mạng (Port)** | Cố định `3000` (dễ bị crash nếu port bận) | Tự động dò và đổi cổng thông minh (`3300` → `3301`...) | Không bao giờ lo bị lỗi `EADDRINUSE` khi đang mở nhiều phần mềm khác. |
| **Giọng đọc tụng kinh (TTS)** | Gọi mạng MsEdgeTTS mỗi lần xướng kinh | **Hash MD5 Cache cục bộ** trong `live/tts/cache` | Phát âm thanh tức thì, không độ trễ, không sợ bị Microsoft rate-limit. |
| **Bảo mật thư viện** | Gói `ws 8.18.0` dính lỗ hổng DoS & Memory | Đã nâng cấp `ws ^8.22.1` sạch lỗ hổng (`0 vulnerabilities`) | Ổn định và an toàn khi đón lượng tương tác lớn trên live. |
| **Dọn dẹp file tạm** | Xóa đồng bộ `fs.unlinkSync` trong request loop | Xóa bất đồng bộ ngầm (Async Non-blocking) | Tránh giật lag khung hình khi quà donate gửi về dồn dập. |
| **Khởi chạy Windows** | Phải mở terminal gõ nhiều câu lệnh | **File 1-Click `start.bat`** | Tự check Node.js, tự cài thư viện và tự mở trình duyệt. |
| **Cấu hình môi trường** | Hardcode trong file mã nguồn | Hỗ trợ file `.env` & `.env.example` | Tùy biến tiêu đề, giọng đọc, độ trầm bổng dễ dàng. |
| **Triển khai Container** | Chưa có | Kèm sẵn `Dockerfile` & `docker-compose.yml` | Tiện lợi cho ai muốn đưa lên VPS/Linux/NAS gia đình. |

---

## 🏛️ Cấu Trúc Dự Án

```text
zen-temple-live/
├── assets/             # Hình ảnh chánh điện, sprites nhân vật 2.5D, hiệu ứng hoa sen, chuông, mõ
├── live/               # Toàn bộ mã nguồn backend & giao diện phát stream
│   ├── control.html    # Bảng điều khiển livestream dành cho Host
│   ├── overlay.html    # Màn hình hiển thị sân khấu 9:16 (1080x1920) cho OBS / TikTok Studio
│   ├── server.mjs      # Server Node.js điều phối WebSocket, TikTok Connector & Edge TTS
│   └── tts/cache/      # Bộ nhớ đệm âm thanh các bài kinh & lời nguyện
├── index.html          # Bản web tĩnh nhẹ nhàng cho cá nhân tự vào chiêm bái (Cloudflare Pages)
├── start.bat           # Phím tắt 1-click khởi chạy tức thì trên Windows
├── Dockerfile          # Cấu hình đóng gói container
├── docker-compose.yml  # Kịch bản khởi chạy Docker
└── .env.example        # Mẫu file cấu hình tham số môi trường
```

---

## 🚀 Hướng Dẫn Cài Đặt & Sử Dụng

### Yêu Cầu Hệ Thống
- Máy tính chạy Windows 10/11, macOS hoặc Linux.
- Đã cài đặt **Node.js phiên bản 20 trở lên** ([Tải tại nodejs.org](https://nodejs.org/)).

---

### Cách 1: Khởi Chạy 1-Click Trên Windows (Khuyên Dùng)

1. Nhấp đúp vào file **`start.bat`**.
2. Script sẽ tự động kiểm tra Node.js, cài thư viện cần thiết và mở bảng điều khiển tại:  
   👉 `http://localhost:3300/live/control.html`

---

### Cách 2: Khởi Chạy Bằng Dòng Lệnh (CLI)

```bash
# 1. Đi vào thư mục live
cd live

# 2. Cài đặt các thư viện phụ thuộc
npm install

# 3. Khởi chạy server
npm start
```

---

## 🎥 Thiết Lập Livestream (OBS & TikTok LIVE Studio)

### 1. Mở Cửa Sổ Overlay & Bật Âm Thanh
- Trên **Bảng điều khiển** (`http://localhost:3300/live/control.html`), bấm **"Mở màn hình overlay 9:16"**.
- Trong cửa sổ mới mở ra, hãy bấm nút **"Bật âm thanh"** một lần (do cơ chế của trình duyệt chặn tự phát âm thanh nền).

### 2. Thêm Vào TikTok LIVE Studio
1. Mở TikTok LIVE Studio → Chọn **Thêm nguồn (Add Source)**.
2. Chọn **Quay cửa sổ (Window Capture)** → Chọn cửa sổ overlay của trình duyệt.
3. Chỉnh tỷ lệ khung hình đứng **9:16**.

### 3. Thêm Vào OBS Studio
1. Thêm nguồn **Browser** (Trình duyệt).
2. URL: `http://localhost:3300/live/overlay.html`
3. Chiều rộng: `1080` — Chiều cao: `1920`.
4. Tích chọn **"Control audio via OBS"** nếu muốn quản lý âm thanh qua bàn trộn OBS.

### 4. Kết Nối Phòng Live
1. Bắt đầu phát trực tiếp trên TikTok từ điện thoại hoặc phần mềm live.
2. Quay lại trang Bảng điều khiển, nhập `@username` của bạn (ví dụ: `@kenhtinhtam`).
3. Bấm **"Kết nối"**. Đèn trạng thái chuyển sang xanh lá là bạn đã sẵn sàng!

---

## 📿 Tương Tác Của Người Xem Trong Chánh Điện

| Hành động | Kết quả trên màn hình Live |
|---|---|
| **Bình luận bất kỳ** | Được tự động mời vào an tọa (tự co giãn 24 → 36 → 64 → 100 chỗ). |
| **Đổi hình tượng nhân vật** | Bình luận 1 trong các từ sau: `nam`, `nữ`, `sư`, `ni`, `tiểu`, `bà`, `cao tăng`. |
| **Tặng quà (Quà tặng/Hoa...)** | Hiện bảng vinh danh công đức, bay hoa sen/chuông/mõ rực rỡ, phát giọng đọc hồi hướng lấy theo bình luận gần nhất của phật tử. |
| **Thả tim màn hình** | Xuất hiện luồng tim sen bay lượn trên đầu nhân vật. |

---

## 🛠️ Cấu Hình Nâng Cao (`.env`)

Bạn có thể tạo một file `.env` tại thư mục gốc với các tùy chọn:

```ini
# Cổng chạy ứng dụng (Mặc định: 3300)
PORT=3300
HOST=127.0.0.1

# Tiêu đề trên bảng hoành phi chánh điện
TEMPLE_TITLE=Chánh Điện Tịnh Tâm
TEMPLE_SUBTITLE=Nam Mô A Di Đà Phật

# Giọng đọc xướng kinh: vi-VN-NamMinhNeural (nam) hoặc vi-VN-HoaiMyNeural (nữ)
DEFAULT_VOICE=vi-VN-NamMinhNeural
DEFAULT_PITCH=-18
DEFAULT_RATE=-20
```

---

## 🛡️ Cam Kết An Toàn & Bảo Mật

- **Tuyệt đối không can thiệp tài khoản**: Không cần mật khẩu, không cookie, không session, chỉ đọc dữ liệu tương tác công khai thông qua room ID của TikTok.
- **Bảo mật mạng nội bộ**: Server chỉ lắng nghe tại `127.0.0.1`, chặn DNS rebinding và kiểm tra Origin nghiêm ngặt của kết nối WebSocket.
- **Chống tràn dữ liệu**: Giới hạn độ dài chuỗi ký tự, mã hóa escape XML cho giọng đọc TTS, hiển thị chữ qua textContent/canvas an toàn trước các cuộc tấn công injection.

---

## 📜 Giấy Phép & Ghi Nhận (Credits)

- Giấy phép mã nguồn mở **MIT License**.
- Phát triển và đóng góp tối ưu dựa trên mã nguồn nguyên bản của tác giả **Huỳnh Hữu Nhân** (`kentjuno/chanh-dien-online`).
- Mọi đóng góp (Pull Request), báo lỗi hoặc đề xuất tính năng mới đều được chào đón!

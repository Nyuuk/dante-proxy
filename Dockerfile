FROM debian:latest

ENV USER_PROXY icc
ENV PASSWORD_PROXY DAU2024

# Instalasi Dante Server
RUN apt update && apt install -y dante-server passwd

# Buat user untuk autentikasi dan set password
# RUN useradd -m proxyuser && echo "${USER_PROXY}:${PASSWORD_PROXY}" | chpasswd
RUN useradd -m $USER_PROXY && echo "${USER_PROXY}:${PASSWORD_PROXY}" | chpasswd

# Salin konfigurasi Dante
COPY ./config/danted.conf /etc/danted.conf

# Ekspose port untuk SOCKS5
EXPOSE 1080

# Jalankan Dante saat container dimulai
CMD ["danted", "-f", "/etc/danted.conf"]

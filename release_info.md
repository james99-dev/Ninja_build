# 🥷 Ninja Build - GL-MT6000 (Flint 2)

Custom high-performance build based on **OpenWrt Master**. Optimized for speed, security, and specific routing needs.

## 🚀 Key Optimizations
- **Compiler**: Built using **LLVM/Clang** with **LTO** (Link Time Optimization) enabled.
- **CPU Tuning**: Optimized for Cortex-A53 (`-O2 -pipe -mcpu=cortex-a53+crc+crypto`).
- **Security**: Hardened with **Stack Protector Strong**, **ASLR PIE**, and **Fortify Source 2**.
- **SSL Stack**: Fully powered by **OpenSSL** (mbedTLS completely removed).

## 🛠️ Main Features & Inclusions
- **Kernel**: 6.12.x (Master branch)
- **Management UI**: `luci-app-advanced` (Deep system tuning) & `luci-app-commands` (Custom script execution).
- **DNS/Network**: `dnsmasq-full` (with DNSSEC & NFT set support), `irqbalance`, `pbr` (Policy Based Routing).
- **VPN**: Wireguard integration with `luci-proto-wireguard`.
- **System**: OpenSSH Server (configured for key-based auth), `jq`, `gawk`, `curl`, `htop`.
- **Media**: `minidlna` for local streaming.
- **Custom Scripts**: `toggle_xxxx` (or equivalent) for on-the-fly routing management and Duckdns script.

## 📶 Wireless Performance (via Pesa1234)
Optimized MediaTek proprietary drivers and tweaks:
- **WED (Wireless Ethernet Dispatch)**: Hardware offloading enabled for maximum throughput.
- **Advanced Coverage**: Implicit Beamforming (iBF) and VHT (QAM-256) on 2.4GHz and 5GHz band.
- **Stability**: Optimized EDCCA and airtime fairness for high-density environments.

## 🚫 Notable Exclusions (Lightweight approach)
To keep the build lean and fast, the following are **NOT** included:
- **No IPv6 DHCP**: `odhcp6c` and `odhcpd-ipv6only` are removed.
- **No mbedTLS**: All packages forced to use OpenSSL for consistency.
- **No SMB/Samba**: Focus is on routing performance, not NAS functions.

## 📦 Build Details
- **Build User**: Ninja-Builder
- **Build Date**: 2026-01-27

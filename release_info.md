# 🥷 Ninja Build - GL-MT6000 (Flint 2)

Custom high-performance build based on **OpenWrt Master**. Optimized for speed, security, and specific routing needs.

## 🚀 Key Optimizations
- **Compiler**: Built using **LLVM/Clang** with **LTO** (Link Time Optimization) enabled.
- **CPU Tuning**: Optimized for Cortex-A53 (`-O2 -pipe -mcpu=cortex-a53+crc+crypto`).
- **Security**: Hardened with **Stack Protector Strong**, **ASLR PIE**, and **Fortify Source 2**.
- **SSL Stack**: Fully powered by **OpenSSL** (mbedTLS completely removed).

## 🛠️ Main Features & Inclusions
- **Kernel**: 6.12.x (Master branch)
- **Wi-Fi**: MediaTek proprietary ucode & tweaks (via Pesa/Cjom).
- **DNS/Network**: `dnsmasq-full` (with DNSSEC & NFT set support), `irqbalance`, `pbr` (Policy Based Routing).
- **VPN**: Wireguard integration with `luci-proto-wireguard`.
- **System**: OpenSSH Server (configured for key-based auth), `jq`, `gawk`, `curl`, `htop`.
- **Media**: `minidlna` for local streaming.
- **Custom Scripts**: `toggle_xxxxx` included for on-the-fly routing management.

## 🚫 Notable Exclusions (Lightweight approach)
To keep the build lean and fast, the following are **NOT** included:
- **No IPv6 DHPC**: `odhcp6c` and `odhcpd-ipv6only` are removed.
- **No mbedTLS**: All packages forced to use OpenSSL for consistency.
- **No SMB/Samba**: USB storage is supported via Kernel, but network sharing is excluded.
- **No Debugging**: Kernel Debug FS and Kallsyms are disabled to reduce overhead.

## 📦 Build Details
- **Build User**: builder
- **Build Domain**: buildhost
- **Tag**: ${{ github.ref_name }}

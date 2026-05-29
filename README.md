# 网络加速与优化指南 677e70

[中文版] BBR/锐速/花生壳加速配置指南，显著提升 VPS 到国内的网络速度。

## 为什么要网络加速

海外 VPS 到中国大陆的网络延迟高、丢包率高。加速方案可以显著改善体验，推荐同时开启 BBR + 花生壳。

## BBR 加速

### 开启 BBR
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p

# 验证
sysctl net.ipv4.tcp_congestion_control
# 输出应为: bbr

## 花生壳（LCP）加速

wget -O lcp.sh https://raw.githubusercontent.com/flclash-us/vps-guide-677e70/main/lcp.sh
chmod +x lcp.sh
bash lcp.sh install
lcp start

## 综合优化脚本

wget -O tcp_optimize.sh https://raw.githubusercontent.com/flclash-us/vps-guide-677e70/main/tcp_optimize.sh
chmod +x tcp_optimize.sh
bash tcp_optimize.sh

## 内核参数调优

cat >> /etc/sysctl.conf << 'EOF'
net.core.rm_max = 2500000
net.core.netdev_max_backlog = 2500000
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_fin_timeout = 15
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_mtu_probing = 1
EOF
sysctl -p

## 效果对比

| 优化方式 | 带宽提升 | 延迟改善 |
|---------|---------|---------|
| 基础 BBR | +20-50% | -10% |
| BBR + 花生壳 | +50-200% | -40% |

## 常见问题

Q: 锐速和 BBR 能同时开吗？A: 不能，BBR 是内核拥塞控制算法，锐速是用户态加速器，会冲突。推荐 BBR + 花生壳组合。

## 许可证

MIT License

推荐工具

- [Clash for Windows](https://clashforwindows.site/) - Windows 最流行的 Clash 图形化客户端
- [ClashMI](https://clashmi.site/) - 轻量级 Clash 客户端，支持多平台
- [FlClash](https://flclash.us/) - 现代代理工具，支持多种协议
#!/bin/bash
# TCP 网络优化脚本 - 一键开启BBR和内核参数调优

cat >> /etc/sysctl.conf << '''EOF'''
# BBR 加速
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr

# 连接数调优
net.core.rm_max=2500000
net.core.netdev_max_backlog=2500000
net.ipv4.tcp_max_syn_backlog=8192
net.ipv4.tcp_fin_timeout=15
net.ipv4.tcp_fastopen=3
net.ipv4.tcp_mtu_probing=1
EOF

sysctl -p
echo "TCP优化完成"
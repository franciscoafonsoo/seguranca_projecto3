#!/bin/bash

I="/sbin/iptables"

$I -F
# already established
$I -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
$I -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
echo "already established"
# mask
$I -A INPUT -s 10.101.148.182/23 -p icmp -j ACCEPT
echo "mask"
# clients 
$I -A INPUT -p tcp --dport 23457 -j ACCEPT
echo "clients"
# ssh gcc
$I -A INPUT -s 10.101.151.5 -p tcp --dport ssh -j ACCEPT
echo "ssh gcc"
# icmp gcc
$I -A -OUTPUT -d 10.101.151.5 -p icmp -j ACCEPT
echo "icmp gcc"
# acessos default
$I -A INPUT -d "10.101.253.11, 10.101.253.12, 10.101.253.13, 10.121.53.14, 10.121.53.15, 10.101.53.16, 10.101.249.63, 10.101.85.6, 10.101.85.138, 10.101.85.18, 10.101.148.1, 10.101.85.134" -j ACCEPT
$I -A OUTPUT -d "10.101.253.11, 10.101.253.12, 10.101.253.13, 10.121.53.14, 10.121.53.15, 10.101.53.16, 10.101.249.63, 10.101.85.6, 10.101.85.138, 10.101.85.18, 10.101.148.1, 10.101.85.134" -j ACCEPT
echo "acessos default"
# unfilter loopback
$I -A INPUT -i lo -j ACCEPT
$I -A OUTPUT -o lo -j ACCEPT
echo "unfilter loopback"
# politica fechada
$I -A INPUT  -j DROP
$I -A OUTPUT -j DROP
echo "politica fechada"
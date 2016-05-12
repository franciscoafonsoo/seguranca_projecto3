#!/bin/bash

S="sudo"
I="/sbin/iptables"

$S $I -F
# already established
$S $I -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
$S $I -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# clients 
$S $I -A INPUT -p tcp --dport 23457 -j ACCEPT
# ssh gcc
$S $I -A INPUT -s 10.101.151.5 -p tcp --dport ssh -j ACCEPT
# icmp gcc
$S $I -A -OUTPUT -d 10.101.151.5 -p icmp -j ACCEPT
# acessos default
$S $I -A INPUT -d "10.101.253.11, 10.101.253.12, 10.101.253.13, 10.121.53.14, 10.121.53.15, 10.101.53.16, 10.101.249.63, 10.101.85.6, 10.101.85.138, 10.101.85.18, 10.101.148.1, 10.101.85.134" -j ACCEPT
$S $I -A OUTPUT -d "10.101.253.11, 10.101.253.12, 10.101.253.13, 10.121.53.14, 10.121.53.15, 10.101.53.16, 10.101.249.63, 10.101.85.6, 10.101.85.138, 10.101.85.18, 10.101.148.1, 10.101.85.134" -j ACCEPT
# unfilter loopback
$S $I -A INPUT -i lo -j ACCEPT
$S $I -A OUTPUT -o lo -j ACCEPT
# politica fechada
$S $I -A INPUT  -j DROP
$S $I -A OUTPUT -j DROP
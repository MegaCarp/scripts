# /etc/config/dhcp
uci set dhcp.Main=dhcp
uci set dhcp.Main.interface='Main'
uci set dhcp.Main.start='100'
uci set dhcp.Main.limit='150'
uci set dhcp.Main.leasetime='12h'
uci set dhcp.IoT=dhcp
uci set dhcp.IoT.interface='IoT'
uci set dhcp.IoT.start='100'
uci set dhcp.IoT.limit='150'
uci set dhcp.IoT.leasetime='12h'
uci set dhcp.IoT.start='1'
uci set dhcp.IoT.start='10'
# /etc/config/firewall
uci del firewall.cfg02dc81.network
uci add_list firewall.cfg02dc81.network='lan'
uci add_list firewall.cfg02dc81.network='Main'
uci del firewall.cfg02dc81.network
uci add_list firewall.cfg02dc81.network='lan'
uci add_list firewall.cfg02dc81.network='Main'
uci add_list firewall.cfg02dc81.network='IoT'
# /etc/config/network
uci add network bridge-vlan \# =cfg07a1b0
uci set network.@bridge-vlan[-1].device='br-lan'
uci set network.@bridge-vlan[-1].vlan='10'
uci add_list network.@bridge-vlan[-1].ports='lan3:t'
uci add network bridge-vlan \# =cfg08a1b0
uci set network.@bridge-vlan[-1].device='br-lan'
uci set network.@bridge-vlan[-1].vlan='20'
uci add_list network.@bridge-vlan[-1].ports='lan2:t'
uci set network.Main=interface
uci set network.Main.proto='static'
uci set network.Main.device='br-lan.10'
uci set network.globals.packet_steering='1'
uci set network.Main.ipaddr='192.168.10.1'
uci set network.Main.netmask='255.255.255.0'
uci set network.IoT=interface
uci set network.IoT.proto='static'
uci set network.IoT.device='br-lan.20'
uci set network.IoT.ipaddr='192.168.20.1'
uci set network.IoT.netmask='255.255.255.0'
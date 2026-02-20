# /etc/config/dhcp
uci del dhcp.lan.ra_slaac
uci set dhcp.lan.start='10'
uci set dhcp.lan.limit='200'
uci set dhcp.Media=dhcp
uci set dhcp.Media.interface='Media'
uci set dhcp.Media.start='100'
uci set dhcp.Media.limit='150'
uci set dhcp.Media.leasetime='12h'
uci set dhcp.Media.start='10'
uci set dhcp.Media.limit='200'
uci set dhcp.Media.master='1'
uci del dhcp.Media.master
uci set dhcp.IoT=dhcp
uci set dhcp.IoT.interface='IoT'
uci set dhcp.IoT.start='100'
uci set dhcp.IoT.limit='150'
uci set dhcp.IoT.leasetime='12h'
uci set dhcp.IoT.start='10'
uci set dhcp.IoT.limit='200'
uci set dhcp.Guest=dhcp
uci set dhcp.Guest.interface='Guest'
uci set dhcp.Guest.start='100'
uci set dhcp.Guest.limit='150'
uci set dhcp.Guest.leasetime='12h'
uci set dhcp.Guest.start='10'
uci set dhcp.Guest.limit='200'
uci set dhcp.PTest=dhcp
uci set dhcp.PTest.interface='PTest'
uci set dhcp.PTest.start='100'
uci set dhcp.PTest.limit='150'
uci set dhcp.PTest.leasetime='12h'
uci set dhcp.PTest.start='10'
uci set dhcp.PTest.limit='200'
uci del dhcp.PTest
uci set dhcp.Test=dhcp
uci set dhcp.Test.interface='Test'
uci set dhcp.Test.start='100'
uci set dhcp.Test.limit='150'
uci set dhcp.Test.leasetime='12h'
uci set dhcp.Test.start='10'
uci set dhcp.Test.limit='200'
# /etc/config/firewall
uci del firewall.cfg02dc81.network
uci add_list firewall.cfg02dc81.network='lan'
uci del firewall.cfg03dc81.network
uci add_list firewall.cfg03dc81.network='wan'
uci add_list firewall.cfg03dc81.network='wan6'
uci del firewall.cfg02dc81.network
uci add_list firewall.cfg02dc81.network='Guest'
uci add_list firewall.cfg02dc81.network='IoT'
uci add_list firewall.cfg02dc81.network='Media'
uci add_list firewall.cfg02dc81.network='Test'
uci add_list firewall.cfg02dc81.network='lan'
# /etc/config/momo
uci del momo.proxy.lan_inbound_interface
uci add_list momo.proxy.lan_inbound_interface='lan'
uci add_list momo.proxy.lan_inbound_interface='Guest'
uci add_list momo.proxy.lan_inbound_interface='Media'
uci del momo.proxy.lan_inbound_interface
uci add_list momo.proxy.lan_inbound_interface='Test'
# /etc/config/network
uci add network bridge-vlan # =cfg07a1b0
uci set network.@bridge-vlan[-1].device='br-lan'
uci set network.@bridge-vlan[-1].vlan='10'
uci add_list network.@bridge-vlan[-1].ports='lan3:t'
uci add network bridge-vlan # =cfg08a1b0
uci set network.@bridge-vlan[-1].device='br-lan'
uci set network.@bridge-vlan[-1].vlan='20'
uci add network bridge-vlan # =cfg09a1b0
uci set network.@bridge-vlan[-1].device='br-lan'
uci set network.@bridge-vlan[-1].vlan='30'
uci add network bridge-vlan # =cfg0aa1b0
uci set network.@bridge-vlan[-1].device='br-lan'
uci set network.@bridge-vlan[-1].vlan='40'
uci set network.lan.device='br-lan.10'
uci set network.lan.ipaddr='192.168.10.1'
uci set network.Media=interface
uci set network.Media.proto='static'
uci set network.Media.device='br-lan.20'
uci set network.globals.packet_steering='1'
uci set network.Media.ipaddr='192.168.20.1'
uci set network.Media.netmask='255.255.255.0'
uci set network.IoT=interface
uci set network.IoT.proto='static'
uci set network.IoT.device='br-lan.30'
uci set network.IoT.ipaddr='192.168.30.1'
uci set network.IoT.netmask='255.255.255.0'
uci set network.Guest=interface
uci set network.Guest.proto='static'
uci set network.Guest.device='br-lan.40'
uci set network.Guest.ipaddr='192.168.40.1'
uci set network.Guest.netmask='255.255.255.0'
uci del network.cfg07a1b0.ports
uci add_list network.cfg07a1b0.ports='lan3'
uci add_list network.cfg08a1b0.ports='lan3'
uci add_list network.cfg09a1b0.ports='lan3'
uci add_list network.@bridge-vlan[-1].ports='lan3'
uci set network.lan.type='bridge'
uci set network.Media.type='bridge'
uci set network.IoT.type='bridge'
uci set network.Guest.type='bridge'
uci del network.cfg07a1b0
uci del network.cfg08a1b0
uci del network.cfg09a1b0
uci del network.@bridge-vlan[-1]
uci add network bridge-vlan # =cfg0ea1b0
uci set network.@bridge-vlan[-1].device='br-lan'
uci set network.@bridge-vlan[-1].vlan='10'
uci add_list network.@bridge-vlan[-1].ports='lan3'
uci add network bridge-vlan # =cfg0fa1b0
uci set network.@bridge-vlan[-1].device='br-lan'
uci set network.@bridge-vlan[-1].vlan='20'
uci add_list network.@bridge-vlan[-1].ports='lan3'
uci add network bridge-vlan # =cfg10a1b0
uci set network.@bridge-vlan[-1].device='br-lan'
uci set network.@bridge-vlan[-1].vlan='30'
uci add_list network.@bridge-vlan[-1].ports='lan3'
uci add network bridge-vlan # =cfg11a1b0
uci set network.@bridge-vlan[-1].device='br-lan'
uci set network.@bridge-vlan[-1].vlan='40'
uci add_list network.@bridge-vlan[-1].ports='lan3'
uci add network bridge-vlan # =cfg12a1b0
uci set network.@bridge-vlan[-1].device='br-lan'
uci set network.@bridge-vlan[-1].vlan='50'
uci add_list network.@bridge-vlan[-1].ports='lan3'
uci set network.PTest=interface
uci set network.PTest.proto='static'
uci set network.PTest.device='br-lan.50'
uci set network.PTest.ipaddr='192.168.1.50'
uci set network.PTest.netmask='255.255.255.0'
uci del network.PTest
uci set network.Test=interface
uci set network.Test.proto='static'
uci set network.Test.device='br-lan.50'
uci set network.Test.ipaddr='192.168.50.1'
uci set network.Test.netmask='255.255.255.0'
uci set network.Test.type='bridge'
uci del network.cfg0ea1b0
uci del network.cfg0fa1b0
uci del network.cfg10a1b0
uci del network.cfg11a1b0
uci del network.@bridge-vlan[-1]
uci add network bridge-vlan # =cfg15a1b0
uci set network.@bridge-vlan[-1].device='br-lan'
uci set network.@bridge-vlan[-1].vlan='10'
uci add_list network.@bridge-vlan[-1].ports='lan3'
uci add network bridge-vlan # =cfg16a1b0
uci set network.@bridge-vlan[-1].device='br-lan'
uci set network.@bridge-vlan[-1].vlan='20'
uci add_list network.@bridge-vlan[-1].ports='lan3'
uci add network bridge-vlan # =cfg17a1b0
uci set network.@bridge-vlan[-1].device='br-lan'
uci set network.@bridge-vlan[-1].vlan='30'
uci add_list network.@bridge-vlan[-1].ports='lan3'
uci add network bridge-vlan # =cfg18a1b0
uci set network.@bridge-vlan[-1].device='br-lan'
uci set network.@bridge-vlan[-1].vlan='40'
uci add_list network.@bridge-vlan[-1].ports='lan3'
uci add network bridge-vlan # =cfg19a1b0
uci set network.@bridge-vlan[-1].device='br-lan'
uci set network.@bridge-vlan[-1].vlan='50'
uci add_list network.@bridge-vlan[-1].ports='lan3'
# /etc/config/wireless
uci del wireless.default_radio0
uci del wireless.default_radio1
uci del wireless.radio1.disabled
uci set wireless.wifinet0=wifi-iface
uci set wireless.wifinet0.device='radio1'
uci set wireless.wifinet0.mode='ap'
uci set wireless.wifinet0.ssid='Personal'
uci set wireless.wifinet0.encryption='none'
uci set wireless.wifinet0.network='lan'
uci set wireless.radio1.channel='auto'
uci set wireless.radio1.country='RU'
uci set wireless.radio1.cell_density='0'
uci set wireless.wifinet0.encryption='sae'
uci set wireless.wifinet0.key='reassign overlap vending'
uci set wireless.wifinet0.ocv='0'
uci set wireless.wifinet1=wifi-iface
uci set wireless.wifinet1.device='radio0'
uci set wireless.wifinet1.mode='ap'
uci set wireless.wifinet1.ssid='PMedia'
uci set wireless.wifinet1.encryption='sae'
uci set wireless.wifinet1.key='slot deodorant manatee'
uci set wireless.wifinet1.ocv='0'
uci set wireless.wifinet1.network='Media'
uci set wireless.radio0.country='RU'
uci set wireless.wifinet2=wifi-iface
uci set wireless.wifinet2.device='radio0'
uci set wireless.wifinet2.mode='ap'
uci set wireless.wifinet2.ssid='PIoT'
uci set wireless.wifinet2.encryption='sae'
uci set wireless.wifinet2.key='overhaul washhouse suing'
uci set wireless.wifinet2.ocv='0'
uci set wireless.wifinet2.network='IoT'
uci set wireless.radio0.channel='auto'
uci set wireless.wifinet3=wifi-iface
uci set wireless.wifinet3.device='radio1'
uci set wireless.wifinet3.mode='ap'
uci set wireless.wifinet3.ssid='PGuest'
uci set wireless.wifinet3.encryption='sae'
uci set wireless.wifinet3.key='1874 1238 3127'
uci set wireless.wifinet3.ocv='0'
uci set wireless.wifinet3.network='Guest'
uci set wireless.wifinet4=wifi-iface
uci set wireless.wifinet4.device='radio1'
uci set wireless.wifinet4.mode='ap'
uci set wireless.wifinet4.ssid='PTest'
uci set wireless.wifinet4.encryption='sae'
uci set wireless.wifinet4.key='trio conceal lumping'
uci set wireless.wifinet4.ocv='0'
uci set wireless.wifinet4.network='Test'
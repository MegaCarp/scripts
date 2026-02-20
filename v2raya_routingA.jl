

# Set the default outbound, if not set, the default is proxy (this option only applies to the default inbound)
default: proxy

# Default three outbounds: proxy, block, direct

# ads
domain(geosite:category-ads-all)->block

# Domain name rules
domain(domain: v2raya.org) -> proxy
domain(full: dns.google) -> proxy
domain(contains: facebook) -> proxy
domain(regexp: \.goo.*\.com$) -> proxy

# Direct for Russian sites & IPs

# domain(geosite:ru)->direct
domain(geosite:category-ru)->direct
# ip(geoip:category-ru)->direct
ip(geoip:ru)->direct
ip(geoip:!ru)->proxy

# choina 
# domain(geosite:cn)->direct


# Destination IP rules
ip(8.8.8.8) -> direct
ip(101.97.0.0/16) -> direct
ip(127.0.0.0/8)->direct
ip(10.0.0.0/8)->direct
ip(172.16.0.0/12)->direct
ip(192.168.0.0/16)->direct
ip(geoip:private) -> direct


# domain(geosite:cdn)->direct
domain(geosite:category-cdn-!cn)->direct
domain(youtube:com)->proxy
# domain(geosite:google, geosite:google-mail)->proxy
# Force proxy for major international services and circumvention lists


# Mail, banking, government in RU go direct for compatibility

# domain(geosite:banking)->direct
domain(geosite:category-gov-ru)->direct

# Fallbacks

domain(localhost)->direct
final: proxy


# source IP rule
# source(192.168.50.0/24) -> direct

# Destination port rules
# port(80) -> direct
# port(10080-30000) -> direct

# source port rules
# sourcePort(38563) -> direct
# sourcePort(10080-30000) -> direct

# Multi-domain rules
# domain(contains: google, domain: www.twitter.com, domain: v2raya.org) -> proxy
# Multiple IP rules
# ip(geoip:cn, geoip:private) -> direct
# ip(9.9.9.9, 223.5.5.5) -> direct
# source(192.168.0.6, 192.168.0.10, 192.168.0.15) -> direct

# inbound inbound rules
# inboundTag(httpauthin, socksauthin) -> direct
# inboundTag(sockslocalin) -> special

# Also satisfy the rules
# ip(geoip:cn) && port(80) && user(mzz2017@tuta.io) -> direct
# ip(8.8.8.8) && network(tcp, udp) && port(1-1023, 8443) -> proxy
# ip(1.1.1.1) && protocol(http) && source(10.0.0.1, 172.20.0.0/16) -> direct


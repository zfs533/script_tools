#!/usr/bin/ruby -w
require 'socket'
$mac_password = ""
def findCurrentIp(ip)
    if ip == "192.168.1.119" then
        $mac_password = "541987"
        return true
    elsif ip == "103.228.153.191" then
        $mac_password = "w7c34ztz777"
        return true
    elsif ip == "223.25.237.104" then
        $mac_password = "bqdbinw4y4g"
        return true
    else

    end
    return false
end

addr_infos = Socket.ip_address_list
addr_infos.each do |addr_info|
    bool = findCurrentIp(addr_info.ip_address)
    if bool == true then
        break
    end
end

puts $mac_password











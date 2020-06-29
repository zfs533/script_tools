puts "设备数启动时间 : " + Time.new.strftime("%M:%S")
require 'spaceship'
$content
def getYanZhenCode()
    aFile = File.new("yzm.txt", "r")
    if aFile then
        $content = aFile.sysread(6)
        puts $content
        if $content.length != 6 then
            sleep(1)
            getYanZhenCode()
        end
    else
        puts "failed to read file yzm.txt"
        exit 11
    end
    aFile.close
    return $content
end
def login(user, pwd)
    aFile = File.new("yzm.txt", "w")
    aFile.syswrite(1)
    aFile.close
    Spaceship::Portal.login(user, pwd,method(:getYanZhenCode))
    # Spaceship::Portal.login(user, pwd)

    rescue Exception => e
    message = "#{e.class.name}: #{e.message}"
    say message
    exit 2
end

def main(argv)
    user = argv[0]
    pwd  = argv[1]
    login(user, pwd)
end

main(ARGV)

puts "设备数结束时间 : " + Time.new.strftime("%M:%S")
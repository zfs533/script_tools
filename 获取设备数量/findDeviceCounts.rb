require 'spaceship'

def login(user, pwd)
    puts "开始登陆"
    Spaceship::Portal.login(user, pwd)

    rescue Exception => e
    message = "#{e.class.name}: #{e.message}"
    say message
    exit 2
end

def testF()
    puts "------------all_devices------------"
    all_devices = Spaceship::Portal.device.all
    puts all_devices.size
    puts "------------end------------"
end

#zhanghao mima zhanghao mima
def main(argv)
    puts "--------------creatCert.rb-------------"
    # user= "mu5fzv@163.com"
    # user= "hi2zxl@163.com"
    # pwd="Fengli1."
    argv = ["mu5fzv@163.com","Fengli1.","hi2zxl@163.com","Fengli1."]
    # ------------
    user = "pe53ff@126.com"
    pwd = "Jy1314520"
    users = Array.new
    for idx in 0...argv.size
        index = idx%2
        if index == 1 then
            temp = Array.new
            temp.push(argv[idx-1])
            temp.push(argv[idx])
            users.push(temp)
        end
    end
    
    for idx in 0...users.size
        user = users[idx][0]
        pwd  = users[idx][1]
        puts "user     : #{user}","password : #{pwd}"
        login(user, pwd)
        testF()
    end
    


end

main(ARGV)

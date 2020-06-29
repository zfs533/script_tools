puts "启动时间 : " + Time.new.strftime("%M:%S")
require 'spaceship'

def login(user, pwd)
    puts "开始登陆"
    Spaceship::Portal.login(user, pwd)

    rescue Exception => e
    message = "#{e.class.name}: #{e.message}"
    say message
    exit 2
end

# 设置属性
def setPorperty(app_bId)
    #-----------------
    app_bId.update_service(Spaceship.app_service.in_app_purchase.on)
    app_bId.update_service(Spaceship.app_service.class_kit.on)
    app_bId.update_service(Spaceship.app_service.access_wifi.on)
    app_bId.update_service(Spaceship.app_service.apple_pay.on)#--
    app_bId.update_service(Spaceship.app_service.associated_domains.on)
    app_bId.update_service(Spaceship.app_service.auto_fill_credential.on)
    app_bId.update_service(Spaceship.app_service.data_protection.unless_open)
    app_bId.update_service(Spaceship.app_service.game_center.on)
    app_bId.update_service(Spaceship.app_service.health_kit.on)
    app_bId.update_service(Spaceship.app_service.home_kit.on)
    app_bId.update_service(Spaceship.app_service.wallet.on)
    app_bId.update_service(Spaceship.app_service.wireless_accessory.on)
    app_bId.update_service(Spaceship.app_service.inter_app_audio.on)
    app_bId.update_service(Spaceship.app_service.personal_vpn.on)
    app_bId.update_service(Spaceship.app_service.passbook.on)
    app_bId.update_service(Spaceship.app_service.vpn_configuration.on)
    app_bId.update_service(Spaceship.app_service.network_extension.on)
    app_bId.update_service(Spaceship.app_service.hotspot.on)
    app_bId.update_service(Spaceship.app_service.multipath.on)
    app_bId.update_service(Spaceship.app_service.nfc_tag_reading.on)
    #-----------------
    app_bId.update_service(Spaceship::Portal.app_service.siri_kit.on)
    app_bId.update_service(Spaceship::Portal.app_service.app_group.on)
    app_bId.update_service(Spaceship::Portal.app_service.push_notification.on)
    app_bId.update_service(Spaceship::Portal.app_service.cloud.on)
    app_bId.update_service(Spaceship::Portal.app_service.cloud_kit.cloud_kit)
end

def createBundleId(bundleId)
    puts "-------------------#{bundleId}-----------------"
    app = Spaceship::Portal.app.find(bundleId)
    if !app.nil?
        app.delete!
        # app = Spaceship::Portal.app.create!(bundle_id: bundleId, name: bundleId)
    end
    # setPorperty(app)
end

$count = 200
def start_create()
    50.times.map do |i|
        Thread.new do
            $count = $count+1
            bundmodel = "com.testcjkd.hskldfj"
            bundmodel = bundmodel + $count.to_s
            createBundleId(bundmodel)
        end
    end.map(&:join)
    start_create()
end

def main(argv)
    puts "--------------createBundleId.rb-------------"
    user="mpr53p@126.com"
    pwd="Jy1314520"
    puts "user     : #{user}","password : #{pwd}"
    login(user, pwd)
    start_create()
    puts "-----------finished...-----------"
end

main(ARGV)

puts "结束时间 : " + Time.new.strftime("%M:%S")
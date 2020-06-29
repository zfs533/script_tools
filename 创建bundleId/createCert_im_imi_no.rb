require 'spaceship'

def login(user, pwd)
    puts "开始登陆"
    Spaceship::Portal.login(user, pwd)

    rescue Exception => e
    message = "#{e.class.name}: #{e.message}"
    say message
    exit 2
end

def createCertAndProfile(bundleids)
    # puts "正在创建.certSigningRequest文件及key文件"
    # csr, pkey = Spaceship::Portal.certificate.create_certificate_signing_request

    # puts "正在创建证书文件"
    # cert=Spaceship::Portal.certificate.development.create!(csr: csr)

    # puts "正在创建推送证书"
    # bundleids.each do |bundleid|
    #     apscert=Spaceship::Portal.certificate.production_push.create!(csr: csr, bundle_id:bundleid)
    # end
    # rescue Exception => e
    # message = "#{e.class.name}: #{e.message}"
    # say message
    # return false
end

# 设置属性
def setPorperty(app_bId,group,container,merchant)
    #-----------------
    # app_bId.update_service(Spaceship.app_service.in_app_purchase.on)
    # app_bId.update_service(Spaceship.app_service.class_kit.on)
    # app_bId.update_service(Spaceship.app_service.access_wifi.on)
    # app_bId.update_service(Spaceship.app_service.apple_pay.on)#--
    # app_bId.update_service(Spaceship.app_service.associated_domains.on)
    # app_bId.update_service(Spaceship.app_service.auto_fill_credential.on)
    # app_bId.update_service(Spaceship.app_service.data_protection.unless_open)
    # app_bId.update_service(Spaceship.app_service.game_center.on)
    # app_bId.update_service(Spaceship.app_service.health_kit.on)
    # app_bId.update_service(Spaceship.app_service.home_kit.on)
    # app_bId.update_service(Spaceship.app_service.wallet.on)
    # app_bId.update_service(Spaceship.app_service.wireless_accessory.on)
    # app_bId.update_service(Spaceship.app_service.inter_app_audio.on)
    # app_bId.update_service(Spaceship.app_service.personal_vpn.on)
    # app_bId.update_service(Spaceship.app_service.passbook.on)
    # app_bId.update_service(Spaceship.app_service.vpn_configuration.on)
    # app_bId.update_service(Spaceship.app_service.network_extension.on)
    # app_bId.update_service(Spaceship.app_service.hotspot.on)
    # app_bId.update_service(Spaceship.app_service.multipath.on)
    # app_bId.update_service(Spaceship.app_service.nfc_tag_reading.on)
    # #-----------------
    # app_bId.update_service(Spaceship::Portal.app_service.siri_kit.on)
    # app_bId.update_service(Spaceship::Portal.app_service.app_group.on)
    # app_bId.update_service(Spaceship::Portal.app_service.push_notification.on)
    # app_bId.update_service(Spaceship::Portal.app_service.cloud.on)
    # app_bId.update_service(Spaceship::Portal.app_service.cloud_kit.cloud_kit)
    # app_bId.associate_groups([group])
    # app_bId.associate_cloud_containers([container])
    # app_bId.associate_merchants([merchant])
end

def createBundleId(bundleId)

    # 创建一个存放所有bundleId的数组
    bundleIdArr = Array.new

    # 创建iCloud bundleId
    container = Spaceship::Portal.cloud_container.find("iCloud." + bundleId)
    if container.nil?
        container = Spaceship::Portal.cloud_container.create!(identifier: "iCloud." + bundleId, name: "iCloud." + bundleId)
    end

    # 创建group bundleId
    group = Spaceship::Portal.app_group.find("group." + bundleId)
    if group.nil?
        group = Spaceship::Portal.app_group.create!(group_id: "group." + bundleId, name: "group." + bundleId)
    end
    #创建 merchant id
    merchant = Spaceship::Portal.merchant.find("merchant." + bundleId)
    if merchant.nil?
        m_name = "merchant."+bundleId
        merchant = Spaceship::Portal.merchant.create!(bundle_id: "merchant." + bundleId, name: m_name.gsub("\.",""))
    end

    # 创建主bundleId
    puts "--------------main bundleId--------------"
    app = Spaceship::Portal.app.find(bundleId)
    if app.nil?
        bId = Spaceship::Portal.app.create!(bundle_id: bundleId, name: bundleId)
    else
        if app.bundle_id == bundleId
            bId = app
        end
    end
    bundleIdArr.push(bId.bundle_id)
    # 设置属性
    setPorperty(bId,group,container,merchant)
    return bundleIdArr
end

def main(argv)
    user=argv[0]
    pwd=argv[1]
    bundleid=argv[2]
    
    puts "user     : #{user}","password : #{pwd}","bundlieID: #{bundleid}"
    login(user, pwd)
    bundleids = createBundleId(bundleid)
    puts "-----------createbundleid finished...-----------"
    createCertAndProfile(bundleids)
end

main(ARGV)

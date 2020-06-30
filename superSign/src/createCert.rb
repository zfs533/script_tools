require 'spaceship'

def login(user, pwd)
    puts "开始登陆"
    Spaceship::Portal.login(user, pwd)

    rescue Exception => e
    message = "#{e.class.name}: #{e.message}"
    say message
    exit 2
end

def createCertAndProfile(path, bundleids)
    # 判断有没有证书，有则删除
    dev_certs = Spaceship::Portal.certificate.development.all.first
    if dev_certs != nil
        dev_certs.revoke!
    end

    #删除所有开发描述文件
    profiles_dev = Spaceship::Portal.provisioning_profile.development.all
    for profiles in profiles_dev
      profiles.delete!
    end

    # if dev_certs == nil 
        puts "正在创建.certSigningRequest文件及key文件"
        csr, pkey = Spaceship::Portal.certificate.create_certificate_signing_request
    
        puts "正在创建证书文件"
        cert=Spaceship::Portal.certificate.development.create!(csr: csr)

        puts "正在创建推送证书"
        bundleids.each do |bundleid|
            apscert=Spaceship::Portal.certificate.production_push.create!(csr: csr, bundle_id:bundleid)
        end
    # else
    #     cert = dev_certs
    # end
    puts "下载key文件"
    File.write("#{path}/pkey.key", pkey)

    puts "下载证书文件"
    File.write("#{path}/ios_distribution.cer", cert.download)

    addUUID()

    bundleids.each do |bundleid|
        puts "正在创建描述文件"
        profile=Spaceship::Portal.provisioning_profile.development.create!(bundle_id: bundleid, certificate: cert)
        puts "下载描述文件"
        File.write("#{path}/#{bundleid}.mobileprovision", profile.download)
    end

    # if dev_certs == nil
        puts "下载p12文件"
        exportP12(path, "#{path}/pkey.key", "#{path}/ios_distribution.cer")
        puts "安装p12"
        system "security unlock-keychain -p Tibao11. $HOME/Library/Keychains/login.keychain-db"
        system "security import #{path}/p12.p12 -k $HOME/Library/Keychains/login.keychain-db -P 123 -A -T /usr/bin/codesign" 
    # end

    return true
    rescue Exception => e
    message = "#{e.class.name}: #{e.message}"
    say message
    return false
end

# 导出p12
def exportP12(path, pkeyPath, certPath)
    certPath=File.expand_path("#{certPath}")
    pemPath=File.expand_path("#{path}/pem.pem")
    p12Path=File.expand_path("#{path}/p12.p12")
    system "cp #{certPath} #{pemPath}"
    system "openssl pkcs12 -export -inkey #{pkeyPath} -in #{pemPath} -out #{p12Path} -password pass:123"
    system "rm #{pemPath}"
    system "rm #{pkeyPath}"
    system "rm #{certPath}"

    rescue Exception => e
    message = "#{e.class.name}: #{e.message}"
    say message
    exit 2
end

def StartAddUUID(namee,uuidd)
    name = namee
    uuid = uuidd
    Spaceship::Portal.device.create!(name: name, udid: uuid)
end

def addUUID()
    # Get all enabled devices
    all_devices = Spaceship::Portal.device.all
    uuidList = [
        "5f56a8a305f06191edb1ad70bfc23a17786ced74",
        "00008020-000D38E90101002E",
        "8afb3c2b11c1fd309939b89873181aa5cfd5d6af",
        "7668fa0cc28fdc17bc9aa9669358b60a12314d15",
        "e35f7a54d9ebdc1b7f4b972a0b649416eb7ac431",
    ]
    name = "phone"
    i = 1
    uuidList.each do |uid|
        StartAddUUID(uid,uid)
    end

    puts "添加设备完成"
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

$allTargets 

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

    tempBidArr = []
    tempBidArr.push(bundleId)
    $allTargets.each do |tgt|
        bid = bundleId + "." +tgt
        tempBidArr.push(bid)
    end

    mutex = Mutex.new
    tempBidArr.length.times.map do |i|
        Thread.new do
            puts "-------------------#{i}-----------------"
            bid = tempBidArr[i]
            puts bid
            app = Spaceship::Portal.app.find(bid)
            if app.nil?
                app = Spaceship::Portal.app.create!(bundle_id: bid, name: bid)
            end
            bundleIdArr.push(app.bundle_id)
            setPorperty(app,group,container,merchant)
        end
    end.map(&:join)

    return bundleIdArr
end


def testF()
    puts "------------testF------------"
    dev_certs = Spaceship::Portal.certificate.development.all.first
    all_devices = Spaceship::Portal.device.all
    puts all_devices.size
    puts "------------end------------"
end


def main(argv)
    puts "--------------creatCert.rb-------------"
    user=argv[0]
    pwd=argv[1]
    bundleid=argv[2]
    path=argv[3]
    mainBunledId=argv[4]
    ipaName=argv[5]
    
    puts "user     : #{user}","password : #{pwd}","bundlieID: #{bundleid}","path     : #{path}","ipaName     : #{ipaName}","mainBunledId     : #{mainBunledId}"
    puts argv[6]
    puts argv[7]
    puts argv[8]
    
    $allTargets = Array.new
    commands = "python src/resign.py "+mainBunledId+" "+bundleid+" "+ipaName
    for idx in 6...argv.size
        commands +=" " +argv[idx]+" "
        $allTargets.push(argv[idx])
    end

    
    FileUtils.mkdir_p(path) unless File.exists?(path)
    login(user, pwd)

    # testF()
    # system "python src/deleteCertificate.py" 
    bundleids = createBundleId(bundleid)
    puts "-----------createbundleid finished...-----------"
    createCertAndProfile(path, bundleids)
    puts "--------------start resign----------------"
    
    system commands
end

main(ARGV)

# -*- coding: utf-8 -*
import sys
import os
# from psutil import net_if_addrs

# def getMacPassword():
#     for k, v in net_if_addrs().items():
#         for item in v:
#             address = item.address
#             if address == "192.168.1.119" :
#                 return "Tibao11."
#             elif address == "223.25.237.104":
#                 return "bqdbinw4y4g"
#             elif address == "103.228.153.191":
#                 return "w7c34ztz777"


#"iPhone Developer: Osmond Grace (QMX66TZQUP)"
def get_cert_name(p12):
    """
    获取证书名称
    先把p12转成pem，在从pem中提取出合适的名字，最后删除pem
    """
    tpm = "chmod 600 %s \nopenssl pkcs12 -in %s -out cert.pem -clcerts -nokeys -password pass:123>/dev/null 2>&1" % (
        p12, p12)
    result = os.system(tpm)
    if(result == 0):
        info = os.popen("openssl x509 -in cert.pem -noout -subject").read()
        start = info.find("CN=")
        end = info.find("OU")
        result = info[start+3:end-1]
        # os.system("rm -rf cert.pem")
        return result
        # return info[info.find("CN=")+3: info.find("/OU=")]


if __name__ == '__main__':
    print("---------resign.py---------")
    print("mainBunledId : "+sys.argv[1])
    print("bundleid : "+sys.argv[2])
    print("ipaName : "+sys.argv[3])
    p12Path = "src/cert/p12.p12"
    ipaPath = "src/ipa/"+sys.argv[3]+".ipa"
    outPath = "src/ipa/"+sys.argv[3]+"_out.ipa"
    shellPath = "src/resign_linux.sh"
    cert_name = get_cert_name(p12Path)
    print("certname:"+cert_name)

    command = ""
    pp = "src/cert/"+sys.argv[2]+".mobileprovision"
    command = "sh"+" "+shellPath+" "+ipaPath+" \"" + \
        cert_name+"\" -p"+" " + sys.argv[1]+"="+pp
    for idx in range(len(sys.argv)):
        if(idx > 3):
            print(sys.argv[idx])
            ppx = "src/cert/"+sys.argv[2]+"."+sys.argv[idx]+".mobileprovision"
            command += ""+" -p " + sys.argv[1]+"."+sys.argv[idx]+"="+ppx+" "
    command += " "+outPath
    print(command)
    os.system(command)
    # # 描述文件路径
    # pp = "src/cert/"+sys.argv[1]+".mobileprovision"
    # # pp1 = "src/cert/"+sys.argv[1]+".shared.mobileprovision"
    # # pp2 = "src/cert/"+sys.argv[1]+".siri.intents.mobileprovision"
    # # pp3 = "src/cert/"+sys.argv[1]+".widget.mobileprovision"

    # os.system("rm -rf %s " % outPath)
    # # command = "sh %s %s \"%s\" -p im.hiha.imc=%s -p im.hiha.imc.shared=%s -p im.hiha.imc.siri.intents=%s -p im.hiha.imc.widget=%s %s" % (
    # #     shellPath, ipaPath, cert_name, pp, pp1, pp2, pp3, outPath)
    # command = "sh %s %s \"%s\" -p io.suchain.suc=%s %s" % (
    #     shellPath, ipaPath, cert_name, pp, outPath)
    # os.system(command)


    # if(length == 4):# 没有插件
    #     pp = "src/cert/"+sys.argv[2]+".mobileprovision"
    #     command = "sh %s %s \"%s\" -p %s=%s %s" % (shellPath, ipaPath, cert_name,sys.argv[1], pp, outPath)
    # elif(length == 5):#1
    #     pp = "src/cert/"+sys.argv[2]+".mobileprovision"
    #     pp1 = "src/cert/"+sys.argv[2]+"."+sys.argv[4]+".mobileprovision"
    #     command = "sh %s %s \"%s\" -p %s=%s -p %s.%s=%s %s" % (shellPath, ipaPath, cert_name,
    #         sys.argv[1],pp,
    #         sys.argv[1],sys.argv[4],pp1,
    #         outPath)
    # elif(length == 6):#2
    #     pp = "src/cert/"+sys.argv[2]+".mobileprovision"
    #     pp1 = "src/cert/"+sys.argv[2]+"."+sys.argv[4]+".mobileprovision"
    #     pp2 = "src/cert/"+sys.argv[2]+"."+sys.argv[5]+".mobileprovision"
    #     command = "sh %s %s \"%s\" -p %s=%s -p %s.%s=%s -p %s.%s=%s %s" % (shellPath, ipaPath, cert_name,
    #         sys.argv[1],pp,
    #         sys.argv[1],sys.argv[4],pp1,
    #         sys.argv[1],sys.argv[5],pp2,
    #         outPath)
    # elif(length == 7):#3
    #     pp = "src/cert/"+sys.argv[2]+".mobileprovision"
    #     pp1 = "src/cert/"+sys.argv[2]+"."+sys.argv[4]+".mobileprovision"
    #     pp2 = "src/cert/"+sys.argv[2]+"."+sys.argv[5]+".mobileprovision"
    #     pp3 = "src/cert/"+sys.argv[2]+"."+sys.argv[6]+".mobileprovision"
    #     command = "sh %s %s \"%s\" -p %s=%s -p %s.%s=%s -p %s.%s=%s -p %s.%s=%s %s" % (shellPath, ipaPath, cert_name,
    #         sys.argv[1],pp,
    #         sys.argv[1],sys.argv[4],pp1,
    #         sys.argv[1],sys.argv[5],pp2,
    #         sys.argv[1],sys.argv[6],pp3,
    #         outPath)

    # print("------------command----------")
    # os.system("rm -rf %s " % outPath)
    # print(command)

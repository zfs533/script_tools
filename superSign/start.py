# use python3
import os
import sys
import shutil
import plistlib
from io import StringIO
from addict import Dict
import re

appexCount = 0
bundleIds = []
extentionsId = []

ipaName = "kx_232"
rootIpa = "./src/ipa"

payPath = "./temp/Payload"
isExists = os.path.exists(payPath)
if isExists:
    shutil.rmtree(payPath)

temp = "./temp"
if os.path.exists(temp):
    shutil.rmtree(temp)

os.mkdir(temp)
command = "unzip -q "+rootIpa + "/" + ipaName+".ipa"+" -d "+"temp"
os.system(command)


def load_plistlib(plist_path):
    plist = open(plist_path, "rb").read()
    plist_data = plistlib.loads(plist)
    return plist_data


def handleAppex(pPath):
    key = "CFBundleIdentifier"
    for root, dirs, files in os.walk(pPath):
        for k in files:
            file = os.path.join(root, k)
            idx = file.find("Info.plist")
            if(idx > -1):
                plist_data = load_plistlib(file)
                if key in plist_data:
                    bundleId = plist_data[key]
                    bundleIds.append(bundleId)


def handleMainInfoPlist():  # Bundle identifier
    key = "CFBundleIdentifier"
    print(payPath)
    for root, dirs, files in os.walk(payPath):
        pex = ".app"
        index = root.find(pex)
        length = len(root)
        if(index > -1 and (length == (index+len(pex)))):  # find son app count
            pth = root+"/Info.plist"
            plist_data = load_plistlib(pth)
            mBid = plist_data[key]
            mainBunledId = mBid
            return mainBunledId


for root, dirs, files in os.walk(payPath):
    pex = ".appex"
    index = root.find(pex)
    length = len(root)
    if(index > -1 and (length == (index+len(pex)))):  # find son app count
        handleAppex(root)
        appexCount = appexCount + 1

print("------------------------bundleid------------------------")
for bid in bundleIds:
    mainBunledId = handleMainInfoPlist()
    idx = bid.find(mainBunledId)
    if(idx > -1):
        extentions = bid[len(mainBunledId)+1:len(bid)]
        extentionsId.append(extentions)
        print(bid, extentions)


mainBunledId = handleMainInfoPlist()
print(mainBunledId)


user = "ylk405@163.com"
pwd = "Tibao11."
# bundleid = "com.xy.xingyunyulecomsjd12"
# bundleid = "com.gs.guangsuyulecomsjd4"
# bundleid = "com.nz.niuzaiyulecomsjd4"
# bundleid = "com.mf.mofangyulecomsjd2"
# bundleid = "com.mdi.modiyulecomsjd2"
# bundleid = "com.mdeng.modengyulecomsjd3"
# bundleid = "com.guangsu.officalgsylg"
# bundleid = "com.mhe.moheyule1"
bundleid = "com.mh.sd456bm001"
path = "./src/cert"
length = len(bundleIds)
print(bundleIds)
print("bundleIds.length= ", length)
print("ipaName: "+ipaName)


commands = "ruby src/createCert.rb "+user+" "+pwd + \
    " "+bundleid+" "+path+" "+mainBunledId+" "+ipaName
for idx in range(len(extentionsId)):
    commands += " "+extentionsId[idx]+" "

os.system(commands)
os.system("rm -rf ./temp")

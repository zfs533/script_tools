# -*- coding: utf-8 -*
import os
import sys
import shutil
import random


def copy_file():
    """
        删除旧资源src,res
        将creator新build出来的res,src拷贝过来
    """
    print("-----start-----")
    print("-----delete old file-----")

    src = "./jsb-default/src"
    res = "./jsb-default/res"
    if os.path.exists(src):
        shutil.rmtree(src)
    if os.path.exists(res):
        shutil.rmtree(res)

    print("-----copy new file-----")
    shutil.copytree(
        '/Volumes/work/qipai/two/two_client_nz/build/jsb-default/res', './jsb-default/res')
    shutil.copytree(
        '/Volumes/work/qipai/two/two_client_nz/build/jsb-default/src', './jsb-default/src')
    print("---copy finished---")


def change_work_path():
    """
        重新设置工作目录
    """
    os.chdir("./jsb-default/frameworks/runtime-src/proj.android-studio/")
    print(os.getcwd())


def setDev(offical):
    """
        切换正式服和测试服bundleId
    """
    target = "./app/build.gradle"
    origin = "./app/build.txt"
    f = open(origin)
    ft = open(target, "w+")
    line = f.readline()
    while line:
        idx = line.find("applicationId")
        if(idx > 0 and offical):
            line = "\t\tapplicationId 'com.nzyl.androidofficialnz'\n"
            print(line)
        ft.write(line)
        line = f.readline()
    f.close()
    ft.close()


def change_icon_info():
    info = "asfhlasjdflkasjdflkueweoruasldf56a4897rew987498234234wetrasodfjasopidfujaoisdfpuoapsdufopasdujfoiasjpdfoiaeur[woeu1273983479520374"
    st = info[0:random.randint(0, len(info))]
    cmd = "echo %s >> ./app/res/ic_launcher.png" % (st)
    os.system(cmd)

    st = info[0:random.randint(0, len(info))]
    cmd = "echo %s >> ./app/res/mipmap-hdpi/ic_launcher.png" % (st)
    os.system(cmd)

    st = info[0:random.randint(0, len(info))]
    cmd = "echo %s >> ./app/res/mipmap-ldpi/ic_launcher.png" % (st)
    os.system(cmd)

    st = info[0:random.randint(0, len(info))]
    cmd = "echo %s >> ./app/res/mipmap-mdpi/ic_launcher.png" % (st)
    os.system(cmd)

    st = info[0:random.randint(0, len(info))]
    cmd = "echo %s >> ./app/res/mipmap-xhdpi/ic_launcher.png" % (st)
    os.system(cmd)

    st = info[0:random.randint(0, len(info))]
    cmd = "echo %s >> ./app/res/mipmap-xxhdpi/ic_launcher.png" % (st)
    os.system(cmd)

    st = info[0:random.randint(0, len(info))]
    cmd = "echo %s >> ./app/res/mipmap-xxxhdpi/ic_launcher.png" % (st)
    os.system(cmd)

    pass


def start_build_apk():
    """
        开始执行构建打包命令
    """
    build = "./app/build/"
    if os.path.exists(build):
        shutil.rmtree(build)

    commond = "./gradlew assembleRelease"
    os.system(commond)
    print("--------build finish----------")
    commond = "open ./app/build/outputs/apk/release/"
    os.system(commond)


def install_apk():
    """
        安装到手机
    """
    cmd = "adb install %s" % (
        "./app/build/outputs/apk/release/GAME-release.apk")
    os.system(cmd)


if __name__ == '__main__':
    """文件拷贝"""
    copy_file()
    """修改工作目录"""
    change_work_path()
    """切换正式服和测试服bundleId"""
    offical = len(sys.argv) > 1
    setDev(offical)
    """修改icon"""
    change_icon_info()
    """构建打包"""
    start_build_apk()
    """安装"""
    install_apk()

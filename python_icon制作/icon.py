# -*- coding: utf-8 -*
"""
    icon制作工具
"""
import os
import sys
from PIL import Image

sizelist = [40, 60, 72, 76, 76, 80, 50, 29,
            57, 20, 1024, 512, 256, 128, 64, 32]


def startCreate(path):
    """
        icon原始路径
    """
    for i in range(len(sizelist)):
        item = sizelist[i]
        img_switch = Image.open(imgPath)  # 读取图片
        img_deal = img_switch.resize((item, item), Image.ANTIALIAS)  # 转化图片

        img_deal = img_deal.convert('RGBA')
        img_deal.save("./icon/icon_"+str(item)+".png")


if __name__ == '__main__':
    """
        sys.argv[1]:原始icon完整路径,Icon要加上后缀.png 
    """
    imgPath = sys.argv[1]
    dir = "./icon"
    if os.path.exists(dir):
        pass
    else:
        os.mkdir(dir)
    startCreate(imgPath)


"""
exp:
    python icon.py "./icon.png"
"""

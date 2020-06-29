import random
import string
import os,sys
import shutil
# install shutil first
from psutil import net_if_addrs

def getMacPassword():
    for k, v in net_if_addrs().items():
        for item in v:
            address = item.address
            if address == "192.168.1.119" :
                return "541987"
            elif address == "223.25.237.104":
                return "bqdbinw4y4g"
            elif address == "103.228.153.191":
                return "w7c34ztz777"



psd = getMacPassword()
print(psd)




































import xlwt
import xlrd
from datetime import date,datetime

file = "test.xlsx"

def read_excel():
    wb = xlrd.open_workbook(file)
    sheet1 = wb.sheet_by_index(0)#get table
    print(sheet1)
    print(sheet1.name)



read_excel()


#!/usr/bin/python
# coding=utf-8
import csv

# 读取
data = csv.reader(open('info.csv', 'rU'))
for user in data:
	print(user)

#for user in data:
#	print(user[1])
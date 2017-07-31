#!/usr/bin/python
# -*- coding: UTF-8 -*-

import MySQLdb

conn = MySQLdb.connect(host='127.0.0.1', port=3306, user='root', passwd='', db='newbase2333', charset='utf8')
cursor = conn.cursor()
cursor.execute('SELECT COUNT(*) as ct FROM wifi_adcount')
rs = cursor.fetchone()
count = rs[0]

fp = open('/home/ikke/adtransfer.sql', 'w+')

for i in range(0, count, 5000):
    fetch = "SELECT shopid,adid,showup,add_time,mac FROM wifi_adcount LIMIT %s, 5000" % i
    cursor.execute(fetch)
    data = cursor.fetchall()
    insert = "INSERT INTO wifi_areaadcount (oid,adid,showup,add_time,mac,type,level) VALUES "
    for row in data:
        insert += "('%s','%s','%s','%s','%s','1','1')," % (row[0], row[1], row[2], row[3], row[4])
    fp.write(insert[:-1] + ";\n")

fp.close()
cursor.close()
conn.close()

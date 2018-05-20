#!/usr/bin/python3
# -*- coding: UTF-8 -*-

import json
import os
import requests
import psycopg2

try:
    conn = psycopg2.connect(host="192.168.242.128", dbname="cnarea", user="postgres", password="123456")
    cursor = conn.cursor()
except psycopg2.OperationalError:
    print("Failed to connect to PostgreSQL!")

p_url = "https://raw.githubusercontent.com/modood/Administrative-divisions-of-China/master/dist/provinces.json"
c_url = "https://raw.githubusercontent.com/modood/Administrative-divisions-of-China/master/dist/cities.json"
a_url = "https://raw.githubusercontent.com/modood/Administrative-divisions-of-China/master/dist/areas.json"
s_url = "https://raw.githubusercontent.com/modood/Administrative-divisions-of-China/master/dist/streets.json"
v_url = "https://raw.githubusercontent.com/modood/Administrative-divisions-of-China/master/dist/villages.json"

p_file = "provinces.json"
c_file = "cities.json"
a_file = "areas.json"
s_file = "streets.json"
v_file = "villages.json"

# 调试信息
CONFIG_DEBUG = False
CONFIG_VERBOSE = True

# HTTP代理设置
CONFIG_HTTP_PROXY = True
if CONFIG_HTTP_PROXY:
    proxy = {
        'http': 'http://127.0.0.1:8118',
        'https': 'http://127.0.0.1:8118'
    }
else:
    proxy = {}

def fetch_datas():
    if os.path.exists(p_file) == False:
        if CONFIG_VERBOSE:
            print("省份数据不存在,正在同步...")
        with open(p_file, "w+", encoding="utf-8", newline="\n") as fp:
            fp.write(requests.get(p_url, proxies=proxy).text)
    
    if os.path.exists(c_file) == False:
        if CONFIG_VERBOSE:
            print("地市数据不存在,正在同步...")
        with open(c_file, "w+", encoding="utf-8", newline="\n") as fp:
            fp.write(requests.get(c_url, proxies=proxy).text)

    if os.path.exists(a_file) == False:
        if CONFIG_VERBOSE:
            print("区县数据不存在,正在同步...")
        with open(a_file, "w+", encoding="utf-8", newline="\n") as fp:
            fp.write(requests.get(a_url, proxies=proxy).text)

    if os.path.exists(s_file) == False:
        if CONFIG_VERBOSE:
            print("乡镇街道数据不存在,正在同步...")
        with open(s_file, "w+", encoding="utf-8", newline="\n") as fp:
            fp.write(requests.get(s_url, proxies=proxy).text)

    if os.path.exists(v_file) == False:
        if CONFIG_VERBOSE:
            print("居村委会数据不存在,正在同步...")
        with open(v_file, "w+", encoding="utf-8", newline="\n") as fp:
            fp.write(requests.get(v_url, proxies=proxy).text)

    with open(p_file, "r", encoding="utf-8") as fp:
        data = json.loads(fp.read())
        for province in data:
            if CONFIG_VERBOSE:
                print("正在解析省份数据:", province['code'])
            # 业务需求仅处理陕西省数据
            if province['code'] == "61":
                insert_pgsql('0', province)
                fetch_city(province['code'])
                if CONFIG_DEBUG:
                    break

def fetch_city(p_code):
    if CONFIG_VERBOSE:
        print("正在解析地市数据:", p_code)
    with open(c_file, "r", encoding="utf-8") as fp:
        data = json.loads(fp.read())
        for city in data:
            if city['provinceCode'] == p_code:
                insert_pgsql('1', city)
                fetch_area(city['code'])
                if CONFIG_DEBUG:
                    break

def fetch_area(c_code):
    if CONFIG_VERBOSE:
        print("正在解析区县数据:", c_code)
    with open(a_file, "r", encoding="utf-8") as fp:
        data = json.loads(fp.read())
        for area in data:
            if area['cityCode'] == c_code:
                insert_pgsql('2', area)
                fetch_street(area['code'])
                if CONFIG_DEBUG:
                    break

def fetch_street(a_code):
    if CONFIG_VERBOSE:
        print("正在解析乡镇街道数据:", a_code)
    with open(s_file, "r", encoding="utf-8") as fp:
        data = json.loads(fp.read())
        for street in data:
            if street['areaCode'] == a_code:
                insert_pgsql('3', street)
                fetch_village(street['code'])
                if CONFIG_DEBUG:
                    break

def fetch_village(s_code):
    if CONFIG_VERBOSE:
        print("正在解析居村委会数据:", s_code)
    with open(v_file, "r", encoding="utf-8") as fp:
        data = json.loads(fp.read())
        for village in data:
            if village['streetCode'] == s_code:
                insert_pgsql('4', village)
                if CONFIG_DEBUG:
                    break

def insert_pgsql(lv, data):
    if lv == '1':
        data['area_code'] = string_format(data['code'], 6)
        data['father'] = string_format(data['provinceCode'], 6)
    elif lv == '2':
        data['area_code'] = string_format(data['code'], 6)
        data['father'] = string_format(data['cityCode'], 6)
    elif lv == '3':
        data['area_code'] = string_format(data['code'], 9)
        data['father'] = string_format(data['areaCode'], 6)
    elif lv == '4':
        data['area_code'] = string_format(data['code'], 12)
        data['father'] = string_format(data['streetCode'], 9)
    else:
        data['area_code'] = string_format(data['code'], 6)
        data['father'] = 0

    sql = "INSERT INTO cnarea (area_code, level, father, name, short_name) VALUES ('%s', '%s', '%s', '%s', '%s')" \
        % (data['area_code'], lv, data['father'], data['name'], data['name'])
    cursor.execute(sql)
    conn.commit()
    if CONFIG_VERBOSE:
        print(sql)

def string_format(str, length):
    return (str + '0000000000')[0:length]

if __name__ == "__main__":
    fetch_datas()
    conn.close()

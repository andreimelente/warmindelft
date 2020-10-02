import re
from contextlib import contextmanager
from selenium import webdriver
import sys


print(sys.version)

URL = 'http://www.weerindelft.nl/'

chrome = webdriver.Chrome('chromedriver')
degrees_ascii = chr(176)
try:
    chrome.get(URL)
    iframe = chrome.find_element_by_id('ifrm_3')
        
    chrome.switch_to.frame(iframe)
    elm = chrome.find_element_by_id(id_='ajaxtemp')
    temp = elm.text
    chrome.switch_to.default_content() 

    match = re.search(r'(.*)\s*{}C'.format(degrees_ascii), temp)
    if not match:
        raise ValueError("No temperature to be parsed")
    real_temp = round(float(match.group(1))) 
    print('{} degrees Celsius'.format(real_temp))
finally:
    chrome.close()

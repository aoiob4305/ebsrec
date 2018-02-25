#!/usr/bin/python

import os
import sys
import glob
import time

mainTitle = []
lists = []
baseUrl = "http://kimyoungwook.com:8881/mms"
howMany = 10

if len(sys.argv) != 2:
	print(sys.argv[0] + " Path")
else:
	mainTitle = os.path.basename(sys.argv[1])
	files = glob.glob(sys.argv[1] + '/*.m4a')
	files.sort()
	files.reverse()

	for f in files:
		lists.append((os.path.basename(f),
		time.asctime(time.gmtime(os.path.getmtime(f))),
		baseUrl+"/"+mainTitle+"/"+os.path.basename(f),
		os.path.getsize(f)))

	header = '''<?xml version="1.0" encoding="UTF-8" ?>
<rss xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" version="2.0">
<channel>
<title>%s</title>
<link>%s</link>
<itunes:subtitle>test</itunes:subtitle>
<language>ko-kr</language>
<ttl>1</ttl>
''' % (mainTitle, baseUrl)

	print(header)
	for i in lists[0:howMany]:
		item = '''<item>
<title>%s</title>
<pubDate>%s</pubDate>
<enclosure url="%s" length="%d" type="audio/mpeg" />
<guid>%s</guid>
<itunes:explicit>no</itunes:explicit>
</item> ''' % (i[0], i[1], i[2], i[3], i[2]) 
		print(item)

	footer = '''</channel>
</rss>
'''
	print(footer)

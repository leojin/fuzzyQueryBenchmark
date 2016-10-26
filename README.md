This is a benchmark for fuzzy query.Every test will find the specific words within 10,000 lines.It will run serveral times to get the average result.

#Intro
If you want to run the test in your environment.
Two scripts in utils may help you.
With `init.sh`, you can init your python lib、mysql db(mysql db will be initialized at `data/mysql`)
With `start.sh`, you can run the test.
```shell
./utils/start.sh -h

This tool will make a benchmark about 'fuzzy query' in different way.
Every test will find the matched strings within 10,000 lines(data/list, this resource was created randomly, you can replace it)

usage ./utils/start.sh [options] [args] <TEST PROJECT1> <TEST PROJECT2> ...

<TEST PROJECT> php、nodejs、python、webbrowser、mysql

-w ARG     query word, default: abc
-t ARG     times in every test, default: 10
-d ARG     [on/off] need detail info in every test, default: off
```

#My Test
The following output was created in my env(queryWord：i5y      times: 15).

* php 5.4.33
* node 4.3.2
* python 2.7.3
* mysql 5.5.50
* chrome 53.0.2785.143 m (64-bit)

```shell
【   NodeJs   】
BenchMark For NodeJs IndexOf (15 times)
	time(s)	found
AVE:	0.0091	13360

BenchMark For NodeJs Regex All (15 times)
	time(s)	found
AVE:	0.0124	13360

BenchMark For NodeJs Regex Compile All (15 times)
	time(s)	found
AVE:	0.0125	13360

BenchMark For NodeJs Regex Head (15 times)
	time(s)	found
AVE:	0.0053	5111

BenchMark For NodeJs Regex Compile Head (15 times)
	time(s)	found
AVE:	0.0054	5111

【   PHP   】
BenchMark For PHP SubStr (15 times)
	time(s)	found
AVE:	0.11354	13360

BenchMark For PHP Regex All (15 times)
	time(s)	found
AVE:	0.15287	13360

BenchMark For PHP Regex Head (15 times)
	time(s)	found
AVE:	0.13241	5111

【   Python   】
BenchMark For Python Find (15 times)
	time(s)	found
AVE:	0.03405	13360.0

BenchMark For Python Regex All (15 times)
	time(s)	found
AVE:	0.1648	13360.0

BenchMark For Python Regex Compile All (15 times)
	time(s)	found
AVE:	0.03849	13360.0

BenchMark For Python Regex Head (15 times)
	time(s)	found
AVE:	0.2123	5111.0

BenchMark For Python Regex Compile Head (15 times)
	time(s)	found
AVE:	0.08374	5111.0

【   Mysql   】
BenchMark For MYSQL %str% NO INDEX (15 times)
	found	time(s)
AVE:	13360	0.0759286

BenchMark For MYSQL str% NO INDEX (15 times)
	found	time(s)
AVE:	5111	0.0461964

BenchMark For MYSQL %str% WITH INDEX (15 times)
	found	time(s)
AVE:	13360	0.0727865

BenchMark For MYSQL str% WITH INDEX (15 times)
	found	time(s)
AVE:	5111	0.00360425

【   WebBrowser   】
BenchMark For WebBrowser IndexOf (15 times)
  time(s) found
AVE:  0.0129  13360

BenchMark For WebBrowser Regex All (15 times)
  time(s) found
AVE:  0.0161  13360

BenchMark For WebBrowser Regex Compile All (15 times)
  time(s) found
AVE:  0.0158  13360

BenchMark For WebBrowser Regex Head (15 times)
  time(s) found
AVE:  0.0061  5111

BenchMark For WebBrowser Regex Compile Head (15 times)
  time(s) found
AVE:  0.0061  5111
```

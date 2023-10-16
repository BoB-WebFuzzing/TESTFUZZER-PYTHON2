# TESTFUZZER-PYTHON2

```
docker exec -it ad10819673c7 bash -c "mysql < /app/init.sql"
```
```
docker exec -it -u wc -w /home/wc/fuzzer ad10819673c7 bash -i -c "source /home/wc/.virtualenvs/witcher/bin/activate&&python -m witcher --affinity 4"
```
```
sed 's/\r//g' ./activate > activate
```
```
docker exec -it -u wc -w /home/wc/fuzzer ad10819673c7 bash -i -c "source /home/wc/.virtualenvs/witcher/bin/activate&&/home/wc/.virtualenvs/witcher/bin/python3 -m witcher --affinity 4"
```

```bash
docker exec -it TestFuzzer-Python bash -i -c "mysql < /app/init.sql"

docker exec -it TestFuzzer-Python bash -i -c "source /home/wc/.virtualenvs/pywitch/bin/activate && /init.sh"
docker exec -it -u wc -w /home/wc/fuzzer TestFuzzer-Python bash -i -c "source /home/wc/.virtualenvs/witcher/bin/activate && python -m witcher --affinity 4"
```

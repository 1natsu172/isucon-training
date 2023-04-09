### bench

```bash
./bin/exec
sudo -i -u isucon
cd bench
# 本番同様にnginx(https)へアクセスを向けたい場合
./bench -all-addresses 127.0.0.11 -target 127.0.0.11:443 -tls -jia-service-url http://127.0.0.1:4999
# isucondition(3000)へ直接アクセスを向けたい場合
./bench -all-addresses 127.0.0.11 -target 127.0.0.11:3000 -jia-service-url http://127.0.0.1:4999
```


##### ansible-play中に `"ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)"` と言われたら

```bash
./bin/exec
sudo systemctl status mysql
```
> # Active: inactive (dead) みたいになってるはずなので

```bash
sudo systemctl start mysql
make -f Setup ansible-play
```
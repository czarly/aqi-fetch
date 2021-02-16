# aqi-fetch
simple bash script to fetch world air quality index data.

requires jq to be installed

```bash
apt install jq
```

run it regularily with a cronjob every 3 hours like this

```bash
0 */3 * * * cd /root/aqi-fetch && ./fetch.sh
```

and serve the files with nginx

```
apt install docker.io

cd /root/aqi-fetch

docker run --name some-nginx -p 80:80 -v ${PWD}/logs:/usr/share/nginx/html:ro -v ${PWD}/default.conf:/etc/nginx/conf.d/default.conf -d nginx
```






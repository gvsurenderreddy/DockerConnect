[![Docker Repository on Quay](https://quay.io/repository/mgarces/dockerconnect/status "Docker Repository on Quay")](https://quay.io/repository/mgarces/dockerconnect)
# DockerConnect
Any Connect VPN Client, with built in SSHd to use as a jump host

## How to use?
Create a local git branch, and edit _vpn.sh_ with your preferences. After that, just build it like usual.
```
docker build -t dockerconnect .
```
When you run the container, remember to attach the SSH port, and also to put your SSH public key
attached.
```
docker run --detach --privileged -p 2222:22 -v ~/.ssh/keys/id_rsa.pub:/root/.ssh/authorized_keys:ro --name dockerconnect dockerconnect
```

After that you can use `docker stop dockerconnect` or `docker start dockerconnect`

## SSH_config
Add to your SSH_Config file, the information for the container and the jump host:

```
Host dockerconnect
  HostName docker.local # or the IP for the container
  Port 2222
  User root

Host jump
  HostName foo
  User bar
  ProxyCommand ssh  dockerconnect nc -w 120ms %h %p
  ```

---
description: The following shell scripts (monkeys) can be used to simulate Chaos events.
---

# Monkey Code

{% hint style="danger" %}
These scripts are intended to break systems.  Care should be exercised, when excercising monkeys.
{% endhint %}

## Fail DNS

```bash
iptables -A INPUT -p tcp -m tcp --dport 53 -j DROP
iptables -A INPUT -p udp -m udp --dport 53 -j DROP
```

## Burn IO

```bash
cat << EOF > /tmp/loopburnio.sh
#!/bin/bash
while true;
do
    dd if=/dev/urandom of=/burn bs=1M count=1024 iflag=fullblock
done
EOF

nohup /bin/bash /tmp/loopburnio.sh &
```

## Burn CPU

```bash
cat << EOF > /tmp/infiniteburn.sh
#!/bin/bash
while true;
    do openssl speed;
done
EOF

# 32 parallel 100% CPU tasks should hit even the biggest EC2 instances
for i in {1..32}
do
    nohup /bin/bash /tmp/infiniteburn.sh &
done
```

## Fail Dynamo DB

```bash
# Block well-known Amazon DynamoDB API endpoints
echo "127.0.0.1 dynamodb.us-east-1.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 dynamodb.us-northeast-1.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 dynamodb.us-gov-west-1.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 dynamodb.us-west-1.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 dynamodb.us-west-2.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 dynamodb.sa-east-1.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 dynamodb.ap-southeast-1.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 dynamodb.ap-southeast-2.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 dynamodb.eu-west-1.amazonaws.com" >> /etc/hosts
```

## Fail EC2

```bash
# Block well-known Amazon EC2 API endpoints
echo "127.0.0.1 ec2.us-east-1.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 ec2.us-northeast-1.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 ec2.us-gov-west-1.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 ec2.us-west-1.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 ec2.us-west-2.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 ec2.sa-east-1.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 ec2.ap-southeast-1.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 ec2.ap-southeast-2.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 ec2.eu-west-1.amazonaws.com" >> /etc/hosts
```

## Fail S3

```bash
# See http://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region

echo "127.0.0.1 s3.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 s3-external-1.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 s3-us-west-1.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 s3-us-west-2.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 s3-eu-west-1.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 s3-ap-southeast-1.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 s3-ap-southeast-2.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 s3-ap-northeast-1.amazonaws.com" >> /etc/hosts
echo "127.0.0.1 s3-sa-east-1.amazonaws.com" >> /etc/hosts
```

## Fill Disk

```bash
# 65 GB should be enough to fill up all EC2 root disks!
nohup dd if=/dev/urandom of=/burn bs=1M count=65536 iflag=fullblock &
```

## Kill Processes

```bash
cat << EOF > /tmp/kill_loop.sh
#!/bin/bash
while true;
do
    pkill -KILL -f java
    pkill -KILL -f python
    sleep 1
done
EOF

nohup /bin/bash /tmp/kill_loop.sh &
```

## Network Corruption

```bash
# Corrupts 5% of packets
tc qdisc add dev eth0 root netem corrupt 5%
```

## Network Latency

```bash
# Adds 1000ms +- 500ms of latency to each packet
tc qdisc add dev eth0 root latency delay 1000ms 500ms
```

## Network Loss

```bash
# Drops 7% of packets, with 25% correlation with previous packet loss
# 7% is high, but it isn't high enough that TCP will fail entirely
tc qdisc add dev eth0 root netem loss 7% 25%
```

## Null Routes

```bash
ip route add blackhole 10.0.0.0/8
```


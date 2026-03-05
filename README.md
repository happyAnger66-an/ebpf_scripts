# ebpf_scripts

Some useful ebpf scripts.

## monitor topic latency

```shell
sudo bash ./topic_latency.sh latency /topic
```

```shell
Attaching 1 probe...
comm:subscriber_memb topic: /topic latency: 333us
comm:subscriber_memb topic: /topic latency: 378us
comm:subscriber_memb topic: /topic latency: 210us
comm:subscriber_memb topic: /topic latency: 274us
comm:subscriber_memb topic: /topic latency: 321us
```

## monitor sub topic hz

```shell
sudo bash ./topic_latency.sh hz /topic
```

```shell
Attaching 2 probes...

[18:12:14] Function call counts:
@counts[subscriber_memb]: 2

[18:12:15] Function call counts:
@counts[subscriber_memb]: 2

[18:12:16] Function call counts:
@counts[subscriber_memb]: 2
```
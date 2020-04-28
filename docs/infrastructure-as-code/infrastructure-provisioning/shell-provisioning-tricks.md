# Shell Provisioning Tricks

Sleeping until the boot of a cloud instances has completed.

```bash
# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done
```


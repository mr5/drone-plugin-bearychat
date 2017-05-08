## Usage

```yaml
  notify-success:
    image: decent/drone-plugin-bearychat
    url: https://hook.bearychat.com/=xxx/xxxxxxx
    channel: Deploy
    environment:
      - DRONE_JOB_STATUS=success
    when:
      status: success

  notify-falure:
    image: decent/drone-plugin-bearychat
    url: https://hook.bearychat.com/=xxx/xxxxx
    channel: Deploy
    environment:
      - DRONE_JOB_STATUS=failure
    when:
      status: failure
```
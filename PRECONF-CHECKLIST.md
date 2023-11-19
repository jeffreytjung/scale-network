## Preconference Checklist

1. Ensure network team members keys are up to date (https://github.com/socallinuxexpo/scale-network/tree/master/facts/keys) if necessary
2. Update admin key for the expo (https://github.com/socallinuxexpo/scale-network/blob/master/facts/keys/admin_id*.pub)
3. Update scale version in facts/secrets/*-openwrt-example.yaml
4. Update wifi password:
    - https://github.com/socallinuxexpo/scale-network/blob/master/facts/secrets/ar71xx-openwrt-show.yaml
    - https://github.com/socallinuxexpo/scale-network/blob/master/openwrt/files-mt7622/etc/config/wireless.0
5. Update root secrets in facts/secrets/*-openwrt-example.yaml
    Update scale-signs repo per: https://github.com/socallinuxexpo/scale-signs#yearly-tasks
    Create release: https://github.com/socallinuxexpo/scale-network/blob/master/RELEASE.md


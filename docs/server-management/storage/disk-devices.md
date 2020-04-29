# Disk Devices

## General Disk Commands

List all of the disks attached to a system.

{% tabs %}
{% tab title="macOS" %}
```bash
$ diskutil list
/dev/disk0 (internal, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *1.0 TB     disk0
   1:                        EFI EFI                     314.6 MB   disk0s1
   2:                 Apple_APFS Container disk1         1.0 TB     disk0s2

/dev/disk1 (synthesized):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      APFS Container Scheme -                      +1.0 TB     disk1
                                 Physical Store disk0s2
   1:                APFS Volume Macintosh HD - Data     848.2 GB   disk1s1
   2:                APFS Volume Preboot                 82.9 MB    disk1s2
   3:                APFS Volume Recovery                528.1 MB   disk1s3
   4:                APFS Volume VM                      1.1 GB     disk1s4
   5:                APFS Volume Macintosh HD            11.2 GB    disk1s5

/dev/disk2 (disk image):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        +5.6 TB     disk2
   1:                        EFI EFI                     209.7 MB   disk2s1
   2:                  Apple_HFS Time Machine Backups    5.6 TB     disk2s2

/dev/disk3 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *320.1 GB   disk3
   1:                        EFI EFI                     209.7 MB   disk3s1
   2:                 Apple_APFS Container disk4         319.9 GB   disk3s2

/dev/disk4 (synthesized):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      APFS Container Scheme -                      +319.9 GB   disk4
                                 Physical Store disk3s2
   1:                APFS Volume Untitled                905.2 KB   disk4s1
```
{% endtab %}

{% tab title="Second Tab" %}

{% endtab %}
{% endtabs %}

## Testing Media

### badblocks

`badblocks` is used to search for bad blocks on a device \(usually a disk partition\).

#### Run a read / write test against the disk.

{% hint style="danger" %}
The following command will destroy all data on the drive being scanned.
{% endhint %}

```bash
$ badblocks -vws /dev/disk3
Checking for bad blocks in read-write mode
From block 0 to 312571223
Testing with pattern 0xaa:   0.01% done, 0:07 elapsed. (0/0/0 errors)
```


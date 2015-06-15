File Bundles
========

Usage
-----

First, you have to declare your `bundles` and `bundle_groups` hashes:

```puppet
class { 'file_bundles':
 file_bundles       => hiera_hash('file_bundles::bundles', {}),
 bundle_groups      => hiera_hash('file_bundles::bundle_groups', {}),
}
```

Example hiera YAML file:
```
---
file_bundles::bundles:
  test_bundle1:
    file_list:
      - test1
      - test2
      - test3
    source: file_bundles
    path: /home/test_user1
    path_owner: test_user1
    path_group: test_user1
    path_permissions: 750
    file_owner: test_user1
    file_group: test_user1
    file_permissions: 640
  test_bundle2:
    file_list:
      - test1
      - test2
      - test3
    source: file_bundles
    path: /home/test_user2
    path_owner: test_user2
    path_group: test_user2
    path_permissions: 750
    file_owner: test_user2
    file_group: test_user2
    file_permissions: 640
  test_bundle3:
    file_list:
      - test1
      - test2
      - test3
    source: file_bundles
    path: /opt/test_bundle3
    path_owner: test_user1
    path_group: test_user1
    path_permissions: 750
    file_owner: test_user1
    file_group: test_user1
    file_permissions: 640
file_bundles::bundle_groups:
  test_bundles:
    - test_bundle1
    - test_bundle3

```

Then you can create file_bundles on your node with the `file_bundles::install` defined type.

```puppet
file_bundles::install { 'test_bundle2': }
```
Installs a `test_bundle2` bundle if it exists in `$::file_bundes::bundles` 

```puppet
file_bundles::install { '@test_bundles': }
```
Installs the bundles for every bundle in `test_bundles` bundle_group 

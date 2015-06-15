# See README.md for details
define file_bundles::install (
  $ensure           = present,
  $file_bundle      = $name,
) {
  if $file_bundle =~ /^@(\S+)$/ {
    if ! has_key($::file_bundles::bundle_groups, $1) {
      fail "Can't find bundle_group : ${1}"
    }
    ensure_resource(
      file_bundles::install,
      $::file_bundles::bundle_groups[$1],
      {
        ensure => $ensure,
      }
    )
  } else {
    if has_key($::file_bundles::file_bundles, $file_bundle) {

      $file_list        = $::file_bundles::file_bundles[$file_bundle]['file_list']
      $source           = $::file_bundles::file_bundles[$file_bundle]['source']
      $path             = $::file_bundles::file_bundles[$file_bundle]['path']
      $path_owner       = $::file_bundles::file_bundles[$file_bundle]['path_owner']
      $path_group       = $::file_bundles::file_bundles[$file_bundle]['path_group']
      $path_permissions = $::file_bundles::file_bundles[$file_bundle]['path_permissions']
      $file_owner       = $::file_bundles::file_bundles[$file_bundle]['file_owner']
      $file_group       = $::file_bundles::file_bundles[$file_bundle]['file_group']
      $file_permissions = $::file_bundles::file_bundles[$file_bundle]['file_permissions']

      ensure_resource(
        file,
        $path,
        {
          ensure => 'directory',
          owner  => $path_owner,
          group  => $path_group,
          mode   => "${path_permissions}",
        }
      )

      $prefix_file_list = prefix($file_list, "${path}/")
  
      ensure_resource(
        file_bundles::copy_files,
        $prefix_file_list,
        {
          ensure           => $ensure,
          file_owner       => $file_owner,
          file_group       => $file_group,
          source           => $source,
          file_permissions => $file_permissions,
          require          => File[$path],
        }
      )
    }
  }
}

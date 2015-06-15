# See README.md for details
define file_bundles::copy_files (
  $full_file_name   = $name,
  $ensure           = undef,
  $file_owner       = undef,
  $file_group       = undef,
  $source           = undef,
  $file_permissions = undef,
  $require          = undef,
) {
  $base_file_name = basename($full_file_name)
  ensure_resource(
    file,
    $full_file_name,
    {
      ensure     => $ensure,
      owner      => $file_owner,
      group      => $file_group,
      content    => file("${source}/${base_file_name}"),
      mode       => "${file_permissions}",
      require    => $require,
    }
  )
}

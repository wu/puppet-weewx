node default {
  # hardware, see templates/weewx.conf
  $station_type = 'FineOffsetUSB'
  $station_model = 'WS2080'

  # required location information, see
  #   http://www.daftlogic.com/sandbox-google-maps-find-altitude.htm
  $station_location = 'Hood River, Oregon'
  $station_latitude  = '45.686'
  $station_longitude = '-121.566'
  $station_altitude  = '700, foot'

  # optional station URL
  $station_url = 'http://www.example.com'

  # option rsync server details
  $rsync_server = 'www.threefools.org'
  $rsync_user = 'username'
  $rsync_path = '/weather'

  include weewx
}

node default {
  $station_location = 'Port Orchard, Washington'
  $station_latitude  = '47.5403732'
  $station_longitude = '-122.6362492'
  $station_altitude  = '206, foot'
  $station_url = 'http://www.geekfarm.org/weather/'
  $station_type = 'FineOffsetUSB'
  $station_model = 'WS2080'
  $rsync_server = 'geekfarm.org'
  $rsync_user = 'geekfarm'
  $rsync_path = '/home3/geekfarm/public_html/weather/'

  include weewx
}

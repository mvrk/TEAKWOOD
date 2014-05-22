# give me a station from data factory, this function returns a poi list that
# could be used to construct poi markers for OpenLayers.
def station_poi_list(stations):
    poi_list = []
    icon = None
    description=None
    for station in stations:
        if station.source == "NDBC":
            icon = "http://labs.google.com/ridefinder/images/mm_20_purple.png"
            description = "<div class='well' style='font-size: 11px; padding:5px;'><a href='http://www.ndbc.noaa.gov/station_page.php?station=%s' target='_blank'><button class='btn btn-info' style='font-size: 11px;'>NDBC - %s</button></a><br/>%.2f&deg;N %.2f&deg;E<br/>Provider: %s</div>" % (
                station.name, station.name.upper(), station.lat, station.lon, station.provider)

        elif station.source == "CO-OPS":
            if station.measurement == "CURRENT":
                icon = "http://labs.google.com/ridefinder/images/mm_20_yellow.png"
                description = "<div class='well' style='font-size: 11px; padding:5px;'><a href='http://tidesandcurrents.noaa.gov/cdata/StationInfo?id=%s' target='_blank'><button class='btn btn-info' style='font-size: 11px;'>CO-OPS - %s</button></a><br/>%.2f&deg;N %.2f&deg;E<br/>Provider: %s</div>" % (
                    station.name, station.name.upper(), station.lat, station.lon, station.provider)

            elif station.measurement == "TIDE":
                icon = "http://labs.google.com/ridefinder/images/mm_20_blue.png"
                description = "<div class='well' style='font-size: 11px; padding:5px;'><a href='http://tidesandcurrents.noaa.gov/geo.shtml?location=%s' target='_blank'><button class='btn btn-info' style='font-size: 11px;'>CO-OPS - %s</button></a><br/>%.2f&deg;N %.2f&deg;E<br/>Provider: %s</div>" % (
                    station.name, station.name.upper(), station.lat, station.lon, station.provider)

        title = "<img src='/static/datafactory/img/transmit.png' style='padding-right: 5px' alt='view a station'/>%s - %s" % (
            station.source, station.name.upper())
        poi = {'lat': station.lat, 'lon': station.lon, 'title': title, 'icon': icon, 'iconSize': '12,20',
               'iconOffset': '-10,-25', 'description': description,
               'name': station.name, 'measurement': station.measurement, 'source': station.source,
               'provider': station.provider}
        poi_list.append(poi)
    return poi_list

    # for station in stations:
    #     if station.source == "NDBC":
    #         icon = "http://labs.google.com/ridefinder/images/mm_20_purple.png"
    #         description = "<div class='well' style='font-size: 11px; padding:5px;'><a href='http://www.ndbc.noaa.gov/station_page.php?station=%s' target='_blank'><button class='btn btn-info' style='font-size: 11px;'>NDBC - %s</button></a><br/>%.2f&deg;N %.2f&deg;E<br/>Provider: %s</div>" % (
    #             station.name, station.name.upper(), station.lat, station.lon, station.provider)
    #
    #     elif station.source == "CO-OPS":
    #         if station.measurement == "CURRENT":
    #             icon = "http://labs.google.com/ridefinder/images/mm_20_yellow.png"
    #         elif station.measurement == "TIDE":
    #             icon = "http://labs.google.com/ridefinder/images/mm_20_blue.png"
    #
    #         description = "<div class='well' style='font-size: 11px; padding:5px;'><a href='http://tidesandcurrents.noaa.gov/cdata/StationInfo?id=%s' target='_blank'><button class='btn btn-info' style='font-size: 11px;'>CO-OPS - %s</button></a><br/>%.2f&deg;N %.2f&deg;E<br/>Provider: %s</div>" % (
    #             station.name, station.name.upper(), station.lat, station.lon, station.provider)
    #
    #     title = "<img src='/static/datafactory/img/transmit.png' style='padding-right: 5px' alt='view a station'/>%s - %s" % (
    #     station.source, station.name.upper())
    #     poi = {'lat': station.lat, 'lon': station.lon, 'title': title, 'icon': icon, 'iconSize': '12,20',
    #            'iconOffset': '-10,-25', 'description': description,
    #            'name': station.name, 'measurement': station.measurement, 'source': station.source,
    #            'provider': station.provider}
    #     poi_list.append(poi)

var arrowOptions = {
    distanceUnit: 'km',
    isWindDegree: true,
    stretchFactor: 1,
    popupContent: function(data) {
    return "<h3>" + data.title + "</h3>";
    },
    arrowheadLength: 0.8
    };

    var arrowData = {
    latlng: L.latLng(45.901227112860603, 12.525481283725),
    degree: 77,
    distance: 0.2,
    title: "Demo"
    };

    var arrow = new L.Arrow(arrowData, arrowOptions);
    arrow.addTo(map);

function getLocation(){
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function (position){
            $.ajax({
                type: 'GET',
                url: '/location',
                data: { lat: position.coords.latitude, lng: position.coords.longitude },
                contentType: 'application/json',
                dataType: 'json'
            }).done(function(data){
                console.log(data)
            });
        });
    }
}
var app = {
  init: function() {
    app.list = [];

    app.dummyDispute = {
      name: 'lili dispute',
      items: ['dog', 'cat', 'rocks'],
      status: 'order'
    };

    //find a dispute
    $('#findFight').submit(function(event) {
      event.preventDefault();
      console.log("find fight works");

      $.ajax({
        type: "GET",
        url: "http://0.0.0.0:3000/api/disputes/1",
        dataType: "json",

        success: function(data) {
          console.log(data);
      }

      });//ajax

    });

    //create a new dispute
    $('#makeFight').submit(function(event) {
      event.preventDefault();
      console.log("sanity check");
      $.ajax({
        type: "POST",
        url: "http://0.0.0.0:3000/api/disputes",
        data: app.dummyDispute,
        dataType: "json",
        success: function() {
          alert("it works");
        }

      });//ajax

    });

    
    //add Item to the list
    $('#addItem').click(function(event) {
      event.preventDefault();
      var item = $("input[name=item]").val();
      app.list.push(item);
      document.getElementById("createList").reset();
      $(".create ul").append("<li>"+item+"</li>");
    });

    //submit the list
    $('#createList').submit(function(event) {
      event.preventDefault();
      console.log("create list works");
    });

    $('#reOrderList').submit(function(event) {
      event.preventDefault();
      console.log("this shit works too");
    });


  }
};//app

$(document).ready(function(){

  app.init();

});
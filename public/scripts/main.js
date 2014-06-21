var app = {
  init: function() {
    app.list = [];

    //find a dispute
    $('#findFight').submit(function(event) {
      event.preventDefault();
      console.log("find fight works");
    });

    //create a new dispute
    $('#makeFight').submit(function(event) {
      event.preventDefault();
      console.log("Make fight works");
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
var app = {
  init: function() {
    app.list = [];

    //hide other views
    $( "section" ).not( "[class='home']" ).hide();


    //find a dispute
    $('#findFight').submit(function(event) {
      event.preventDefault();
      console.log("find fight works");

      app.disputeName = $("input[name='find']").val().toLowerCase();

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
      app.createDispute();
      console.log("sanity check");
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
  },//init

  find: function(result) {

  },
  
  switchView : function(status){

    var oldView = app.view;

    //switch to new view (status)
    app.view = status;
    $('.'+status).show();

    //hide currentView
    $('.'+oldView).hide();

  },

  createDispute : function() {
    var disputeName = $("input[name='make']").val().toLowerCase();
    var newDispute = {
      dispute: {
        name : disputeName,
        items : [''],
        status: "create"
      }
    }; //dispute object
    $.ajax({
      type: "POST",
      url: "http://0.0.0.0:3000/api/disputes",
      data: newDispute,
      dataType: "json",
      success: function() {
        alert("it works");
        
        app.switchView('create');
        //move onto create section

      }
    });//ajax
  }
};//app

$(document).ready(function(){

  app.init();
  app.view = 'home';


});
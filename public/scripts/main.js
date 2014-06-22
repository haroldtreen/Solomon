var app = {
  
  //initialize the app with event listeners 
  init: function() {

    //initialize program with all views hidden except HOME
    $( "section" ).not( "[class='home']" ).hide();

    //HOME
    //find a dispute
    $('#findFight').submit(function(event) {
      event.preventDefault();
      //search for a dispute
      home.find();
    });

    //HOME
    //create a new dispute
    $('#makeFight').submit(function(event) {
      event.preventDefault();
      home.createDispute();
    });

    //CREATE
    //click add item or hitting enter on submit
    //add Item to the list
    $('#addItem').click(function(event) {
      event.preventDefault();
      create.addItem();
    });

    //CREATE
    //submit the list
    $('#createList').submit(function(event) {
      event.preventDefault();
      create.finalizeList();
    });

    //ORDER
    //After reordering the list and submitting to DB
    $('#reOrderList').submit(function(event) {
      event.preventDefault();
      order.submitedReOrder();
    });//reOrderList

    //ORDER
    //enable sortable
    $( "#sortable" ).sortable();  
    $( "#sortable" ).disableSelection();

  },//app.init


  //Switch View in the application
  //@param data - JSON object of current dispute
  //Hide HTML Section and display corresponding view based on Status  
  switchView : function(data){

    //know which view to hide
    var oldView = app.view;

    console.log(data);
    if (app.view === "results"){
      //dirty fix
    }
    else if ( data.dispute.results !== null){
      app.view = "results";
    }
    else {
      //switch to new view (status)
      app.view = data.dispute.status;

      //Needed for Create Method
      app.currentId = data.dispute.id;
      app.currentName = data.dispute.name;
    }

    $('.'+app.view).show();

    //hide currentView
    $('.'+oldView).hide();

    if (app.view === "order") {
      order.orderInit(data);
    }
    else if (app.view === "results") {
      results.resultsInit(data);
    }

  },//app.switchView

};

$(document).ready(function(){

  //initialize variables
  app.view = 'home';    //start at homepage section
  app.currentId = '0';  //id 
  app.currentName = ''; //name of dispute
  app.list = [];        //list of items to be disputed

  app.init();
});









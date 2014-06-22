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
      app.find();
    });

    //HOME
    //create a new dispute
    $('#makeFight').submit(function(event) {
      event.preventDefault();
      app.createDispute();
    });

    //CREATE
    //click add item or hitting enter on submit
    //add Item to the list
    $('#addItem').click(function(event) {
      event.preventDefault();
      app.addItem();
    });

    //CREATE
    //submit the list
    $('#createList').submit(function(event) {
      event.preventDefault();
      app.finalizeList();
    });

    //ORDER
    //After reordering the list and submitting to DB
    $('#reOrderList').submit(function(event) {
      event.preventDefault();
      app.submitedReOrder();
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

    var oldView = app.view;

    if (data.dispute.results !== null){
      app.view = "results";
    }
    else {
      //switch to new view (status)
      app.view = data.dispute.status;
    }


    app.currentId = data.dispute.id;
    app.currentName = data.dispute.name;


  
    $('.'+app.view).show();

    //hide currentView
    $('.'+oldView).hide();

    if (app.view === "order") {
      app.orderInit(data);
    }
    else if (app.view === "results") {
      app.resultsInit(data);
    }

  },//app.switchView

  //HOME
  //Search by name if a dispute exists then g
  find: function() {
    var disputeName = $("input[name='find']").val().toLowerCase();
    
    //if the input field isn't empty
    if(disputeName !== ""){
      $.ajax({
        type: "GET",
        url: "http://0.0.0.0:3000/api/disputes?name="+disputeName,
        dataType: "json",
        success: function(data) {

          app.switchView(data);
        },
        error: function(){
          alert(disputeName + " not found");
        }
      });//ajax
    }
    else {
      alert("plz enter a name");
    }
  },//app.find 


  /**********************************************\
  *                   NOT DONE
  * needs to test if dispute already exists
  \**********************************************/
  //HOME
  //Creates new dispute and push to DB
  createDispute : function() {
    //take name of dispute from input field
    var disputeName = $("input[name='make']").val().toLowerCase();
    
    /*******************************
    TEST IF disputeName already exists here with AJAX call?
    ********************************/

    //create new JSON object to be input into DB
    var newDispute = {
      dispute: {
        name : disputeName,
        items : [''], //no items in array
        status: "create" //move onto next view create
      }
    }; //dispute object
    $.ajax({
      type: "POST",
      url: "http://0.0.0.0:3000/api/disputes",
      data: newDispute,
      dataType: "json",
      success: function(data) {
        alert("it works");
        app.switchView(data);
        //move onto create section

      }
    });//ajax
  },//app.createDispute


  //CREATE
  //Add item to the list
  addItem: function() {
    //get item from input field
    var item = $("input[name=item]").val();
    //push to db
    app.list.push(item);
    //clear field
    document.getElementById("createList").reset();
    //add item to DOM
    $(".create ul").append("<li>"+item+"</li>");
  },

  //CREATE
  //Pressing finalize button
  //Get items that user added to list and push to server
  finalizeList : function(){
    
    //build JSON object
    var editedDispute = {
      dispute: {
        id: app.currentId,
        name: app.currentName,
        items: app.list, 
        status: 'order',
      }
    };

    //Update the database with new list
    $.ajax({
      type: "PATCH",
      url: "http://0.0.0.0:3000/api/disputes/"+app.currentId,
      data: editedDispute,
      dataType: "json",
      success: function(data) {
        app.switchView(data);
        console.log(data);
        //move onto order section
      }
    });//ajax
  },//app.finalizeList


  //ORDER
  //Initialize the ordering page by pull in items in list
  //@param data - JSON dispute object
  orderInit : function(data){
    var items = data.dispute.items;
    for (var i = 0; i < items.length; i++) {
      $( "ul.list" ).append( "<li>"+items[i]+"</li>" );
    }
    //iterate through the list and create an array
  },//app.orderInit

  //ORDER
  submitedReOrder : function() {
    var sortedList = [];
    //loop through ul 
    $("ul.list li").each(function(i){
      sortedList.push($(this).text());
    });
    var userName = $("input[name=name]").val();
    if (userName !== "") {
      var newUser = {
        user: {
          name: userName,
          items: sortedList,
          dispute_id: app.currentId
        }
      };

      $.ajax({
        type: "POST",
        url: "http://0.0.0.0:3000/api/users",
        data: newUser,
        dataType: "json",
        success: function(data) {
          console.log(data);
          app.checkUser(data);
        },
        error: function(data) {
          
          alert("fail");
          //transfer you to another page here
          // .. . 
        }

      });//ajax
    } else {
      alert("not valid name");
    }

      //test if the name is filled out

  },//app.submitedReOrder

  //ORDER
  checkUser : function(data) {
    $.ajax({
      type: "GET",
      url: "http://0.0.0.0:3000/api/disputes/" + data.user.dispute_id + "/results",
      dataType: "json",
      success: function(data) {
        alert("2nd user!");
        data.dispute.status = "results";
        app.switchView(data);
      },
      error: function(data) {
        alert("get your ex to fill out page");
      }
    });
  },//app.check2ndUser

  //RESULTS
  resultsInit : function(data) {
    console.log(data.dispute.results);

    
  }
};

$(document).ready(function(){

  //initialize variables
  app.view = 'home';    //start at homepage section
  app.currentId = '0';  //id 
  app.currentName = ''; //name of dispute
  app.list = [];        //list of items to be disputed

  app.init();
});









var app = {
  init: function() {
    app.list = [];

    //enable sortable
    $( "#sortable" ).sortable();  
    $( "#sortable" ).disableSelection();

    //hide other views
    $( "section" ).not( "[class='home']" ).hide();


    //find a dispute
    $('#findFight').submit(function(event) {
      event.preventDefault();
      app.find();

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
      app.finalizeList();
      console.log("create list works");
    });

    $('#reOrderList').submit(function(event) {
      event.preventDefault();
      var sortedList = [];
      //loop through ul 
      $("ul.list li").each(function(i){
        sortedList.push($(this).text());
      });
      console.log(sortedList);
      console.log("this shit works too");
    });
  },//init

  find : function() {
    console.log("find fight works");
    //app.disputeName = $("input[name='find']").val().toLowerCase();
    var disputeName = $("input[name='find']").val().toLowerCase();
    //if the input field isn't empty
    if(disputeName !== ""){
      $.ajax({
        type: "GET",
        url: "http://0.0.0.0:3000/api/disputes?name="+disputeName,
        dataType: "json",
        success: function(data) {
          app.examineFindResult(data);
        },
        error: function(){
          console.log("not found");
        }
      });//ajax
    }
    else {
      alert("plz enter a name");
    }
  },

  // examineFindResult: function(result) {

  // },
  
  switchView : function(data){

    app.currentId = data.dispute.id;
    app.currentName = data.dispute.name;

    var oldView = app.view;

    //switch to new view (status)
    app.view = data.dispute.status;
  
    $('.'+app.view).show();

    //hide currentView
    $('.'+oldView).hide();
    
    if (app.view == "order") {
      app.orderInit(data);
    };
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
      success: function(data) {
        alert("it works");
        app.switchView(data);
        //move onto create section

      }
    });//ajax
  },

  finalizeList : function(){
    var editedDispute = {
      dispute: {
        id: app.currentId,
        name: app.currentName,
        items: app.list,
        status: 'order',
      }
    };

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
  },

  orderInit : function(data){
    var items = data.dispute.items;
    for (var i = 0; i < items.length; i++) {
      $( "ul.list" ).append( "<li>"+items[i]+"</li>" );
    };
  }
};//app

$(document).ready(function(){

  app.init();
  app.view = 'home';
  app.currentId = '0';
  app.currentName = '';


});
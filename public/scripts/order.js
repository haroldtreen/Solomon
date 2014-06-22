var order = {
  
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
        success: function(data,status) {
          console.log(data);
          console.log(status);
          order.checkUser(data);
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
        app.view = "dirty";
        app.switchView(data);
      },
      error: function(data) {
        window.location = " ../alert.html";
      }
    });
  },//app.check2ndUser


};
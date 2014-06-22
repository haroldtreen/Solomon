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
  //creates a new user w/ name & sorted list
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
          //need modal
        }

      });//ajax
    } else {
      alert("not valid name");
      //need modal
    }

      //test if the name is filled out

  },//app.submitedReOrder

  //ORDER
  //check if user is 1st or 2nd by handling results.
  //if successful then they its been 2nd person since results exist because algorithm ran
  //if error then first person has just submitted so send em to alert page
  checkUser : function(data) {
    console.log("checking user");
    $.ajax({
      type: "GET",
      url: "http://0.0.0.0:3000/api/disputes/" + data.user.dispute_id + "/results",
      dataType: "json",
      success: function(data) {
        
        //get a dispute object then run a switch view
        $.ajax({
          type: "GET",
          url: "http://0.0.0.0:3000/api/disputes/" + app.currentId,
          dataType: "json",
          success: function(data) {
            console.log("2nd user submitted, here is dispute w/ results " + data); 
            app.switchView(data);
          },
        });//ajaax
      },//succcessss
      //if 2nd person hasn't completed their form, send em to alert page.
      error: function(data) {
        window.location = " ../alert.html";
      }
    });
  },//app.check2ndUser


};

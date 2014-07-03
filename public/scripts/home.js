var home =  {
  

  //HOME
  //Search by name if a dispute exists then g
  find: function() {
    var disputeName = $("input[name='find']").val().toLowerCase();
    
    //if the input field isn't empty
    if(disputeName !== ""){
      //console.log("Dispute name is: " + disputeName);
      $.ajax({
        type: "GET",
        url: app.mainURL+"/api/disputes?name="+disputeName,
        dataType: "json",
        success: function(data) {

          app.switchView(data);
        },
        error: function(){
          $('.overlay1').fadeIn();
          document.getElementById('findFightInput').text("");
          //$('#findFight').reset();
        }
      });//ajax

    }

  },//app.find 


  //HOME
  //Creates new dispute and push to DB
  createDispute : function() {
    //take name of dispute from input field
    var disputeName = $("input[name='make']").val().toLowerCase();

    //create new JSON object to be input into DB
    var newDispute = {
      dispute: {
        name : disputeName,
        items : [''], //no items in array
        status: "create" //move onto next view create
      }
    }; //dispute object
    
    $.ajax({
      type: "GET",
      url: app.mainURL+"/api/disputes?name="+disputeName,
      dataType: "json",
      success: function(){
        //error someone has already fuckin made that dispute
        $('.overlay2').fadeIn();
        document.getElementById('createFightInput').text("");
        // $('#createFight').reset();
      },
      error: function(){
        $.ajax({
          type: "POST",
          url: app.mainURL+"/api/disputes",
          data: newDispute,
          dataType: "json",
          success: function(data) {
            app.switchView(data);
            //move onto create section
          }
        });//ajax
      }

    });

  },//app.createDispute

};

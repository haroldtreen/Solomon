var home =  {
  

  //HOME
  //Search by name if a dispute exists then g
  find: function() {
    var disputeName = $("input[name='find']").val().toLowerCase();
    
    //if the input field isn't empty
    if(disputeName !== ""){
      console.log("Dispute name is: " + disputeName);
      $.ajax({
        type: "GET",
        url: "http://0.0.0.0:3000/api/disputes?name="+disputeName,
        dataType: "json",
        success: function(data) {

          app.switchView(data);
        },
        error: function(){
          $('.overlay1').fadeIn();
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
      type: "GET",
      url: "http://0.0.0.0:3000/api/disputes?name="+disputeName,
      dataType: "json",
      success: function(){
        //error someone has already fuckin made that dispute
        $('.overlay2').fadeIn();
      },
      error: function(){
        $.ajax({
          type: "POST",
          url: "http://0.0.0.0:3000/api/disputes",
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

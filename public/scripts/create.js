var create = {

  //CREATE
  //Add item to the list
  addItem: function() {
    //get item from input field
    var item = $("input[name=item]").val();
    //push to db

    if(item !== ""){
      app.list.push(item);
      //clear field
      document.getElementById("createList").reset();
      //add item to DOM
      $(".create ul").append("<li>"+item+"</li>");
    }
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
        //move onto order section
      }
    });//ajax
  },//app.finalizeList

};

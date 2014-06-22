var results = {
    //RESULTS
  resultsInit : function(data) {
    console.log(data.dispute.results);
// if(data is a dispute)
//     var path = data.dispute.results;
// if (data is a user)
//     var path =  data.user.

    $('#name1').text(data.dispute.results.name_1);
    $('#name2').text(data.dispute.results.name_2);

    var left = $('.half.left');
    var right = $('.half.right');

    for(var i = 0; i < data.dispute.results.items_1.length; i++){
      left.append("<div>"+ data.dispute.results.items_1[i]+"</div>");
      right.append("<div>"+ data.dispute.results.items_2[i]+"</div>");
    }
    var contested = $('#contested');
    for(var j = 0; j < data.dispute.results.contested.length; j++){
      contested.append("<div>" + data.dispute.results.contested[j]+"</div");
    }

  }
};
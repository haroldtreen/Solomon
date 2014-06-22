var results = {
    //RESULTS
  resultsInit : function(data) {
    console.log(data.dispute.results);

    $('#name1').text(data.dispute.results.name_1);
    $('#name2').text(data.dispute.results.name_2);

    var left = $('.half.left ul');
    var right = $('.half.right ul');

    for(var i = 0; i < data.dispute.results.items_1.length; i++){
      left.append("<li>"+ data.dispute.results.items_1[i]+"</li>");
      right.append("<li>"+ data.dispute.results.items_2[i]+"</li>");
    }
    var contested = $('#contested ul');
    for(var j = 0; j < data.dispute.results.contested.length; j++){
      contested.append("<li>" + data.dispute.results.contested[j]+"</li>");
    }

  }
};

import Rails from "@rails/ujs"

var checkbox_all = document.querySelector('.checkbox_all');
var checkboxes = document.querySelectorAll(".checkbox");
var del_button = document.querySelector(".del-btn")

var checked = []
console.log(checkboxes);
checkbox_all.addEventListener('click',(event)=>{
    console.log(event.target.checked)
    
    // check whether checkboxes are selected.
    if(event.target.checked){
        // if they are selected, unchecking all the checkbox
        for(var i=0; i < checkboxes.length;i++){
            checkboxes[i].checked = true;
            checked.push(checkboxes[i].id)
        }
    } else {
        // if they are not selected, checking all the checkbox
        for(var i=0; i < checkboxes.length;i++){
            checkboxes[i].checked = false;
        }
        checked = []
    }
    console.log(checked)
})

checkboxes.forEach((checkbox)=>{

    // Add checkbox Event
    checkbox.addEventListener('click',(event)=>{
            var duplicate = 0
            for(var i=0; i < checked.length; i++){
                if(checked[i] == checkbox.id){
                    duplicate = checkbox.id;
                }
            }
            if(duplicate == 0){ // not duplicate
                if(checkbox.checked)
                    checked.push(checkbox.id);
            }else{
                if(checkbox.checked == false)
                checked = removeItemOnce(checked,checkbox.id);
                duplicate = 0;
            }
            console.log(checked)
    })
})

del_button.addEventListener('click',()=>{

    //Ajax send selected row to baanshares_controller
    Rails.ajax({
        url: window.location.href,
        type: 'post',
        dataType: "script",
        data: {"checkboxes": checked},
        success:function(data){console.log('ajax success');
        },
        error: function(data){console.log(data)},
    });



});


function removeItemOnce(arr, value) {
    var index = arr.indexOf(value);
    if (index > -1) {
      arr.splice(index, 1);
    }
    return arr;
  }
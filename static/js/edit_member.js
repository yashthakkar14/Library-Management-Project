const memberForm = document.getElementById("memberForm");
memberForm.addEventListener('submit', function(event){
    event.preventDefault();
    const memberID = document.querySelector('#member_id').value
    const dataObject = {
        'memberID' : memberID,
        'name' : document.querySelector('#name_input').value,
        'email' : document.querySelector('#email_input').value,
        'phone' : document.querySelector('#phone_input').value,
        'outstanding_balance' : document.querySelector('#outstanding_input').value
    }
    fetch(`/members/${memberID}`, {
        method: 'PUT',
        headers: {
            'Content-Type' : 'application/json'
        },
        body: JSON.stringify(dataObject)
    })
    .then(response=>{
        if(response.ok){
            return response.json();
        }
    })
    .then(data=>{
        window.location.href=`/members/${data.memberID}`;
    })
    .catch(error => {
        console.error('Error:', error);
    });
})
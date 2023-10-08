const deleteButton = document.querySelector("#delete_member");
deleteButton.addEventListener('click', function(){
    const memberID = document.querySelector('#member_id').textContent
    const name = document.querySelector('#name').textContent
    const confirmDelete = confirm(`Are you sure you want to delete the member ${name}`)
    if(confirmDelete == false){
        alert(`${name} member not deleted`);
        return;
    }  
    const dataObject = {
        'memberID' : memberID
    }
    fetch(`/members/${memberID}`,{
        method : 'DELETE',
        body : JSON.stringify(dataObject)
    })
    .then(response=>{
        if(response.ok){
            return response.json();
        }
    })
    .then(data=>{
        if(data.status == 'success'){
            alert(`Member with ID ${data.memberID} deleted`);
            window.location.href="/members"
        }
    })
})

const issueButton = document.querySelector("#issue_book")
issueButton.addEventListener('click', function(){
    const memberID = document.querySelector("#member_id").innerText
    const memberName = document.querySelector("#name").innerText
    let outstanding_balance = document.querySelector("#outstanding_info").dataset.value
    outstanding_balance = parseInt(outstanding_balance)
    window.location.href=`/books?issue=true&memberID=${memberID}&memberName=${memberName}&balance=${outstanding_balance}`
    console.log(outstanding_balance)
})
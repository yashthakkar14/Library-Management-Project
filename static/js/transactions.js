const markButtons = document.querySelector(".mark_return");
// markButtons.addEventListener('click', async function(event){
$('.mark_return').on('click', async function(event){
    const confirmReturn = confirm("Are you sure you want to return this book?")
    if(confirmReturn == false){
        alert('Book Not Returned');
        return ;
    }
    const button_row = event.target.closest('tr')
    const bookID = button_row.querySelector('.book_id').textContent
    const memberID = button_row.querySelector('.member_id').textContent
    const bookFees = button_row.querySelector('.book_price').textContent

    const dataObject = {
        'bookID' : bookID,
        'memberID' : memberID,
        'bookFees' : bookFees,
        'transactionType' : 'return'
    }

    const response = await fetch("/transactions", {
        "method" : "PUT",
        "Content-Type" : "application/json",
        "body" : JSON.stringify(dataObject)
    });
    const data = await response.json();
    const status = data.status
    if(status == 'success'){
        window.location.href = `/members/${memberID}`
    }
})
const assignBookButtons = document.querySelectorAll(".assign_book")
assignBookButtons.forEach(function(assignBook){
    assignBook.addEventListener('click', async function(event){
        const button_row = event.target.closest('tr');
        const available_quantity = button_row.querySelector('.available_quantity').textContent;
        const total_fees = button_row.querySelector('.book_fees').textContent;
        const bookID = button_row.querySelector('.book_id').textContent;
        
        const currentURL = window.location.href;
        const searchParams = new URLSearchParams(currentURL);
        const memberName = searchParams.get('memberName');
        const memberID = searchParams.get('memberID');
        const balance = searchParams.get('balance')

        if((parseInt(total_fees)+parseInt(balance)) > 500){
            alert('Cannot allow to rent this book, as outstanding amount cannot be greater than 500');
            return;
        }
        else if(parseInt(available_quantity)==0){
            alert('Book Not available')
            return;
        }
        else{
            const confirmAssign = confirm(`Are you sure you want to assign the book to the member ${memberName}`)
            if(confirmAssign == false){
                alert("Book Not Assigned");
                return ;
            }
        }

        const dataObject = {
            'bookID' : bookID,
            'memberID' : memberID,
            'transactionType' : 'assign',
            'bookFees' : total_fees
        }

        const response = await fetch("/transactions", {
            "method" : "POST",
            "Content-Type" : "application/json",
            "body" : JSON.stringify(dataObject)
        })

        const data = await response.json()
        const status = data.status
        if(status == 'success'){
            window.location.href = `/transactions?memberId=${memberID}`
        }
        else if(status == 'fail'){
            const message = data.message
            alert(message);
        }
    })
})
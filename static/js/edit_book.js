const bookForm = document.getElementById("bookForm");
bookForm.addEventListener('submit', function(event){
    event.preventDefault();
    const bookID = document.querySelector('#book_id').value
    const dataObject = {
        'bookID' : bookID,
        'title' : document.querySelector('#title_input').value,
        'ISBN' : document.querySelector('#isbn_input').value,
        'available' : document.querySelector('#available_input').value,
        'total' : document.querySelector('#total_input').value
    }
    fetch(`/books/${bookID}`, {
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
        window.location.href=`/books/${data.bookID}`;
    })
    .catch(error => {
        console.error('Error:', error);
    });
})
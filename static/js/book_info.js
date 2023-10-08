const deleteButton = document.querySelector("#delete_book")
deleteButton.addEventListener('click', function(){
    const bookID = document.querySelector('#book_id').textContent
    const titleInput = document.querySelector('#title_input').textContent
    const confirmDelete = confirm(`Are you sure you want to delete the book ${titleInput}`)
    if(confirmDelete == false){
        alert(`${titleInput} book not deleted`);
        return;
    }  
    const dataObject = {
        'bookID' : bookID
    }
    fetch(`/books/${bookID}`,{
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
            alert(`Book with ID ${data.bookID} deleted`);
            window.location.href="/books"
        }
    })
})
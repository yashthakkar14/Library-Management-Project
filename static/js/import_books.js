const importButton = document.querySelector("#importBooks")
console.log(importButton)
importButton.addEventListener('click', async function(event){
    event.preventDefault();
    const number_of_books = document.querySelector("#number_books").value;
    const title = document.querySelector("#title").value;
    const total_pages = number_of_books/20
    console.log(number_of_books)
    console.log(title)
    console.log(total_pages)
    for(let page=1; page<=total_pages; page++){
        let data = await fetch(`https://frappe.io/api/method/frappe-library?page=${page}&title=${title}`,{
            method : 'GET',
            mode : 'no-cors',
            headers:{
                'Content-type' : 'application/json',
                'accept' : 'json'
            }
        });
        console.log(data);
        const json_data = await data.json();
        console.log(json_data)
    }
})
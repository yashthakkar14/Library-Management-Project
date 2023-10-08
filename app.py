from flask import Flask, render_template, request, redirect, session, url_for, jsonify
from flask_cors import CORS
from flask_mysqldb import MySQL
import MySQLdb.cursors
from datetime import datetime
from pprint import pprint
from json import dumps , loads
import requests
from math import ceil
from datetime import datetime

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'yash'
app.config['MYSQL_PASSWORD'] = 'Yash1234'
app.config['MYSQL_DB'] = 'library_management'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
# cors = CORS(app, resources={r"/api/*": {"origins": "http://localhost:5000"}})

mysql = MySQL(app)

@app.route("/")
def index():
    return render_template('home.html')

#* Routes for Books
# Get Books and Post new book
@app.route("/books", methods=["GET", "POST"])
def get_books():
    cursor = mysql.connection.cursor()
    if request.method == "GET":
        search_title = request.args.get('search_title')
        search_author = request.args.get('search_author')
        book_issue = request.args.get('issue')
        member_id = request.args.get('memberID')
        member_name = request.args.get('memberName')
        

        book_issue_dict = None
        search_dict = {}
        if(book_issue == 'true'):
            book_issue_dict = {'member_id':member_id, 'book_issue':True, 'member_name':member_name}

        search_query = "SELECT * FROM books WHERE 1"
        query_params = []
        if search_title:
            search_dict['search_title'] = search_title
            search_query += " AND title=%s"
            query_params.append(search_title)
        if search_author:
            search_dict['search_author'] = search_author
            search_query+=" AND authors=%s"
            query_params.append(search_author)
        print(search_query)
        cursor.execute(search_query, query_params)
        books_details = cursor.fetchall()
        cursor.close()
        pprint(books_details)
        return render_template('/books/books.html', books_details = books_details, book_issue=book_issue_dict, search_dict=search_dict)
    elif request.method == "POST":
        books_details = request.form
        print(books_details)
        book_id = books_details.get('book_id')
        book_title = books_details.get('title_input')
        authors = books_details.get('authors')
        average_rating = books_details.get('average_rating')
        ratings_count = books_details.get('ratings_count')
        isbn_input = books_details.get('isbn_input')
        isbn13_input = books_details.get('isbn13_input')
        lang_code = books_details.get('lang_code')
        text_reviews_count = books_details.get('text_reviews_count')
        publication_date = books_details.get('publication_date')
        print(publication_date)
        publication_date = datetime.strptime(publication_date, '%Y-%m-%d').date()
        publisher = books_details.get('publisher')
        num_pages = books_details.get('num_pages')
        available_input = books_details.get('available_input')
        total_input = books_details.get('total_input')

        cursor.execute("""
        INSERT INTO books(bookID, title, authors, average_rating, isbn, isbn13, language_code, num_pages, ratings_count, text_reviews_count, publication_date, publisher, total_quantity, available_quantity) 
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) 
        ON DUPLICATE KEY UPDATE
        total_quantity = total_quantity+1,
        available_quantity = available_quantity+1
        """, (book_id, book_title, authors, average_rating, isbn_input, isbn13_input, lang_code, num_pages, ratings_count, text_reviews_count, publication_date, publisher, total_input, available_input))
        mysql.connection.commit()
        cursor.close()
        return redirect("/books")

# Edit Book Page
@app.route("/books/<int:id>/edit", methods=["GET"])
def edit_book(id):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM books WHERE bookID=%s", (id,))
    book_info = cursor.fetchone()
    return render_template("/books/edit_book.html", book_info=book_info)

# New Book Page
@app.route("/books/new", methods=["GET"])
def new_book():
    return render_template("/books/new_book.html")

@app.route("/books/import", methods=["GET", "POST"])
def import_books():
    if request.method == "GET":
        return render_template("/books/import_books.html")
    elif request.method == "POST":
        try:
            import_details = request.form
            total_books = import_details.get("number_books")
            book_title = import_details.get("title")
            request_url = 'https://frappe.io/api/method/frappe-library?'
            if book_title:
                request_url+=f"title={book_title}&"
            total_pages = ceil(int(total_books)/20)
            books_count = 0
            for page in range(1, total_pages+1):
                push_books_data = []
                print(request_url)
                response = requests.get(f'{request_url}page={str(page)}')
                data = response.json()
                books_data = data.get('message')
                for book in books_data:
                    if books_count == total_books:
                        break
                    bookID = book.get('bookID')
                    title = book.get('title')
                    authors = book.get('authors')
                    average_rating = book.get('average_rating')
                    isbn = book.get('isbn')
                    isbn13 = book.get('isbn13')
                    language_code = book.get('language_code')
                    num_pages = book.get('num_pages')
                    ratings_count = book.get('ratings_count')
                    text_reviews_count = book.get('text_reviews_count')
                    publication_date = book.get('publication_date')
                    publication_date = datetime.strptime(publication_date, '%m/%d/%Y')
                    publisher = book.get('publisher')
                    total_quantity = 1
                    available_quantity = 1
                    push_books_data.append((bookID, title, authors, average_rating, isbn, isbn13, language_code, num_pages, ratings_count, text_reviews_count, publication_date, publisher, total_quantity, available_quantity))
                    books_count+=1
                cursor = mysql.connection.cursor()
                cursor.executemany("""
                INSERT INTO books(bookID, title, authors, average_rating, isbn, isbn13, language_code, num_pages, ratings_count, text_reviews_count, publication_date, publisher, total_quantity, available_quantity) 
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                ON DUPLICATE KEY UPDATE
                total_quantity = total_quantity+1,
                available_quantity = available_quantity+1
                """, push_books_data)
                mysql.connection.commit()
                cursor.close()

            
            # response.raise_for_status()  # Raise an exception for non-2xx status codes
            # data = response.json()
            # pprint(data)
            return redirect('/books')
        except:
            return redirect('/books')


# Getting a specific book, deleting a specific book, updating a specific book to database
@app.route("/books/<int:id>", methods=["GET", "DELETE", "PUT"])
def book_info(id):
    cursor = mysql.connection.cursor()
    if request.method == "GET":
        cursor.execute("SELECT * FROM books WHERE bookID=%s", (id,))
        book_info = cursor.fetchone()
        return render_template('/books/book_info.html', book_info=book_info)
    elif request.method == "PUT":
        data = request.get_json()
        bookId = data.get('bookID')
        title = data.get('title')
        isbn = data.get('ISBN')
        available = data.get('available')
        total = data.get('total')
        if available:
            available = int(available)
        if total:
            total = int(total)
        cursor.execute("UPDATE books SET title=%s, isbn=%s, available_quantity=%s, total_quantity=%s WHERE bookID=%s", (title, isbn, available, total,bookId,))
        mysql.connection.commit()
        cursor.close()

        return_data = {'status' : 'success', 'bookID':data.get('bookID')}
        print(type(dumps(return_data)))
        return dumps(return_data)
    elif request.method == "DELETE":
        data = loads(request.get_data())
        bookId = data.get('bookID')
        if bookId:
            bookId = int(bookId)
        cursor.execute("DELETE FROM BOOKS WHERE bookID=%s", (bookId,))
        mysql.connection.commit()
        cursor.close()
        return {'status' : 'success', 'bookID':data.get('bookID')}

#* Routes for Members
@app.route("/members", methods=["GET", "POST"])
def get_members():
    cursor = mysql.connection.cursor()
    if request.method == 'GET':
        cursor.execute("SELECT * FROM members")
        member_details = cursor.fetchall()
        cursor.close()
        return render_template('/members/members.html', member_details = member_details)
    elif request.method == "POST":
        member_details = request.form
        print(member_details)
        member_id = member_details.get('member_id')
        member_name = member_details.get('name_input')
        email = member_details.get('email')
        phone = member_details.get('phone')
        cursor.execute("SELECT * FROM members WHERE memberID=%s", (member_id,))
        member_details = cursor.fetchone()
        print("Member Details", member_details)
        if member_details!=None:
            member_data = {
                'member_name' : member_name,
                'email' : email,
                'phone' : phone
            }
            return render_template("members/new_member.html", member_data=member_data, alert_message="Member ID already exists, please select a different member ID")
        

        cursor.execute("""
        INSERT INTO members(memberID, name, email, phone_number, outstanding_balance) 
        VALUES (%s, %s, %s, %s, %s) 
        """, (member_id, member_name, email, phone, 0))
        mysql.connection.commit()
        cursor.close()
        return redirect("/members")


# Getting a specific book, deleting a specific book, updating a specific book to database
@app.route("/members/<int:id>", methods=["GET", "DELETE", "PUT"])
def member_info(id):
    cursor = mysql.connection.cursor()
    if request.method == "GET":
        cursor.execute("SELECT * FROM members WHERE memberID=%s", (id,))
        member_info = cursor.fetchone()
        return render_template('/members/member_info.html', member_info=member_info)
    elif request.method == "PUT":
        data = request.get_json()
        memberID = data.get('memberID')
        name = data.get('name')
        email = data.get('email')
        phone = data.get('phone')
        outstanding_balance = data.get('outstanding_balance')
        if outstanding_balance:
            outstanding_balance = int(outstanding_balance)
        cursor.execute("UPDATE members SET name=%s, email=%s, phone_number=%s, outstanding_balance=%s WHERE memberID=%s", (name, email, phone, outstanding_balance,memberID,))
        mysql.connection.commit()
        cursor.close()

        return_data = {'status' : 'success', 'memberID':data.get('memberID')}
        print(type(dumps(return_data)))
        return dumps(return_data)
    elif request.method == "DELETE":
        data = loads(request.get_data())
        memberId = data.get('memberID')
        if memberId:
            memberId = int(memberId)
        cursor.execute("DELETE FROM members WHERE memberID=%s", (memberId,))
        mysql.connection.commit()
        cursor.close()
        return {'status' : 'success', 'memberID':data.get('memberID')}

# New Member Page
@app.route("/members/new", methods=["GET"])
def new_member():
    return render_template("members/new_member.html")

# Edit Members Page
@app.route("/members/<int:id>/edit", methods=["GET"])
def edit_members(id):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM members WHERE memberID=%s", (id,))
    member_info = cursor.fetchone()
    print(member_info)
    return render_template("/members/edit_member.html", member_info=member_info)   

@app.route("/transactions", methods=["GET", "POST", "PUT"])
def get_transactions():
    member_id = request.args.get('memberId')
    query_params = []
    search_query = '''
        SELECT b.bookID, b.title, m.memberID, m.name, t.bookAssigned, t.bookReturned, t.bookPrice 
        FROM transactions t INNER JOIN books b ON b.bookID = t.bookID
        INNER JOIN members m on m.memberID = t.memberID
        WHERE 1
        '''
    if member_id:
        search_query += " AND m.memberID=%s"
        query_params.append(int(member_id))
    print(search_query)
    cursor = mysql.connection.cursor()
    if request.method == "GET":
        cursor.execute(search_query, query_params)
        transactions_data = cursor.fetchall()
        cursor.close()
        return render_template('transactions.html', transactions_data = transactions_data)
    elif request.method == "POST":
       data = loads(request.get_data())
       book_id = data.get('bookID')
       member_id = data.get('memberID')
       book_fees = data.get('bookFees')
       transaction_type = data.get('transactionType')
       cursor.execute("INSERT INTO transactions(bookID, memberID, bookPrice, bookAssigned, bookReturned) VALUES (%s, %s, %s, %s, %s)", (book_id, member_id, book_fees, True, False))
       cursor.execute("UPDATE books SET available_quantity=available_quantity-1 WHERE bookID=%s", (book_id,))
       cursor.execute(f"UPDATE members SET outstanding_balance=outstanding_balance+{book_fees} WHERE memberID=%s",(member_id,))
       mysql.connection.commit()
       cursor.close()
       return {'status' : 'success', 'memberID':data.get('memberID')}
    elif request.method == "PUT":
        data = loads(request.get_data())
        book_id = data.get('bookID')
        member_id = data.get('memberID')
        book_fees = data.get('bookFees')
        transaction_type = data.get('transactionType')
        cursor.execute("UPDATE transactions SET bookReturned=1 WHERE memberID=%s AND bookID=%s",(member_id, book_id,))
        cursor.execute("UPDATE books SET available_quantity=available_quantity+1 WHERE bookID=%s",(book_id,))
        cursor.execute(f"UPDATE members SET outstanding_balance=outstanding_balance-{book_fees} WHERE memberID=%s",(member_id,))
        mysql.connection.commit()
        cursor.close()
        return {'status' : 'success', 'memberID':member_id, 'bookId' : book_id}


    # return render_template('transactions.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
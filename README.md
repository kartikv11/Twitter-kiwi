# Twitter-kiwi ![Heroku](https://heroku-badge.herokuapp.com/?app=heroku-badge)

(Formatted README file can be read here: https://gist.github.com/kattybilly/27bfd6a4bb6939aac9bdbba881121aec)

This README would normally document whatever steps are necessary to get the
application up and running.

* FollowSteps: https://gorails.com/setup/ubuntu/14.04 (use rvm)
* Alternative: Install RVM : go to http://rvm.io/ and (http://rvm.io/) follow procedures ; rvm list known; rvm install ruby-2.2.1
* Perform following commands after you are in project directory:

 * rake db:setup
 * rake db:migrate
 * rails s (this will run on port 3000)

* DB Usage:
 * sqlite3 for development, test which ships as default database with Rails.
 * PG for production

## Projects Structure ##
```
app/ ->
/api - contains exposed APIs
/controllers - contains controllers that are actioned after routes
/services - api interacts with services
/data_access_object - services interact with the data_access_object layer
/model - ActiveRecord Model class
/utils - Contains common utilities like regex, pagination, error codes, error content, etc
/db/seed - Contains pre-loaded data that will be dumped in db as soon as command rake db:seed is executed
```

## APIs Structure ##

Proper format of args::

```
   * payload => Data to behttps://github.com/airbnb/rubyclasses send back as message format
   * meta => Any meta-data need to be send
   * error => Error stack/code
   * response => Response code send by service
   * status_code => Status code of the response (For compatability)
```

 Response will contain only the attributes sent in args.
 For all the args, if not present empty json is sent
 except status_code, which is by default as '200 OK SUCCESS'

 ******** Response Format ***********
 ```
 json:
   {
     payload: {},
     meta: {},
     error: {}
   }
 status: '<status_code>'
 ```

## APIs Exposed ##

**POST 'users/signup'**

Request:
```
{
	"user": {
    "user_name": "kiwiP",
    "name": "Kartik Verma",
    "email_id": "kartnik@gmail.com",
    "password": "kartik",
    "password_confirmation": "kartik"
 	}
}
```

Response:
```
{
  "payload": {
    "message": "User Signup successful"
  },
  "meta": {},
  "error": {}
}

```

**POST 'users/:id/post'**

Request:
```
{
	"user": {
    "content": "this is a sample work"
 	}
}
```

Response:
```
{
  "payload": {
    "message": "Success"
  },
  "meta": {},
  "error": {}
}

```

**POST 'users/:id/follow'**

Request:
```
{
	"user": {
      "following_id": 42
 	}
}
```

Response:
```
Success case as above OR:

{
  "payload": {},
  "meta": {},
  "error": {
    "message": "Relationship already exists!"
  }
}

```

**GET 'users/:id/timeline'** (supports pagination params `per_page`, `page_no`)

Request:
```
http://localhost:3000/users/38/timeline?page_no=2&per_page=8 (DEFAULT IS per_page=20, page_no=1)
```

Response:
```
{
  "payload": {
    "posts": [
      {
        "id": 82,
        "content": "sample",
        "created_at": "Saturday, 22 October 2016, 04:01:41 AM",
        "user": {
          "id": 40,
          "name": "Consuelo Keebler V",
          "user_name": "user_2"
        }
      },
      {
        "id": 80,
        "content": "Aut temporibus molestiae enim officiis occaecati nihil cupiditate.",
        "created_at": "Saturday, 22 October 2016, 03:35:49 AM",
        "user": {
          "id": 38,
          "name": "Kartik Verma",
          "user_name": "kiwi"
        }
      }
    ]
  },
  "meta": {
    "page_count": 12
  },
  "error": {}
}
```

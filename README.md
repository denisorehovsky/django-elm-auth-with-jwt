<a href="https://github.com/apirobot/django-elm-auth-with-jwt">
    <p align="center">
      <img src="https://raw.githubusercontent.com/apirobot/django-elm-auth-with-jwt/master/other/preview.gif" alt="django-elm-auth-with-jwt">
    </p>
</a>

---

## Description

`django-elm-auth-with-jwt` is an example of how you can implement JSON Web Token (JWT) authentication using **django & django rest framework** as a backend and **elm** as a frontend.


## How to run

Clone the repository:

```zsh
➜ git clone https://github.com/apirobot/django-elm-auth-with-jwt.git
```

Create and activate virtualenv:

```zsh
➜  virtualenv -p python3 .venv
➜  source .venv/bin/activate
```

Install dependencies:

```zsh
../backend  ➜  pip install -r requirements.txt
../frontend ➜  elm-package install
```

Run migrations:

```zsh
../backend ➜  python manage.py makemigrations
../backend ➜  python manage.py migrate
```

Start up backend:

```zsh
../backend ➜  python manage.py runserver
```

Start up frontend using *elm-live*:

```zsh
../frontend ➜  elm-live --port=3000 --output=elm.js src/Main.elm --pushstate --open --debug
```

We are done.

- Frontend: http://localhost:3000/
- Backend: http://localhost:8000/

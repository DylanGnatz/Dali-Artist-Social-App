# Dali: The New Movement

## Team members

- Alexis Gadonneix (ag4625)
- Dylan Gnatz (dlg2178)
- Shehan Panditharatne (wap2124)
- Aditya Khera (ak4604)

## Instructions to run and test locally

### Dependencies

- `postgres` (tested with v14.5)
- `ruby` (tested with v2.7.6)

### Setup

```
$ cd dali
$ bundle install
$ bin/rails db:create
$ bin/rails db:migrate
```

optional:

```
$ bin/rails db:seed
```

### Run

```
$ bin/rails server
```

The application will start on http://localhost:3000/

You will have to register, you can use a fake email adress

### Test

## Cucumber

```
$ bundle exec cucumber
```

## Rspec

```
$ bin/rails spec
```

The generated code coverage report can be found in `/coverage/index.html`

## Deployment link

https://hidden-lowlands-05634.herokuapp.com/users/sign_in

## Github link

https://github.com/DylanGnatz/Dali-Artist-Social-App

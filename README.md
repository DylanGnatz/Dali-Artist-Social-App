# Dali: The New Movement

## Team members

- Alexis Gadonneix (ag4625)
- Dylan Gnatz (dlg2178)
- Shehan Panditharatne (wap2124)
- Aditya Khera (ak4604)

## Instructions to run and test locally

### Dependencies

- `postgres` (tested with v14.5)
- `ruby` (v2.7.6)
- tested under MacOS 13, with an ARM chip (M1)

### Setup

```
$ bundle install
$ bin/rails db:reset
```

If the css is not loaded, or you have some errors mentioning tailwind, you might have to run:

```
$ bundle exec rake assets:precompile
```

(`db:reset` will run `db:drop`, `db:create`, `db:schema:load`, and `db:seed`)

### Run

```
$ ./bin/dev
```

The application will start on http://localhost:3000/

You will have to register, you can use a fake email adress

You can create several users if you want to test the interactions. To be logged in with multiple users at the same time, you will have to use 2 different navigators. You can also use one regular tab and one incognito tab.

### Test

#### Cucumber

```
$ bundle exec cucumber
```

#### Rspec

```
$ bin/rails spec
```

The generated code coverage report can be found in `/coverage/index.html`

To see individual coverages for rspec and cucumber, please delete the coverage folder before:

```
$ rm -r coverage
```

## Deployment link

https://hidden-lowlands-05634.herokuapp.com/users/sign_in

On the deployed app, we recommand you to log in with these credentials:

```
Email: picasso@gmail.com
password: 123456
```

This account will showcase most features.

## Github link

https://github.com/DylanGnatz/Dali-Artist-Social-App

The git branches `proj-iter-1`, `proj-iter-2` and `proj-launch` contain the code commited before the first, second and last deadline respectively.

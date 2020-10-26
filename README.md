# Scuria

Scuria is a task management web application that considers Scrum.

# DEMO

![image](https://user-images.githubusercontent.com/34140666/96472828-e05e2900-126b-11eb-843a-27f3d4ea6f52.png)

# App URL

https://scuria.site/

# Description and Example
https://drive.google.com/file/d/174DAc-zeeoJMGNKpUOFjEzow0M71bgiB/view?usp=sharing

# Features

There is a parent-child relationship in the backlog, and it is possible to prevent double management that occurs in Scrum@Scale.
You can assign roles to members. This makes the movements of the members more faithful to their roles.

# Requirement

- ruby 2.6.5
- node 12.18.4
- mysql 5.7.31

# Usage

```bash
$ git clone https://github.com/slill33/Scuria.git
$ cd scuria
$ bundle install --path /vendor/bundle
$ bundle exec rails db:create
$ bundle exec rails db:migrate
$ rails s
```

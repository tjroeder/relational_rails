# Relational Rails Project: Turing 2110 BE Mod 2

![languages](https://img.shields.io/github/languages/top/tjroeder/relational_rails?color=red)
[![Ruby](https://github.com/tjroeder/relational_rails/actions/workflows/tests.yml/badge.svg)](https://github.com/tjroeder/relational_rails/actions/workflows/tests.yml)
![PRs](https://img.shields.io/github/issues-pr-closed/tjroeder/relational_rails)
![rspec](https://img.shields.io/gem/v/rspec?color=blue&label=rspec)
![simplecov](https://img.shields.io/gem/v/simplecov?color=blue&label=simplecov) <!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/contributors-2-orange.svg?style=flat)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

## About
- Project requirements can be found [Here](https://backend.turing.edu/module2/projects/relational_rails)
- Relational Rails is a project designed for students to explore the use of One-to-Many relationships in databases, CRUD and RESTful design principles, and to familiarize themselves with the conventions of a Rails framework by developing a navigable web app.

## Database Schema
- See image below for project database schema:

![image](https://user-images.githubusercontent.com/78194232/144355664-0c073ec2-161e-4dde-8569-1324766d7bc3.png)

## Requirements and Setup (for Unix based systems):

### Ruby and Rails
- Ruby Version 2.7.2
- Rails Version 5.2.6

### Gems
- RSpec, Pry, SimpleCov, Capybara, Launchy, Shoulda-Matchers v5.0, Orderly

### Setup
1. Clone this repository:
On your local machine open a terminal session and enter the following commands for SSH or HTTPS to clone the repositiory.


- using ssh key <br>
`$ git clone git@github.com:tjroeder/relational_rails.git`

- using https <br>
`$ git clone https://github.com/tjroeder/relational_rails.git`

Once cloned, you'll have a new local copy in the directory you ran the clone command in.

2. Change to the project directory:<br>
In terminal, use `$cd` to navigate to the Relational Rails project directory.

`$ cd relational_rails`

3. Install required Gems utilizing Bundler: <br>
In terminal, use Bundler to install any missing Gems.<br> 
If Bundler is not installed, first run the following command.

`$ gem install bundler`

If Bundler is already installed or after it has been installed, run the following command.

`$ bundle install`

There should be be verbose text diplayed of the installation process that looks similar to below. (this is not an actual copy of what will be output).

```
$ bundle install
Fetching gem metadata from https://rubygems.org/........
Resolving dependencies...
Using bundler 2.1.4
Using byebug 11.1.3
Fetching coderay 1.1.2
Installing coderay 1.1.2
Using diff-lcs 1.4.4
Using method_source 1.0.0
Using pry 0.13.1
Fetching pry-byebug 3.9.0
Installing pry-byebug 3.9.0
Fetching rspec-support 3.10.1
Installing rspec-support 3.10.1
Fetching rspec-core 3.10.1
Installing rspec-core 3.10.1
Fetching rspec-expectations 3.10.1
Installing rspec-expectations 3.10.1
Fetching rspec-mocks 3.10.1
Installing rspec-mocks 3.10.1
Fetching rspec 3.10.0
Installing rspec 3.10.0
Bundle complete! 3 Gemfile dependencies, 12 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```
If there are any errors, verify that bundler, Rails, and your ruby environment are correctly setup.

4. Database Migration
Before using the web application you will need to setup your databases locally by running the following command

`$rails db: {:drop, :create, :migrate, :seed}`

5. Startup and Access
Finally, in order to use the web app you will have to start the server locally and access the app through a web browser. 
- Start server
`$rails s`

- Open web browser and visit link
    http://localhost:3000/
    
At this point you should be taken to the welcome page of the web-app. If you encounter any errors or have not reached the web-app please confirm you followed the steps above and that your environment is properly set up.

**Authors** ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/tjroeder"><img src="https://avatars.githubusercontent.com/u/78194232?v=4" width="100px;" alt=""/><br /><sub><b>Tim (he/him)</b></sub></a><br /><a href="https://github.com/tjroeder/relational_rails/commits?author=tjroeder" title="Code">💻</a> <a href="#ideas-tjroeder" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/tjroeder/relational_rails/commits?author=tjroeder" title="Tests">⚠️</a> <a href="https://github.com/tjroeder/relational_rails/pulls?q=is%3Apr+reviewed-by%3Atjroeder" title="Reviewed Pull Requests">👀</a></td>
    <td align="center"><a href="https://github.com/jbreit88"><img src="https://avatars.githubusercontent.com/u/88853324?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Brad (he/him)</b></sub></a><br /><a href="https://github.com/tjroeder/relational_rails/commits?author=jbreit88" title="Code">💻</a> <a href="#ideas-jbreit88" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/tjroeder/relational_rails/commits?author=jbreit88" title="Tests">⚠️</a> <a href="https://github.com/tjroeder/relational_rails/pulls?q=is%3Apr+reviewed-by%3Ajbreit88" title="Reviewed Pull Requests">👀</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification.
<!--
* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
-->

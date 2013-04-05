# SocialGator


### The open source, self-hosted social content management


SocialGator is a tool for curated content for your social profiles. No more hunting across multiple sites/tools for important messages–everything you need in one, perfect inbox. Monitor your brand, industry and competition across social media and the web.


<table>
  <tr>
    <td align="center">
      <a href="http://social.deskgator.com/assets/home.png" target="_blank" title="Landing Page">
        <img src="http://social.deskgator.com/assets/home.png" alt="Landing Page" style="width: 50%!important;">
      </a>
      <br />
      <em>Landing Page</em>
    </td>
     <td align="center">
      <a href="http://social.deskgator.com/assets/business_index_page.png" target="_blank" title="Business List">
        <img src="http://social.deskgator.com/assets/business_index_page.png" alt="Business List" style="width: 50%!important;">
      </a>
      <br />
      <em>Business List</em>
    </td>
     <td align="center">
      <a href="http://social.deskgator.com/assets/business_page.png" target="_blank" title="Business Page">
        <img src="http://social.deskgator.com/assets/business_page.png" alt="Business Page" style="width: 50%!important;">
      </a>
      <br />
      <em>Business Page</em>
    </td>
     <td align="center">
      <a href="http://social.deskgator.com/assets/new_business_page.png" target="_blank" title="New Business Page">
        <img src="http://social.deskgator.com/assets/new_business_page.png" alt="New Business Page" style="width: 50%!important;">
      </a>
      <br />
      <em>New Business Page</em>
    </td>
  </tr>
</table>

## Development Setup

### Clone the repo and make a copy to start the new application
```
git clone https://github.com/fizzysoftware/SocialGator.git
```

### Install dependencies (ensure bundler is installed)
```
cd SocialGator
bundle install
```

CREATE database config (sample config is in config/database.sample.yml)
```
cp config/database_sample.yml config/database.yml
# make the appropirate changes

```

Setup DB
```
rake db:create
rake db:migrate
rake db:seed
```


Start the Server
```
rails s
```


For Background Jobs(Sending mail etc)
```
rake jobs:work
```
Demo
----

There is a demo available at [http://social.deskgator.com/](http://social.deskgator.com/)


Deploying:
----------

  * Change the `config/deploy.rb` accordingly.
  * Setup server and deploy

```bash
cap production deploy:setup
cap production deploy:cold
```

Copyright
---------

Copyright (c) 2012-2013 Fizzy Software. See LICENSE for details.
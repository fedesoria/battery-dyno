DynoBattery
===========
DynoBattery is a service provided by [dospuntocero][20] to track the consumption of dynos usage.

Install the add-on
-----------

    $ heroku addons:add dynobattery


Install the gem
-----------

    gem 'dynobattery', '~> 0.1.5'
    

Configure DynoBattery
-----------
You will need to add the middleware into environment/production.rb

    config.middleware.use "DynoBattery"

If you want to be able to automatically scale your application you will need to add a dynobattery_config.rb file to your /config/initializers folder:

    DYNO_USER = "email_used_for_heroku@test.com"
    DYNO_PASSWORD = "password"
    DYNO_DOMAIN = "name of your app"
    
For DYNO_DOMAIN it would be what you have as a subdomain in Heroku, i.e. http://DYNO-DOMAIN.heroku.com



    
[20]: http://dospuntocero.com.mx "dospuntocero"
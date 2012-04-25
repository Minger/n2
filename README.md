Welcome to the Newscloud framework
==================================

NewsCloud is a free, open-source, community engagement platform which is closely integrated with Facebook Connect. It is powered in part by technology funded by the John S. and James L. Knight Foundation.Funding for our open source development will continue through April 30, 2012.

For more details on NewsCloud, visit [our website](http://newscloud.com). Follow [@newscloud on Twitter](http://twitter.com/newscloud) for updates.

We also have a [guide to our new easy install](http://blog.newscloud.com/2011/06/easy-install-for-newscloud-.html) with a demonstration video.

Quick Start Newscloud Production Server With Chef
=================================================

We now have a full deploy with system provisioning thanks to chef and capistrano on a minimal ubuntu server with only ssh installed.

In addition to the standard requirements of a registered facebook application, you will need:

  * A minimal ubuntu server with at least 1024 megs of ram and ssh installed
  * A registered domain name point to your ubuntu server
  * A local ssh key in ~/ssh/id_rsa(.pub) (this will be used for passwordless execution of tasks on the remote server)
  * GEMS: gem install --version=2.5.10 capistrano
  * and: gem install capistrano-ext bundler
  * Review [Configuring Ruby on Rails for NewsCloud](http://support.newscloud.com/kb/installing-newscloud/how-to-configure-ruby-on-rails-for-newscloud) if you need more information.

Once these requirements have been fetch, simply run:

    git clone git://github.com/newscloud/n2.git
    cd n2
    cap newscloud:run

This will run through a setup wizard to grab your config settings, bootstrap your server with minimal requirements to run chef-solo, bootstrap the system requirements with chef, and then do a full capistrano deployment.

View the Ubuntu Server 10.04 lts install guide
==============================================

We now have a full guide for bootstrapping and install newscloud on a minimal Ubuntu Server 10.04 LTS system.

See the guide at [INSTALL-ubuntu.md](https://github.com/newscloud/n2/blob/master/INSTALL-ubuntu.md)

This guide will bootstrap a production newscloud install on Ubuntu 10.04. We have tested this configuration specifically for a 1 GB Rackspace cloud-based server, which costs about $45/mo. [Sign up with Rackspace](https://signup.rackspacecloud.com/signup?id=2352)

Getting Started
===============

Clone this application to your machine and checkout  stable release 3.6

        git clone git://github.com/newscloud/n2.git
        git checkout --track -b stable_release origin/stable_release

Alternatively, download release 3.6 directly [http://github.com/newscloud/n2/archives/v3.6_stable](http://github.com/newscloud/n2/archives/v3.6_stable)

Register a facebook application
-------------------------------

  * Add the Facebook developer application [http://www.facebook.com/developers/](http://www.facebook.com/developers/) and [create a new application](http://www.facebook.com/developers/createapp.php)
  * You **must** set your canvas url to end in /iframe/, ie http://my.site.com/iframe/
  * However, when you set your config files you only want to use http://my.site.com
  * This is used internally to allow the use of a facebook canvas app and an external web pages
  * Other settings of note are:
    * Canvas Type = Iframe
	* Iframe Size = Auto-resize
	* Note: as of October 1st, 2011, NewsCloud has temporarily discontinued support for Facebook canvas applications due to SSL hosting requirements and infrastructure work that we do not have the resources to complete at this time. We hope to add this back soon. In general we recommend people use the website version of this application with Facebook Connect.

Install required software
-------------------------

  * MySQL
  * Redis 2.x

We have switched over to using Redis completely, so memcached is no longer required.

Redis is used in production for caching, the development environment does not do any caching.

However, Redis/Resque are required to be installed for development mode as there isn't
a pluggable job system in rails like the caching system.

You do not need to run a resque worker in development, but things will error out if
you do not have an open redis connection.

We currently require MySQL. We are working on removing the dependency on MySQL, but for now
its required. Additional database targets are PostgreSQL and SQLite.

Setup your config files
-----------------------

The primary(required) config files are:

  * database.yml
  * facebooker.yml -- remember to set callback_url to your base site, ie http://my.site.com
  * locales.yml -- select the languagues you will be using

The optional config files for advanced settings are:

  * application_settings.yml -- misc config options
  * resque.yml -- where to find your redis server, defaults to localhost:6379
  * newrelic.yml for use with the [New Relic](http://newrelic.com/) monitoring (Note: we are not affiliated, we just like their application)
  * smtp.yml for outgoing mail
  * menu.yml -- configure what menu items you want to appear in your application
  * application.god for use with the [God monitoring system](http://god.rubyforge.org/)
  * unicorn.conf.rb
  * There are a number of other advanced files in the config directory

We provide .sample files for the majority of these config files to facilitate easy setup.

As mentioned above, when you set your config options, **remember to use** http://my.site.com and **not** http://my.site.com/iframe/

Internationalization (Locales)
------------------------------

For every language you add in the file config/locales.yml (there is a sample file named config/locales.yml.sample), you
should be sure that you check all the files under /config/locales and create the right locale file for it.
In example, if you add the language "Spanish" with the code "es", you should make sure that under the directory
/config/locales, in each subdirectory, there is a file names es.yml with the right translation.


Install dependencies and setup the framework
--------------------------------------------

Now that we got the hard part out of the way, there are just a few commands left to run.

        # Install [Bundler](http://gembundler.com/)
        sudo gem install bundler
        # Install the required gems
        bundle install
        # Copy the locales file
        cp config/locales.yml.sample config/locales.yml
        # Copy the application file
        cp config/application.yml.sample config/application.yml
        # Copy the providers file
        # Edit the providers file and enter your Facebook app ID and secret key in the appropriate spots
        cp config/providers.yml.sample config/providers.yml
        # Copy the databas file
        cp config/database.yml.sample config/database.yml
        # Create the database
        bundle exec rake db:create
        # Create a database user
        # Temporary workaround for locales bootstrap issue
        # This is strictly to initialize the database so there is at least a locales table in existence to
        # prevent i18n_backend_database from exploding while bootstrapping itself.
        mysql -u mydbuser -p my_n2_db < db/development_structure.sql
        # Run the newscloud setup process, this will create your database along with configuring your application
        bundle exec rake n2:setup
        # Load the default locales
        bundle exec rake i18n:populate:update_from_rails

Post Installation
-----------------

You can now run your application in the typical rails fashion by doing:

       rails server

or by whatever means you normally use.

You must set up an administrator. First, visit your Facebook application or website and register as a user. Then, visit the administration site e.g. http://my.site.com/admin and make yourself an administrator e.g. goto the Members -> Users tab and edit your user account to make you an admin.

Next Steps
----------

Now that you are an admin user, you can configure your home page by going to the tab Front Page -> Build Layout -> Choose Widgets
For more information about configuring you home page, read our [Widget Builder Guide](http://support.newscloud.com/faqs/managing-your-application/using-the-new-masonry-layout-and-widget-builder)

We have a wide array of documentation and articles located at http://support.newscloud.com/

Some useful starting points are:

  * [Community Guide to the NewsCloud Open Source Facebook Platform](http://blog.newscloud.com/community-guide-to-the-newscloud-open-source-facebook-platform.html)
  
  * [Configuring Your Application](http://support.newscloud.com/faqs/configuring-your-application)
  
  * [Managing Your Application](http://support.newscloud.com/faqs/managing-your-application)
  
  * [Using your Facebook Application](http://support.newscloud.com/faqs/using-your-facebook-application)

Developers
----------

There is always more to do in the software world, and we need your help. Grab a fork and hack away! If you're interested in discussing the application further, please get in touch with us.

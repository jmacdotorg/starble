# Starble

A generic (and somewhat naïve) webservice for "stars" (a.k.a. faves, likes, ++s, et cetera).

By running your own Starble service, you can let people stick stars onto other things of yours. Users need not manually authenticate prior to starring things, and Starble offers no outlet for authentication anyway.

I currently use Starble for blog posts, but it could also fit anything that uses globally unique identifiers (GUIDs).

In theory, one could run a global Starble service that would let anyone apply Starble to thing-collections, allowing vistors to attach stars to them. I wouldn't know how to do that yet, but I would bet you a dollar that it's possible, and I intend to bend my mind in this direction eventually.

Starble is written in Perl and uses the Catalyst web application framework, but if you just want to run it you don't need to care too much about that.

## Project status

Very alpha.

Today used by me, Jason McIntosh, [on my blog](http://blog.jmac.org), where I let it figure out for itself what final shape it wants. During this time I reserve the right to change the internals or the interface accordingly and capriciously.

Furthermore, I can't offer much guidance right now about how one should configure one's webserver to best work with Starble, much less how to make practical use of its API. You can certainly see how my blog does it by looking at its JavaScript source, with the caveat that I'm likely to change my mind on key issues before I declare this work stable.

## Installation

1. Run this malarkey on your favorite shell prompt to install all the Perl libraries that Starble needs:

        curl -fsSL https://cpanmin.us | perl - --installdeps .
   
1. If you don't want to use the provided SQLite file (in `db/starble.db`) as Starble's database, use the file `db/sql/starble.sql` to create an empty Starble database elsewhere. (That's a MySQL dump file; modify as needed.)

1. Copy `starble-dist.conf` to `starble.conf` and then update that new file's database connection information as needed.

    If you're OK with using SQLite as Starble's database, then you can leave `starble.conf` unchanged; it already points to the provided SQLite DB file. Otherwise, you'll need some knowledge of [DBI connection syntax](https://metacpan.org/pod/DBI#connect) to aim the configuration at any other database.

1. In the directory `starbled/conf/`, copy `starbled-conf.dist` to `starbled.conf`, and then season to taste.

1. Run this command to start the Starble daemon:

        starbled/bin/starbled start

    At this point you can find logs in `starbled/log/`.
    
Sadly, I cannot at this time provide instructions about how to do anything interesting with Starble once the server is up and listening, beyond the hints provided earlier in this document. I shall provide more documentation as the project stabilizes.

## Starble's API

### API information

In all the below endpoints:

* _[Thing]_ is the [GUID](https://en.wikipedia.org/wiki/Globally_unique_identifier) of the thing you want to attach a star to. Providing any value besides a well-formed GUID results in an error.

* The return value is a JSON hashtable containing two keys:

    * `result`: The result of the query. Either informational (e.g. with the **count** encpoint, or 1/0 for success/failure.
    
    * `guid`: The GUID of the thing in question. (Always the same as the one in the request.)
    
* "The current user" is determined via a simple cookie-based session, and requires no additional API-level information to work.
    
### API endpoints

* **/star/count?thing=[thing]**

    The number of stars attached to the given thing.
    
* **/star/check?thing=[thing]**

    Whether the current user appears to have already starred this thing.
    
* **/star/toggle?thing=[thing]**

    If the user has not starred this thing, star it for this user. Otherwise, unstar it for this user.

## Pre-FAQ

* **Using sessions naïvely as Starble does, can't someone star a thing multiple times by visiting it using different browsers, adding one star for each?**

    I suppose so. I don't know about you but I'd feel thrilled if someone cared enough about a thing of mine to go through that much trouble.

* **I can think of a number of JavaScript-based exploits that will cause a thing's star count to rise artificially!**

    I'm sure you can. Given Starble's scope and purpose, I do not find that this possibility bothers me greatly.

## Author

Jason McIntosh (jmac@jmac.org)

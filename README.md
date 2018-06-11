# RubyCoin

# Getting Started

## Installing Ruby

[`rbenv`](https://github.com/rbenv/rbenv) is recommended.  
Using system Ruby is possible, just make sure you have bundler installed, i.e. `$ gem install bundler`.

## Installing Node

[Node.js](https://nodejs.org/) and NPM are required to use Truffle. You should take a look at Yarn if you're planning to use npm a lot.

```sh
$ npm install -g truffle # yarn global add truffle for yarn users
```

## Getting the repo

```sh
$ git clone git@github.com:ghivert/RubyCoin.git
$ cd RubyCoin
$ bundle install
```

## About Truffle

You'll find everything you need on [their website](http://truffleframework.com/).  
You'll need to download [Ganache](http://truffleframework.com/ganache/).

## Getting the Ethereum toolchain

Solidity is required too. You can find documentation on installation on [their page](https://solidity.readthedocs.io/en/v0.4.24/installing-solidity.html#binary-packages). Be careful to install `solc` and not `solc-js`.

# You're good to go!

## Useful stuff

[Atom](https://atom.io/) text editor with [`linter-solidity`](https://atom.io/packages/linter-solidity).  
[Solium](https://www.getsolium.com/) to lint solidity code.

# How to run the dApp?

Launch Ganache.

```sh
$ truffle migrate
$ bundle exec inesita server
```

Go to [http://localhost:9292/](http://localhost:9292/)

# How to use the app?

- On your favorite web browser (chosen between Chrome, Firefox, Opera or Brave), download [Metamask](https://metamask.io/).  
- Click on `import from seed phrase`.
- Get your seed phrase from Ganache.
- Create your Metamask account from this seed.
- Create a password.
- Accept the conditions.
- You're set up!

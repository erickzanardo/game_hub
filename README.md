# Game Hub

This repository contains a web application, made in Flutter, that works as a hub for an Indie
Game Studio.

Providing smaller developers a way to make their games available.


## Motivation

This project started for learning purposes, at work a new project started, which used
[Riverpod](https://pub.dev/packages/riverpod) for its state management, but I had little experience
with such framework, so I wanted to learn mover about it.

I usually learn better when hands on keyboard, and having a closer to real life application helps
me push the learning, so I took this simple idea that I had sometime ago of having a small game hub
for my own indie game studio, CherryBit Studios.

And that is how Game Hub was born!

## Features

 - User sign up/in through Google
 - Listing of games that users own
 - (WIP) Download of the game Version.
 - more...

## Roadmap

For now Game hub doesn't have a super planed roadmap, its main purpose of existence still is about
learning, so features will be done as they are thought.

## Set up

- Create a Firebase account and configure it on the project throug flutter fire (which
will create the `firebase_options.dart`)
- Enable Firestore in the project and set its rules to the `firestore.rules` found in this project.
- Enable authentication and the google provider in it.

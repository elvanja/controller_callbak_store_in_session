# Storing controller callback in session

An example project that demonstrates the problem with storing Rails controller callback results in session.
Related to http://stackoverflow.com/questions/16770090/storing-rails-controller-callback-in-session 

## Idea

Perform some time consuming action in background.
Have the results from that action be propagated back to the controller using a callback.
Store the result in an in memory session store.
Have the result in session be used and available from that point onward.

## Problem

Controller receives the results in the callback, as expected.
However, stored session is **lost** in subsequent calls.

## Current flow with log details

* Increase button is hit on the example page
* Controller retrieves current counter from session
  * Log => retrieved counter: 0, for session: 301372d90db768eb6833962edfd7e177
* Increase action is triggered
  * Log => increasing
* Since it is done in a separate thread, return value is the start value
  * Controller saves that value and displays it
  * Log => storing counter: 0, for session: 301372d90db768eb6833962edfd7e177
* Calculation is performed
  * Log => new value: 1
* Listeners notified
  * Log => notifying listeners
  * Log => notifying ExampleController
* Controller receives the new value
  * Log => callback counter: 1
* And stores it
  * Log => storing counter: 1, for session: 301372d90db768eb6833962edfd7e177
* Subsequent reading again gets the old value
  * Log => retrieved counter: 0, for session: 301372d90db768eb6833962edfd7e177


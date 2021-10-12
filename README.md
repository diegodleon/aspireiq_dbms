# README

AspireIq take home test.

This project exposes a Rails API server with one route available at POST `/generate_update_statement`.

Curl example to hit the API:

    curl --location --request POST 'localhost:3000/generate_update_statement' \
    --header 'Content-Type: application/json' \
    --data-raw '{
        "original_document": {"name": "diego", "posts": [{"_id": 2, "value": "two"}, {"_id": 1, "value": "one", "mentions": [{"_id": 3, "name": "Diego"}]}]},
        "mutation_object": { "posts": [{"foo": "bar"}] }
    }'

## Author: Diego De Leon

## Stack:
  - Ruby 3.0
  - Rails 6.1
  - Docker

## How to run
  - git clone git@github.com:diegodleon/aspireiq_dbms.git
  - cd into project folder
  - docker build . -t aspireiq

  To run as server:
  - docker run -it -p 3000:3000 aspireiq

  To run a bash inside the container:
  - docker run -it -p 3000:3000 aspireiq bash

## How to run tests
  - docker run -it -p 3000:3000 aspireiq bash
  - rspec spec (inside container terminal)

## Considerations

  I kept the time invested in this project to 4 hours as stated in the exercise description. Therefore it is still work in progress for the following aspects:

    - All operations work for first level "posts".
    - Second level operations on "mentions" only work for "$add". However, the approach implemented in code needs to only be ported into the other two operations in order for them to support second level statements on "mentions".
    - Unit testing was implemented only for first and second level happy paths for the "$add" operation to depict proficiency in writting tests.
    - The architecture implemented in code allowed for:
      1. Loose coupling and high encapsulation per operation.
      2. Which in turn allowed for easy unit test implementation that requires no mocking.
    - If we wanted to go concurrent on this system I can think of the following approach:
      1. Enqueue all requests in a queue to async decouple.
      2. Have workers process the incoming requests in the order which they arrived.
      3. Implement a distributed locking mechanism (such as a Redis key with a TTL) that allows multiple process to signal the document they are mutating in order to prevent other mutators from concurrently mutating the same doc.
    - CI/CD could be easily accomplished using Github Actions and leveraging the containerization provided.

---
layout: post
categories: [code]
---

[Google App Engine](https://cloud.google.com/appengine/) does not allow for a [SCAN](https://en.wikipedia.org/wiki/Full_table_scan) like operation on a `kind`. Although this is a hard limit, it can be worked around with some thought. This is my generic solution.

## Considerations
GAE does not allow locking of the database. GAE does not even allow for locking of a `kind`. Transactions are the only locking mechanism in GAE, and they are limited to the entity groups within the transaction.

 The closest GAE has to a scan (a lock of a `kind`, where every element of that `kind` is processed) is a GAE Query; which is a filtered iterator. Queries are "best effort" and are not guaranteed to reflect the current state of the database. Still, they are the best you have.

Using a iterator would be a O(N) cost, where N is the number of rows of a GAE `kind` . GAE is all about scaling dynamically. It would be nice if we could divide up the work of processing every row of a `kind`.

## Solution
I have written a system that lets you (probabilistically) process every entity of a `kind`. It does not hard guarantee that every entity will be processed, but with a sufficient number of retries it does probabilistically guarantee that they after entity has been processed.

## Usage

```
scan(
  '<kind>', # the Datastore kind that you want to scan
  retries=1, # a non negative integer, default 1
  retry-fx=lambda i: i**2, # i is the retry count, i=0 is always immediate
  max-retries=2, # a non negative integer, default 2
)
```

The `handler-path` will be called with the `urlsafe()` key of every entity of `'kind'` `<kind>`. Specifically `/<handler-path>/<urlsafekey>` will be called for every `<kind>` entity. If `handler-path` returns 2xx, it is considered a success; otherwise it is a failure. Failure will cause the task to be re-enqueued in `retry-fx(retry-count)` seconds.

## Example

Assume there are 3 Dog entities in the database with urlsafekey's of `"rottweiler"`, `"poodle"`, and `"dalmation"`. Then,
```
from scanner import scan
scan('Dog', "/add/pedigree")
```
will cause the following endpoints to be called.
* `/add/pedigree/rottweiler`
* `/add/pedigree/poodle`
* `/add/pedigree/dalmation`

This isn't much of a big deal when we are talking about 3 entities. But it is pretty useful when we are talking about thousands or millions of entities. Thanks to this "soft scan" we have the ability to have a function (a endpoint) called on every item of a particular kind in the datastore.

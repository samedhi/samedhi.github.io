---
layout: post
categories: [code]
---

This week I wrote an addition to
[gaend](https://github.com/samedhi/gaend) that automatically causes every `ndb.Model` entity to automagically be persisted to [Elasticsearch](https://www.elastic.co/products/elasticsearch).

## Why?

[Datastore](https://cloud.google.com/datastore/docs/concepts/overview) (the database technology that powers Google App Engine) has a number of great features.
1. It scales to like forever
2. With GAE, you can do complex validation on every write
3. Automatically applied security, upgrades, scaling, partioning, etc.
4. It is pretty simple

Although datastore is perfect as a Key/Value store that allows transactions, it does have its limitations.

1. It does not allow SCAN
2. It does not allow JOIN

One effect of these limits is that it can difficult to do things like aggregation on tables. You should use the proper tool for the desired outcome.

* Datastore is great because you don't need much devops.

* Elasticsearch is great at doing aggregation.

Datastore is structured (typed) data. Everything that goes into Elasticsearch must be JSON data. Structured data can be fairly easily transformed into JSON data. You see where I am going with this?

## Nuance

This extension to [gaend](https://github.com/samedhi/gaend) does successfully convert any Datastore data into Elasticsearch. You should look at your table in Datastore and perhaps consider whether you need to submit a custom [mapping](https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping.html) for Elasticsearch. If unspecified, Elasticsearch will automagically generate a mapping for you based on the submitted JSON document. For tables made up of "primitive" data, the dynamically generated mapping is usually sufficient. Still, know that you can override the dynamic in the event that you have complex, deeply nested, or large types of data.

---
layout: post
categories: [code]
---

[Vault](https://www.hashicorp.com/blog/vault.html) is a tool for managing secrets. Vault act as a key/value store where the keys are paths and the values are dictionaries written at those paths. Vault allows for auditing, roles, applications, and much more.

# Prelude

*From here on I will be calling calling the Vault-server-you-have-running simply as 'Vault'*

Vault manages application access to secrets through a `TOKEN`. A `TOKEN` is built from a tuple of `(ROLE_ID, SECRET_ID)`. You likely have a single `ROLE_ID` per application. Your `SECRET_ID` is a [cryptographic nonce](https://en.wikipedia.org/wiki/Cryptographic_nonce) that is exchanged with the `ROLE_ID` to get a `TOKEN`. As a nonce, your `SECRET_ID` can only be exchanged 1 time for a `TOKEN`.

Once you application has a `TOKEN` it can then make request to your Vault server. A `TOKEN` will expire `N` minutes from its last refresh or initialization. So to keep a `TOKEN` valid, the application will need to tell Vault at least once every N minutes to refresh (extend) the `TOKEN`. Your Token will always have a lifetime of time of the last refresh plus `N`. When your server goes down, the token will soon expire as the application will no longer be extending the `TOKEN` lifetime.

# Problem

So, your application needs a `TOKEN` in order to access Vault. How do you get the `TOKEN` to the application? I can think of at least a few solutions.

1. Don't use Vault, just include secrets in your application.
1. Include the `TOKEN` as part of your deployment.
1. Include the `SECRET_ID` as part of your deployment.
1. Pass the `SECRET_ID` to an endpoint in your application after it has started up.

Obviously solution 1 is not ideal. We have all done it, but it is not a good idea. There **definitely** should be no secrets in your source code. Secrets in your source code means you cannot share your code without a full audit. Ugh

Environment variables are surely better. But it still requires you to ask questions about what secrets exist where when you are considering your infrastructure. Contrast this to having secrets in one place (Vault). If you are considering Vault then you have likely decided that environment variables are not a good enough solution, so I will not spend any more time attacking them.

Moving on to 2-4.

Two is the equivalent of putting ALL your secrets in your application. Anyone who gets access to the `TOKEN` (through source or environment variables) can access Vault as that application.

Three is sound under some very strictly ordered conditions. I need to be certain that my application is the **first** to exchange `(ROLE_ID, SECRET_ID)` for the `TOKEN`. Because `SECRET_ID` is a nonce, I don't need to worry about subsequent request, only the first one wins. However, if Alice was able to get the `SECRET_ID` and exchange it for a `TOKEN` **before** my application was, ALICE would now have access to all of the applications secrets. Security dependent order does not sound like a good idea.

Four is the solution I think is safest. Bake your `ROLE_ID` into the app itself. After deployment of your app, call an endpoint on it and pass in a `SECRET_ID`. As soon as it is received your `(ROLE_ID,SECRET_ID)` will be exchanged for a `TOKEN` by the application. This alleviates the timing concerns of solution three while still allowing us to have zero secrets in code or environment variables. Furthermore, you can leave the `SECRET_ID` endpoint entirely open. Vault will refuse to provide a `TOKEN` for a `SECRET_ID` that it did not issue. Effectively, you are using the `SECRET_ID` as a bearer token as well.

# Solution

I have written a demo project that does exactly that.

---
layout: post
categories: [code]
---

Your application needs a `TOKEN` in order to access your [Vault](https://www.hashicorp.com/blog/vault.html) server. How do you get the `TOKEN` to the application server?

## Some Background

*From here on we will be calling your Vault-server-in-the-cloud simply 'Vault'*

Vault is a tool for managing secrets. Vault act as a key/value store where the keys are paths and the values are dictionaries written at those paths. Vault allows for auditing, roles, authentication, and much more.

Vault application access your secrets through a `TOKEN`. A `TOKEN` is built from a tuple of `(ROLE_ID, SECRET_ID)`. You likely have a single `ROLE_ID` per application. Your `SECRET_ID` is a [cryptographic nonce](https://en.wikipedia.org/wiki/Cryptographic_nonce) that is exchanged with the `ROLE_ID` to get a `TOKEN`. As a nonce, your `SECRET_ID` may only be exchanged for a `TOKEN` at most one time.

Once you application has a `TOKEN` it may then make request to your Vault server. A `TOKEN` will expire `N` minutes from its last refresh or initialization. So to keep a `TOKEN` valid, the application will need to tell Vault at least once every N minutes to refresh (extend) the `TOKEN`. Your Token will always have a lifetime of (last refresh time) + `N`. If your server goes down, the `TOKEN` will soon expire as the application will no longer extend the `TOKEN` lifetime.

## What solutions do we have for secrets?

### Don't use Vault; include secrets in your application
We have all done it, it is not a good idea. There **definitely** should be no secrets in your source code. Secrets in your source code means you cannot share your code without a full audit. Ugh

Environment variables are better. It still requires that you ask questions about what secrets exist at what locations when you are considering your infrastructure. Contrast this to having secrets in one place (Vault). If you are considering Vault then you have likely decided that environment variables are not a good enough solution, so I will not spend any more time attacking them.

### Include the Vault `TOKEN` as part of your deployment
The equivalent of putting ALL your secrets in your application. Anyone who gets access to the `TOKEN` (through source or environment variables) can access Vault as the application.

### Include the Vault `(ROLE_ID,SECRET_ID)` as part of your deployment
This is sound under some strictly ordered conditions. We must be certain that the application is the **first** to exchange `(ROLE_ID, SECRET_ID)` for the `TOKEN`. Because `SECRET_ID` is a nonce, we don't need to worry about subsequent request, only the first one wins. However, if Alice is able to get the `SECRET_ID` and exchange it for a `TOKEN` **before** our application, Alice would now have access to all of the applications secrets.  Dependent order in security does not sound like a good idea.

### Pass the Vault `(ROLE_ID,SECRET_ID)` in a application endpoint
After deployment of your app, call an endpoint on it and pass in a `(ROLE_ID,SECRET_ID)`. Your application will then exchange your `(ROLE_ID,SECRET_ID)` for a `TOKEN`. This alleviates the timing concerns of the previous solution while still having zero secrets in code or environment variables. This endpoint can be entirely open. Vault will refuse to provide a `TOKEN` for a `(ROLE_ID, SECRET_ID)` that it did not issue.

## Solution

I have [written a demo project](https://github.com/samedhi/canary-in-a-vault) that implements a `(ROLE_ID,SECRET_ID)` endpoint. After the very first deployment of the app, it requires that you "light the pilot light" by posting a `(ROLE_ID, SECRET_ID)` that may be use to access Vault. So, the steps are.

1. Deploy the app
2. Make a curl POST request to `/vault` with your `(ROLE_ID, SECRET_ID)`.
3. If you want to update the `TOKEN`, make another curl POST request with a new secret, expire the old `TOKEN`.

Instructions are provided in the [README](https://github.com/samedhi/canary-in-a-vault).

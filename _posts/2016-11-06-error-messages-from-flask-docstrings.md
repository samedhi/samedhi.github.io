---
layout: post
categories: [code]
---
I have a large number of simple (mostly restful) Flask endpoints. I write docstrings for each endpoint. Can I generate error messages based solely on the endpoints docstring?

This is probably a very silly thing to do... I am a silly man. :]

# Example

Here is an example Flask endpoint:

{% highlight python %}
@app.route('/user', methods=['POST'])
def post_user():
    """
    Create a new User.

    REQUEST Body (as JSON):
    {
    'first_name': <String>,         # 'Marlon'
    'last_name': <String>,          # 'Brando'
    'email': <String>,              # 'marlon@thewaterfront.com'
    'contender?': <Bool>,           # optional, default is False
    'age': <Int>                    # optional, default is None
    }

    RESPONSE of 200 indicates success.
    """
    pass # Code to create user goes here
{% endhighlight %}

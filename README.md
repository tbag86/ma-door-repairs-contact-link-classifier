# Contact Link Classifier

Use this Google Tag Manager variable to group an outbound or on-site link click by contact intent. It returns one of four labels and keeps the phone number, email address and full URL out of its output.

| Output | Meaning |
| --- | --- |
| `phone` | A non-empty `tel:` link |
| `email` | A non-empty `mailto:` link |
| `quote` | The absolute URL matches the configured contact page |
| `other` | Any other value, including missing input |

## Configure in a web container

Enable the built-in **Click URL** variable and select it as the **Clicked link URL** input. If your site has a dedicated enquiry page, enter its complete address in **Contact page URL**. Leave that field blank to classify only telephone and email links.

The contact-page check compares the origin and path. Query parameters, fragments and a trailing slash on a non-root path do not affect that match. The test cases use example domains and synthetic contact values.

The variable requests no Tag Manager permissions and does not send events. An implementer can use the returned value in an existing trigger or tag as appropriate. A click label measures intent and a completed enquiry must be measured separately.

## MA Door Repairs example

The [service homepage](https://www.door-repair.co.uk/) has links for booking mobile repairs. Set **Contact page URL** to the [MA Door Repairs contact page](https://www.door-repair.co.uk/contact/) to identify navigation to its quote information.

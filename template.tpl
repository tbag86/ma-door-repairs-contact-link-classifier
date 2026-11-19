___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "displayName": "Contact Link Classifier",
  "description": "Returns a short category for phone, email, or contact page link clicks.",
  "categories": [
    "UTILITY",
    "LEAD_GENERATION"
  ],
  "securityGroups": [],
  "id": "cvt_ma_contact_link_classifier",
  "type": "MACRO",
  "version": 1,
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "linkUrl",
    "displayName": "Clicked link URL",
    "help": "Select the Click URL built-in variable."
  },
  {
    "type": "TEXT",
    "name": "contactPage",
    "displayName": "Contact page URL",
    "help": "Optional. Enter the absolute contact page URL including its domain."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const parseUrl = require('parseUrl');

function canonicalPage(value) {
  if (typeof value !== 'string' || !value.trim()) return '';
  const url = parseUrl(value.trim());
  if (!url || !url.origin || url.username || url.password) return '';
  if (url.protocol !== 'https:' && url.protocol !== 'http:') return '';

  const path = url.pathname;
  const trimmedPath = path.length > 1 && path.slice(-1) === '/'
      ? path.slice(0, -1)
      : path;
  return url.origin + trimmedPath;
}

if (typeof data.linkUrl !== 'string') return 'other';
const link = data.linkUrl.trim();
const lower = link.toLowerCase();
if (lower.indexOf('tel:') === 0 && link.slice(4).trim()) return 'phone';
if (lower.indexOf('mailto:') === 0 && link.slice(7).trim()) return 'email';

const contact = canonicalPage(data.contactPage);
return contact && canonicalPage(link) === contact ? 'quote' : 'other';


___TESTS___

scenarios:
- name: Phone links return only the channel
  code: |
    assertThat(runCode({linkUrl: ' TEL:+440000000000 '})).isEqualTo('phone');
- name: Email links return only the channel
  code: |
    assertThat(runCode({linkUrl: 'mailto:demo@example.org?subject=Quote'})).isEqualTo('email');
- name: Contact page matches while dropping query parameters and fragments
  code: |
    const inputs = {
      contactPage: 'https://example.org/contact/',
      linkUrl: 'https://example.org/contact?utm_source=sample#enquire'
    };
    assertThat(runCode(inputs)).isEqualTo('quote');
- name: An unrelated host is not a contact click
  code: |-
    const inputs = {
      contactPage: 'https://example.org/contact/',
      linkUrl: 'https://different.example.org/contact/'
    };
    assertThat(runCode(inputs)).isEqualTo('other');


___NOTES___

Created on 19/11/2026, 22:02:23



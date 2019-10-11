# url_text_extractor
A quick single file script to get human readable text from a webpage

Tested using python 3.7.3
To install requirements
```
$> python3 -m venv env
$> source env/bin/activate
(env)$> pip install requirements.txt
```

Once environment is activated you can use the makefile to test full and visible content on google.com
```
# This should return the html content
(env)$> make testvis

google.com	https://www.google.com/?gws_rd=ssl	1	evaluate_content_for_200s: [b' google . . we\'ve detected you\'re using an older version of chrome. reinstall to stay secure × about store we\'ve detected you\'re using an older version of chrome. reinstall to stay secure × gmail images sign in remove report inappropriate predictions × discover tools to help manage your digital wellbeing privacy terms settings search settings advanced search your data in search history search help send feedback advertising business how search works account search maps youtube play news gmail contacts drive calendar translate photos shopping more finance docs books blogger duo hangouts keep jamboard earth collections even more from google ']
```

### How the script works
The script was originally set up to validate urls, and to work on a hadoop streaming job.  So it has the following features.
* It uses console in and out for input
* It will output a tab separated line with the the following info
    - the url passed in
    - the full url which returned content (http, https, www, or a combination thereof, as in https://www)
    - 1 if valid url, or 0 if it has text that indicates it is a 5xx, 4xx, or parked page
    - a string which:
        - indicates it is a valid url
        - The full html content if the URL_FULL_CONTENT environment flag is set to true (`export URL_FULL_CONTENT=True`)
        - The readable text from a web page if URL_VISIBLE_CONTENT environment flag is set (`export URL_VISIBLE_CONTENT=True`)
        
        
        
### Examples:
To simply check if a url is valid
```
echo google.com | python extract.py
```

To check, and retrieve the full html content
```
export URL_FULL_CONTENT=True
echo google.com | python extract.py
```

To check, and retrieve only the visible human readable text
```
export URL_VISIBLE_CONTENT=True
echo google.com | python extract.py
```

Full content takes presedence over visible, so if both are set full is returned

To clear the flags use the unset.sh with `source unset.sh`

### To work on a file of urls
```
cat test_urls.txt | python extract.py  > content.tsv
# then you can open content.csv with excel or a csv viewer
```

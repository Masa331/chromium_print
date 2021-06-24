require 'ferrum'
require 'pry'
require 'base64'


browser = Ferrum::Browser.new(url: 'http://localhost:9222')

context1 = browser.contexts.create
page = context1.create_page
page.goto("about:blank")

context2 = browser.contexts.create
page2 = context2.create_page
page2.goto("about:blank")


# browser.goto("https://google.com")

# f = browser.frames[1]
# binding.pry
# f.set_content("<html><head></head><body><p>lol</p></body></html>")

# result = browser.screenshot(path: "google.png")

binding.pry

puts 'cool'

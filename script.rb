require 'base64'
require 'chrome_remote'
require 'pry'

class Printer
  def self.call html
    new(html).print
  end

  def initialize html
    @html = html
    @chrome = ChromeRemote.client({ host: 'localhost', port: 9222 })
  end

  def print
    # chrome = ChromeRemote.client({ host: 'localhost', port: 9222 })

    @chrome.send_cmd('Network.enable')
    @chrome.send_cmd('Page.enable')

    frame_tree = @chrome.send_cmd('Page.getResourceTree')
    id = frame_tree['frameTree']['frame']['id']

    # @chrome.send_cmd('Page.setDocumentContent', html: @html, frameId: id)
    # @chrome.wait_for('Page.loadEventFired')

    # result = @chrome.send_cmd('Target.createTarget', url: 'https://seznam.cz')
    # target_id = result['targetId']
    # chrome.send_cmd("Target.activateTarget", targetId: )
    # chrome.wait_for('Page.loadEventFired')

    binding.pry

    # chrome.wait_for do |name, params|
    #   puts name
    #   puts params
    #   puts '###'
    #
    #   false
    # end


    # settings = { preferCSSPageSize: true, printBackground: true }
    # result = chrome.send_cmd('Page.printToPDF', settings)
    #
    # return Base64.decode64(result["data"])
  end

  def c command, arguments = {}
    @chrome.send_cmd(command, arguments)
  end

  def targets
    c('Target.getTargets')
  end

  def attach_to target_id
    c('Target.attachToTarget', targetId: target_id)
  end

  def detach_from target_id
    c('Target.detachFromTarget', targetId: target_id)
  end
end

html = <<-HTML
<!doctype html>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Labels</title>

    <style type="text/css" media="all">
    </style>
  </head>

  <body>
    <b>ahoj!</b><span>#{Time.now}</span>
  </body>
</html>
HTML

Printer.call(html)
puts 'cool'

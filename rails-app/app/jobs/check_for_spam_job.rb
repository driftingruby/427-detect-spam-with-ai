require "net/http"
require "uri"
require "json"

class CheckForSpamJob < ApplicationJob
  queue_as :default

  def perform(comment)
    prompt = comment.content.to_plain_text
    uri = URI.parse("http://127.0.0.1:8000/check")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == "https"
    http.open_timeout = 10
    http.read_timeout = 10
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({ prompt: prompt })
    response = http.request(request)
    result = JSON.parse(response.body)

    if defined?(result["spam"])
      # comment.update(spam_checked_on: Time.now, spam: result["spam"])
      comment.destroy if result["spam"]
    else
      # retry
    end

  rescue StandardError => e
    # retry
  end
end

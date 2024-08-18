class UnipileService
    API_URL = "https://api6.unipile.com:13646/api/v1/hosted/accounts/link"
  
    def initialize(user)
      @user = user
    end
  
    def request_automation_link(email, otp_token)
      uri = URI(API_URL)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
  
      request = Net::HTTP::Post.new(uri.request_uri)
      request["Accept"] = "application/json"
      request["Content-Type"] = "application/json"
      request["X-API-KEY"] = "Fy+jNMsR.oPh59qIU9ukBmH6QROHfYjntPKkmB0e4xnPe9X4cqB8="
  
      request.body = {
        expiresOn: "2025-12-31T23:59:59.999Z",
        name: "UserAccountName",
        success_redirect_url: "https://example.com/success",
        failure_redirect_url: "https://example.com/failure",
        notify_url: "https://example.com/notify",
        disabled_features: ["linkedin_recruiter"],  
        api_url: "https://api6.unipile.com:13646",
        sync_limit: {
            MAILING: "NO_HISTORY_SYNC",
            MESSAGING: {
            chats: 100,
            messages: 50
          }
        },
        type: "create",
        providers: "*"
      }.to_json
  
      response = http.request(request)
      JSON.parse(response.body)
    end
  end
  
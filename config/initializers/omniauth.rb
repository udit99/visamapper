Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "693985642511.apps.googleusercontent.com", "_l81jx4FNmfmxYGjg-_znA60"
  provider :facebook, 279248308803686,'c3ece4a5cefbd794e2d40607ef8b1637' 
end

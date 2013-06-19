Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "1059245571330.apps.googleusercontent.com", "aE-Bk2cOqViteMtqRDGtUNjt",
      {
             :scope => "userinfo.email,userinfo.profile,plus.me,http://gdata.youtube.com",
             :approval_prompt => "auto"
      }
end

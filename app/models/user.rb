require 'digest/sha1'

class User < ActiveRecord::Base
  
  
  attr_protected :id, :salt
  validates_uniqueness_of :email_id
  validates_confirmation_of :password
  validates_format_of :email_id, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"  
  validates_presence_of :email_id,:password,:first_name,:last_name,:password_confirmation
  attr_accessor :email_id,:password,:first_name,:last_name,:password_confirmation
  
  def before_save(user)
    
  end
  
 
  
  def self.random_string(len)
   chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
   newpass = ""
   1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
   return newpass
  end
  
  def password=(pass)
   self.salt = User.random_string(10) if !self.salt?
   self.password_hash = User.encrypt(pass, self.salt)
  end
  
  def self.encrypt(pass, salt)
   Digest::SHA1.hexdigest(pass+salt)
  end
  
  def self.authenticate(email_id, pass)
    u=find(:first, :conditions=>["email_id = ?", email_id])
    return nil if u.nil?
    return u if User.encrypt(pass, u.salt)==u.password_hash
    nil
  end  
  
end

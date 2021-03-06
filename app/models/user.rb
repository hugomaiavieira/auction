class User < ActiveRecord::Base
  has_many :bids

  def self.from_omniauth(auth)
    where(auth.slice('uid')).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.uid = auth['uid']
      user.name = auth['info']['name']
      user.email = auth['info']['email']
      user.link = auth['info']['urls']['Facebook']
    end
  end

  def image
    "https://graph.facebook.com/#{uid}/picture"
  end
end

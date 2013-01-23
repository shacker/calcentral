class UserApi < MyMergedModel

  attr_reader :first_name, :last_name

  def initialize(uid)
    super(uid)
    @calcentral_user_data = UserData.where(:uid => @uid).first
    @campus_attributes = CampusData.get_person_attributes(@uid) || {}
    @default_name = @campus_attributes['person_name']
    @first_login_at = @calcentral_user_data ? @calcentral_user_data.first_login_at : nil
    @first_name = @campus_attributes['first_name'] || ""
    @last_name = @campus_attributes['last_name'] || ""
    @override_name = @calcentral_user_data ? @calcentral_user_data.preferred_name : nil
  end

  def preferred_name
    @override_name || @default_name || ""
  end

  def preferred_name=(val)
    if val.blank?
      val = nil
    else
      val.strip!
    end
    @override_name = val
  end

  def self.delete(uid)
    logger.debug "#{self.class.name} removing user #{uid} from UserData"
    user = UserData.where(:uid => uid).first
    if !user.blank?
      user.delete
      # The nice way to do this is to also revoke their tokens by sending revoke request to the remote services
      Oauth2Data.destroy_all(:uid => uid)
    end
    Calcentral::USER_CACHE_EXPIRATION.notify uid
  end

  def save
    if !@calcentral_user_data
      @calcentral_user_data = UserData.create(uid: @uid, preferred_name: @override_name)
    else
      stored_override = @calcentral_user_data.preferred_name
      if stored_override != @override_name
        @calcentral_user_data.update_attributes(preferred_name: @override_name)
      end
    end
    @calcentral_user_data.update_attribute(:first_login_at, @first_login_at)
    Calcentral::USER_CACHE_EXPIRATION.notify @uid
  end

  def update_attributes(attributes)
    if attributes.has_key?(:preferred_name)
      self.preferred_name = attributes[:preferred_name]
    end
    save
  end

  def record_first_login
    @first_login_at = DateTime.now
    save
  end

  def get_feed_internal
    {
        :first_login_at => @first_login_at,
        :first_name => self.first_name,
        :has_canvas_access_token => CanvasProxy.access_granted?(@uid),
        :has_google_access_token => GoogleProxy.access_granted?(@uid),
        :last_name => self.last_name,
        :preferred_name => self.preferred_name,
        :uid => @uid,
        :widget_data => {},
    }
  end

end

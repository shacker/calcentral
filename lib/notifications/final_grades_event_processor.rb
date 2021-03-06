class FinalGradesEventProcessor < AbstractEventProcessor
  include ActiveRecordHelper

  def accept?(event)
    return false unless super event
    event["code"] == "EndOFTermGrade"
  end

  def process_internal(event, timestamp)
    payload = event["payload"]
    ccn = payload["ccn"]
    term_yr = payload["year"]
    term_cd = FinalGradesEventProcessor.lookup_term_code payload["term"]

    students = CampusData.get_enrolled_students(ccn, term_yr, term_cd)

    return [] unless students
    Rails.logger.debug "#{self.class.name} Found students enrolled in #{term_yr}-#{term_cd}-#{ccn}: #{students}"

    notifications = []
    students.each do |student|
      unless is_dupe?(student["ldap_uid"], event, timestamp, "FinalGradesTranslator")
        entry = nil
        use_pooled_connection {
          entry = Notification.new(
            {
              :uid => student["ldap_uid"],
              :data => {
                :event => event,
                :timestamp => timestamp
              },
              :translator => "FinalGradesTranslator",
              :occurred_at => timestamp
            })
        }
        notifications.push entry unless entry.blank?
      end
    end
    notifications
  end

  def self.lookup_term_code(term)
    case term.downcase
      when "spring"
        "B"
      when "summer"
        "C"
      when "fall"
        "D"
      else
        "D"
    end
  end

end

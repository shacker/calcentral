require 'my_tasks/param_validator'

class MyTasks::Merged < MyMergedModel
  include MyTasks::ParamValidator

  attr_reader :enabled_sources

  def initialize(uid, options={})
    super(uid, options)
    #To avoid issues with tz, use time or DateTime instead of Date (http://www.elabs.se/blog/36-working-with-time-zones-in-ruby-on-rails)
    @starting_date = Time.zone.today.to_time_in_current_zone
    @now_time = Time.zone.now
    @enabled_sources = {
      CanvasProxy::APP_ID => {access_granted: CanvasProxy.access_granted?(@uid),
                              source: MyTasks::CanvasTasks.new(@uid, @starting_date),
                              pseudo_enabled: CanvasProxy.allow_pseudo_user?},
      GoogleProxy::APP_ID => {access_granted: GoogleProxy.access_granted?(@uid),
                              source: MyTasks::GoogleTasks.new(@uid, @starting_date),
                              pseudo_enabled: GoogleProxy.allow_pseudo_user?}
    }
    @enabled_sources.select!{|k,v| v[:access_granted] == true}
  end

  def get_feed_internal
    tasks = []
    @enabled_sources.each do |key, value_hash|
      if (is_acting_as_nonfake_user?) && !value_hash[:pseudo_enabled]
        next
      end
      value_hash[:source].fetch_tasks!(tasks)
    end
    logger.debug "#{self.class.name} get_feed is #{tasks.inspect}"
    {"tasks" => tasks}
  end

  def update_task(params, task_list_id="@default")
    return {} if @enabled_sources[params["emitter"]].blank?
    validate_update_params params
    source = @enabled_sources[params["emitter"]][:source]
    response = source.update_task(params, task_list_id)
    if response != {}
      expire_cache
    end
    response
  end

  def insert_task(params, task_list_id="@default")
    source = @enabled_sources[params["emitter"]][:source]
    response = source.insert_task(params, task_list_id)
    if response != {}
      expire_cache
    end
    response
  end

  def delete_task(params, task_list_id="@default")
    puts("in merged.rb, delete_task")
    puts("params are: ", params)
    source = @enabled_sources[params["emitter"]][:source]
    response = source.delete_task(params, task_list_id)
    if response != {}
      expire_cache
    end
    response
  end

  private

  def includes_whitelist_values?(whitelist_array=[])
    Proc.new { |status_arg| !status_arg.blank? && whitelist_array.include?(status_arg) }
  end

  def validate_update_params(params)
    filters = {
        "type" => Proc.new { |arg| !arg.blank? && arg.is_a?(String) },
        "emitter" => includes_whitelist_values?(@enabled_sources.keys),
        "status" => includes_whitelist_values?(%w(needs_action completed))
    }
    validate_params(params, filters)
  end

end

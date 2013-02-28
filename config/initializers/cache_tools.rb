require 'observer.rb'


module Calcentral

  Rails.application.config.after_initialize do

    USER_CACHE_WARMER = UserCacheWarmer.new

    USER_CACHE_EXPIRATION = Calcentral::UserCacheInvalidator.new

    {
        UserApi => :expire,
        MyClasses => :expire,
        MyTasks::Merged => :expire,
        MyBadges::Merged => :expire,
        MyUpNext => :expire,
        MyGroups => :expire,
        MyActivities => :expire,

        CanvasProxy => :expire,
        CanvasComingUpProxy => :expire,
        CanvasCoursesProxy => :expire,
        CanvasGroupsProxy => :expire,
        CanvasTodoProxy => :expire,
        CanvasUserActivityProxy => :expire,
        CanvasUserActivityProcessor => :expire,

        GoogleProxy => :expire,
        GoogleCreateTaskListProxy => :expire,
        GoogleDeleteTaskListProxy => :expire,
        GoogleEventsListProxy => :expire,
        GoogleDeleteTaskProxy => :expire,
        GoogleInsertTaskProxy => :expire,
        GoogleTasksListProxy => :expire,
        GoogleUpdateTaskProxy => :expire,
        GoogleUserinfoProxy => :expire,

        SakaiProxy => :expire

    }.each do |key, value|
      USER_CACHE_EXPIRATION.add_observer(key, value)
    end

    #Pseudo-prefix constant
    PSEUDO_USER_PREFIX = "pseudo_"

  end
end


require "spec_helper"

describe "MyAcademics::Semesters" do

  it "should get properly formatted data from fake Oracle MV", :if => SakaiData.test_data? do
    oski_schedule_proxy = CampusUserCoursesProxy.new({:user_id => "61889", :fake => true})
    CampusUserCoursesProxy.stub(:new).and_return(oski_schedule_proxy)

    feed = {}
    MyAcademics::Semesters.new("61889").merge(feed)
    feed.empty?.should be_false

    oski_semesters = feed[:semesters]
    oski_semesters.length.should == 1
    oski_semesters[0][:name].should == "Spring 2013"
    oski_semesters[0][:schedule].length.should == 2
    oski_semesters[0][:schedule][0][:schedules][0][:schedule].should == "M 4:00P-5:00P"
    oski_semesters[0][:schedule][0][:course_number].should == "BIOLOGY 1A"
    oski_semesters[0][:schedule][0][:ccn].should == "7309"
    oski_semesters[0][:schedule][0][:title].should == "General Biology Lecture"
    oski_semesters[0][:schedule][0][:units].should == "5.0"
    oski_semesters[0][:schedule][0][:grade_option].should == "Letter"
    oski_semesters[0][:schedule][0][:format].should == "LEC"
    oski_semesters[0][:schedule][0][:section].should == "003"
    oski_semesters[0][:schedule][0][:instructors][0][:name].should == "Yu-Hung Lin"
  end

end

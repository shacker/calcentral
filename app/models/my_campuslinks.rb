# require 'lib/cacheable.rb'
class MyCampuslinks < MyMergedModel
# module MyCampuslinks
#   class Merged < MyMergedModel
  # extend Calcentral::Cacheable

=begin

  NOTES:

  - Navigation consists of Main Categories, Subcategories, and On-page categories
  - Each of these has its own model, but these models do not have a hierarchical relationship
    due to their multiple-overlapping nature. Instead:
  - A Section is defined as a unique aggregate of MainCat/SubCat/PageCat
  - A Section consists of multiple links
  - A Link can belong to multiple Sections
  - Links (or their URLs) are guaranteed unique
  - RailsAdmin is whitelisting only the Models we want to display (in rails_admin.rb)
  - RailsAdmin comes with an optional History feature to track who changed what, but it's disabled here.

=end

  def get_feed_internal
    # Feed consists of two primary sections: Navigation and Links
    links = []
    navigation = []

    # Begin navigation section
    main_nav_top = {
      "label" => "",
      "categories" => [
        {
          "id" => "",
          "name" => "Campus Pages"
        }
      ]
    }
    navigation.push(main_nav_top)

    @maincats = Linkmaincat.all
    @maincats.each do |cat|
      @section = {
        "label" => cat.name,
        "categories" => get_subsections_for_nav(cat)
      }
    navigation.push(@section)

    end

    # End Navigation section

    # Begin Links section
    @all_links = Link.where("published = ?", true)
    @all_links.each do |link|
      links.push({
        "name" => link.name,
        "description" => link.description,
        "url" => link.url,
        "roles" => get_roles_for_link(link),
        "categories" => get_cats_for_link(link)
      })
    end
    data = {"links" => links, "navigation" => navigation}

    # End Links section
  end

  # Given a top-level category, get names and slugs of subcats for navigation
  def get_subsections_for_nav(cat)
    categories = []
    # Find the uniq subsections associated with this main category
    subsects = Linksection.where("linkmaincat_id = ?", cat.id).select(:linksubcat_id).uniq
    subsects.each do |subsection|
      categories.push({"id" => subsection.linksubcat.slug, "name" => subsection.linksubcat.name})
    end
    categories = categories.sort_by { |n| n["name"] } # Alphabetize left-nav subsections
    categories
  end

  # Given a link, return an array of the categories it lives in by examining its host sections
  def get_cats_for_link(link)
    categories = []
    sections = link.linksections
    sections.each do |section|
      catlist = {"topcategory" => section.linksubcat.name, "subcategory" => section.linkpagecat.name}
      categories.push(catlist)
    end
    categories
  end

  # Given a link, return a dict of the user_roles allowed to view it
  def get_roles_for_link(link)
    roles = {"student" => false, "staff" => false, "faculty" => false}
    link.user_roles.each do |linkrole|
      roles["student"] = true if linkrole.slug == "student"
      roles["staff"] = true if linkrole.slug == "staff"
      roles["faculty"] = true if linkrole.slug == "faculty"
    end
    roles
  end

end

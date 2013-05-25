class MyCampuslinksController < ApplicationController

  def get_feed
    if session[:user_id]
      render :json => get_feed_internal.to_json
    else
      render :json => {}.to_json
    end
  end

  private

  def get_feed_internal
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
      section = {
        "label" => cat.name,
        "categories" => get_subsections_for_nav(cat)
      }

      navigation.push(section)
    end

    data = {"links" => links, "navigation" => navigation}
  end
  # End Navigation section

  # === Re-usable methods ====

  # Given a top-level category, get names and slugs of subcats for navigation
  def get_subsections_for_nav(cat)
    categories = []
    @subsects = Linksection.where("linkmaincat_id = ?", cat.id)
    @subsects.each do |subsection|
      categories.push({"id" => subsection.linksubcat.slug, "name" => subsection.linksubcat.name})
    end
    categories
  end

end

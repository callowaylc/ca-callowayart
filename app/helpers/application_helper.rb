module ApplicationHelper
  def slugify(string)
    string.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') if string
  end


  def tags
    # basically moving the chaos that is the current route
    # sytem into hte idea of tags; all of this needs to be
    # replaced
    if params[:tags].present?
      tags = params[:tags]
      tags = tags[1..tags.length].split '/'

    else
      tags = [ ]
      tags << params[:resource] if params[:resource].present?
      tags << params[:slug]     if params[:slug ].present? 

    end

    tags << params[:exhibit] if params[:exhibit].present?
    tags
  end

  
end

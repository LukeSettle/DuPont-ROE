module CompaniesHelper
  def attributes(company)
    content_tag(:ul, class: 'list') do
      company.each do |attribute|
        content_tag(:li, class: 'list-group-item-text') do
          "#{attribute.first}: #{attribute.second}"
        end
      end
    end
  end
end

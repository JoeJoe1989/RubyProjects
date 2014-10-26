require 'nokogiri'
require 'open-uri'

class WorldFactBook
  attr_accessor :country_array
  ABS_PATH = 'https://www.cia.gov/library/publications/the-world-factbook/print/'

  def initialize
    doc = open_link(URI.join(ABS_PATH, 'textversion.html'))
    temp_country_info = doc.css('div#demo ul li a')
    @country_array = [] # [Continent, Country Name, Web Link] for each country

    temp_country_info.each do |x|
      country_link = URI.join(ABS_PATH, x['href'])
      each_country = open_link(country_link)
      country_name = each_country.css('span.region_name1').text
      continent = each_country.css('div.region1').text
      # special case for World as it is in different tag
      spe_world =  each_country.css('div.region_name1').text

      # exclude the cases for Oceans, Antarctica, EU or World
      if continent.match(/Oceans|Antarctica/) or country_name.match(/European Union/) or spe_world.match(/World/) then next
      elsif continent.match(/Asia/) then continent = 'Asia'
      elsif continent.match(/Africa/) then continent = 'Africa'
      elsif continent.match(/Europe/) then continent = 'Europe'
      elsif continent.match(/North America/) then continent = 'North America'
      elsif continent.match(/South America/) then continent = 'South America'
      elsif continent.match(/Oceania/) then continent = 'Oceania'
      end

      @country_array << [continent, country_name, country_link]
    end
    puts 'Initialization completed!'
  end

  # open the link and parse with Nokogiri gem
  private def open_link(link)
    doc = Nokogiri::HTML(open(link))
  end

  # List countries in a region that are prone to earthquakes
  def prone_earthquake(*input)
    # do a selection if user specifies the region
    if input.length == 1
      selected_1 = @country_array.select {|x| x[0] == input[0]}
    # by default search all regions
    else
      selected_1 = @country_array
    end

    # Find the place where the keyword might appear and attempt to match
    selected_2 = selected_1.select do |x|
      open_link(x[2]).css('div.category_data').any? {|y| y.text.match(/[Ee]arthquake|EARTHQUAKE/)}
    end

    return selected_2
  end

  # Find the country with the extreme elevation point in a region
  def find_elevation_extreme(*input)
    extreme_type = 'lowest' # by default set to lowest extreme
    selected_1 = @country_array # by default search all regions

    # if user only specifies high/low
    if input.length == 1
      extreme_type = input[0].downcase
    # if user specify both high/low and region
    elsif input.length == 2
      extreme_type = input[0].downcase
      selected_1 = @country_array.select {|x| x[0] == input[1].capitalize}
    end

    # [country_name, extreme point]
    extreme_point_array = []

    # search for elevation extreme for each country
    selected_1.each do |x|
      extreme_point = 0
      open_link(x[2]).css('tr td div.category').each do |y|
        if y.text.match(/#{extreme_type} point:/) # search for keyword
          value = y.text.match(/-?\d+,?\d*/)[0]
          if value.match(/,/) # get actual value if the number contain commas
            extreme_point = value.gsub(/,/,'.').to_f * 1000
          else
            extreme_point = value.to_f
          end
          extreme_point_array << [x[1], extreme_point] # [country_name, extreme point]
          break
        end
      end
    end

    extreme_value = 0
    # find min or max value based on extreme type
    if extreme_type == 'lowest'
      extreme_value = extreme_point_array.map {|x| x[1]}.min
    else
      extreme_value = extreme_point_array.max {|x| x[1]}.max
    end

    extreme_point_array.select! {|x| x[1] == extreme_value}
    return extreme_point_array
  end

  # Find the country in certain quarter of hemisphere
  def locate_hemisphere(*input)
    # by default search Southeastern hemisphere
    coordinate_1, coordinate_2 = 'S', 'E'

    # if only first coordinate is given
    if input.length == 1
      coordinate_1 = input[0].upcase
    # if both coordinates are given
    else if input.length == 2
      coordinate_1 = input[0].upcase
      coordinate_2 = input[1].upcase
    end

    selected = @country_array.select do |x|
      open_link(x[2]).css('div.category_data').text.match(/(\d{2} \d{2} )(#{coordinate_1})(,)( \d{2} \d{2} )(#{coordinate_2})/)
    end
    return selected
  end
  end

  # List countries in a region with more than a certain number of political parties
  def find_political_party(*input)
    selected_1 = @country_array
    min_parties = 0

    # if only region is given
    if input.length == 1
      selected_1 = @country_array.select {|x| x[0] == input[0].capitalize}
    # if both region and number of parties are given
    elsif input.length == 2
      selected_1 = @country_array.select {|x| x[0] == input[0].capitalize}
      min_parties = input[1]
    end

    country_party = [] # [country_name, number of parties]

    selected_1.each do |x|
      flag = 0
      num_parties = 0
      open_link(x[2]).css('tr td div').each do |y|
        # try to locate keyword
        if flag == 0
          flag = 1 if y.text.match(/Political parties and leaders/)
        # the next entries contain political parties
        else
          if y['class'] == 'category_data'
            if y.text.match(/(.*\s)(\d+)(\s)/)
            # special for case like Afghanistan where the total number is given directly
              num_parties = y.text.match(/(.*\s)(\d+)(\s)/)[2].to_i
              break
            end
            # otherwise, each entry stands for a party
            num_parties += 1
          else
            break # break if div class is no longer matched (next category)
          end
        end
      end
      # append to the array only if more than min_parties
      country_party << [x[1], num_parties] if num_parties > min_parties
    end
    return country_party
  end

  # Find the top number of countries with the highest energy consumption per capital
  def find_energy_consumption(*input)
    if input.length == 1
      num_top = input[0]
    else
    # by default, list top 10 countries
      num_top = 10
    end

    country_consumption = [] # [country_name, consumption_per_cap]
    @country_array.each do |x|
      flag_population = 0
      flag_consumption = 0
      consumption_per_cap = 0
      population = 0

      open_link(x[2]).css('tr td div').each do |y|

        if flag_population == 0
          # if keyword Population is found
          flag_population = 1 if y.text.match(/Population:/)
        elsif flag_population == 1
          if y['class'] == 'category_data'
            break if y.text.match(/^[^\d]/) # break if does not start with digit
            population = y.text.match(/(\d|,)+/)[0].gsub(/,/, '').to_f
            flag_population = 2 # population found so next time will pass this block
          end
        end

        if flag_consumption == 0
          # if keyword Electricity - consumption is found
          flag_consumption = 1 if y.text.match(/Electricity - consumption/)
        elsif flag_consumption == 1
          if y['class'] == 'category_data'
            consumption_temp = y.text.split(' ')
            # map letters to values
            unit = case consumption_temp[1]
              when 'trillion' then 10 ** 12
              when 'billion' then 10 ** 9
              when 'million' then 10 ** 6
              else 1
            end
            # get actual value
            consumption = consumption_temp[0].to_f * unit
            consumption_per_cap = (consumption / population).to_i
            # append to the array [country_name, consumption_per_cap]
            country_consumption << [x[1], consumption_per_cap]
            break
          end
        end
      end

    end
    # sort the array in descending order
    country_consumption.sort! { |a,b| b[1] <=> a[1] }
    # select only top num_top countries
    country_consumption = country_consumption[0, num_top]
    return country_consumption
  end

  # List religions of countries
  def find_religion(*input)
    upper_bound, lower_bound= 100, 0
    if input.length == 1
      upper_bound = input[0]
    elsif input.length == 2
      upper_bound = input[0]
      lower_bound = input[1]
    end

    country_religion = [] # [country_name, religions]

    @country_array.each do |x|
      flag = 0
      percent_dom_religion = 0
      open_link(x[2]).css('tr td div').each do |y|
        if flag == 0
          # if keyword Religions is found
          flag = 1 if y.text.match(/Religions:/)
        else

          if y['class'] == 'category_data'
            religions = y.text.split(', ')
            percent_dom_religion = religions[0].match(/\d+/)[0].to_i if religions[0].match(/\d+/)
            # if more than upper_bound, just append the dominant religion only
            if percent_dom_religion > upper_bound
              country_religion << [x[1], religions[0]]
            # if less than lower_bound, add append all religions
            elsif percent_dom_religion < lower_bound
              country_religion << [x[1], religions]
            end
          else
            break
          end
        end
      end
    end

    return country_religion
  end

  # Find the landlocked countries with certain number of neighbors
    def find_landlocked(*input)
    num_neighbors = 1 # by default set to 1
    num_neighbors = input[0] if input.length == 1 # if num of neighbors is given

    country_locked = [] # [country_name, num of neighbors]

    # firstly select the landlocked countries
    selected_1 = @country_array.select do |x|
      open_link(x[2]).css('tr td div.category_data').any? {|y| y.text.match(/[Ll]andlocked/)}
    end

    # then select those with certain num of neighbors
    selected_1.each do |x|
      num_border_countries = 0
      open_link(x[2]).css('tr td div.category').each do |y|
        if y.text.match(/border countries/)
          num_border_countries = y.text.scan('km').length
          country_locked << [x[1], num_border_countries] if num_border_countries == num_neighbors
          break
        end
      end

    end

    return country_locked
  end

  # Find the most densely populated country in a region (Wild Card)
  def find_dense_population(*input)
    # if region is given
    if input.length == 1
      selected_1 = @country_array.select {|x| x[0] == input[0].capitalize}
    # by default, search all countries
    else
      selected_1 = @country_array
    end

    country_density = [] # [country_name, pop_density]

    selected_1.each do |x|
      flag_area = 0
      flag_population = 0
      area = 0
      population = 0

      open_link(x[2]).css('tr td div').each do |y|
        if flag_area == 0
          # if keyword Area is matched
          flag_area = 1 if y.text.match(/Area:/)
        elsif flag_area == 1
          area = y.text.split(' ')[1].gsub(/,/, '').to_f
          flag_area = 2 # area is obtained so skip this condition next time
        end

        if flag_population == 0
          # if keyword Population is found
          flag_population = 1 if y.text.match(/Population:/)
        elsif flag_population == 1
          if y['class'] == 'category_data'
            break if y.text.match(/^[^\d]/) # break if does not start with digit
            population = y.text.match(/(\d|,)+/)[0].gsub(/,/, '').to_f
            pop_density = population / area
            country_density << [x[1], pop_density]
            break
          end
        end
      end
    end

    # find the highest population density
    max_value = country_density.map {|x| x[1]}.max
    country_density.select! {|x| x[1] == max_value}
    return country_density
  end

end

# main program starts here
world_fact = WorldFactBook.new

# question 1
# please enter ('region') as input
solution_1 = world_fact.prone_earthquake('South America')
puts 'Solution 1 is as follows:'
solution_1.each {|x| puts x[1]}

# question 2
# please enter ('lowest/highest', 'region')
solution_2 = world_fact.find_elevation_extreme('lowest', 'Europe')
puts "\nSolution 2 is as follows:"
solution_2.each {|x| puts x.to_s}

# question 3
# please enter ('coordinate_1', 'coordinate_2')
solution_3 = world_fact.locate_hemisphere('S', 'E')
puts "\nSolution 3 is as follows:"
solution_3.each {|x| puts x[1]}

# question 4
# please enter ('region', min_num_party)
solution_4 = world_fact.find_political_party('Asia', 10)
puts "\nSolution 4 is as follows:"
solution_4.each {|x| puts x.to_s}

# question 5
# please enter (num_top)
solution_5 = world_fact.find_energy_consumption(5)
puts "\nSolution 5 is as follows:"
solution_5 .each {|x| puts x.to_s}

# question 6
# please enter (upper_bound, lower_bound)
solution_6 = world_fact.find_religion(80, 50)
puts "\nSolution 6 is as follows:"
solution_6 .each {|x| puts x.to_s}

# question 7
# please enter (num_neighbors)
solution_7 = world_fact.find_landlocked(1)
puts "\nSolution 7 is as follows:"
solution_7 .each {|x| puts x.to_s}

# question 8 (wild card)
# please enter ('region')
solution_8 = world_fact.find_dense_population('Europe')
puts "\nSolution 8 is as follows:"
solution_8 .each {|x| puts x.to_s}

puts "\nDone!"
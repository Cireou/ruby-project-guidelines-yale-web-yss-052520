require_relative '../config/environment'
require_all 'app'

# Representative.destroy_all

PUBLICA_KEY = ENV['PRO_PUBLICA_KEY']
#google_key = ENV['GOOGLE_KEY']

REP_URL = 'https://api.propublica.org/congress/v1/116/house/members.json'
VOTE_URL = 'https://api.propublica.org/congress/v1/house/votes/2019-01-01/2020-06-09.json'



def populate_rep()
    response = generate_request(REP_URL, PUBLICA_KEY)
    members = response["results"][0]["members"]
    members.each{|member| 
        if member["in_office"]
            Representative.create(
                name: member["first_name"].concat(" " + member["last_name"]), 
                age: find_age(member["date_of_birth"]),
                experience: member["seniority"], 
                state: member["state"],
                district: member["district"], 
                party: member["party"], 
                next_election: member["next_election"],
                rep_id: member["id"]
            )
        end
    }
end

def populate_votes()
    
    
end


def find_age(dob_str)#dob: "YYYY-MM-DD"
    dob = Date._parse(dob_str)
    now = Time.now.utc.to_date
    now.year - dob[:year] - ((now.month > dob[:mon] || (now.month == dob[:mon] && now.day >= dob[:mday])) ? 0 : 1)
end

def generate_request(url, key = nil)
    key == nil ? HTTParty.get(url) : 
    HTTParty.get(url, :headers => {"X-Api-Key" => "#{key}"})
end
 
# populate_rep()
binding.pry
0

=begin

https://api.propublica.org/congress/{version}/
current congress = 116
https://api.propublica.org/congress/v1/
https://api.propublica.org/congress/v1/116/house/members.json
compare cosponsoring = GET https://api.propublica.org/congress/v1/members/{first-member-id}/bills/{second-member-id}/{congress}/{chamber}.json
member by district = GET https://api.propublica.org/congress/v1/members/{chamber}/{state}/{district}/current.json
Responses that are not date-based return the first 20 results; pagination is available via an offset query string parameter using multiples of 20 for most votes, 
nomination and bill requests that return more than one object.

=end
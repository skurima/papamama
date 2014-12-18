#! ruby

#convert urasoe-city-csv to geojson
#author: togawa manabu
#ver : 0.1


require 'csv'
require 'open-uri'
require 'json'

url = "http://www.city.urasoe.lg.jp/docs/2014111200059/file_contents/hoikusyoichiran.csv"

stringio = open(url, "r:cp932:UTF-8").read.encode("utf-8")
csv_obj = CSV.new(stringio)
rows = csv_obj.read

geojson = {
	"type" => "FeatureCollection",
	"crs" => {
		"type" => "name",
		"properties" => {
			"name" => "urn:ogc:def:crs:OGC:1.3:CRS84"
		}
	}
}

lines = []
for i in 2 .. rows.count - 1 
	row = rows[i]


	break if row.count < 15

	line = {"type" => "Feature", 
			"id" => i - 1,
			"properties" => {
				"HID" => 1000 + i - 1,  
				"Type" => "認可保育所",
				"Kodomo" => nil,
				"Name" => row[2],
				"Label" => row[2],
				"AgeS" => nil,
				"AgeE" => nil,
				"Full" => row[3],
				"Open" => row[8],
				"Close" => row[8],
				"Memo" => row[9],
				"Extra" => nil,
				"Temp" => nil,
				"Holiday" => nil,
				"Night" => nil,
				"Add1" => row[4],
				"Add2" => nil,
				"TEL" => row[7],
				"FAX" => nil,
				"Owner" => nil,
				"Ownership" => nil,
				"Proof" => nil,
				"Shanai" => nil,
				"Y" => row[5],
				"X" => row[6],
				"url" => row[14],
				"VacancyDate" => nil
			},
			"geometry" => {
				"type" => "Point",
				"coordinates" => [row[6], row[5]]
			}
	}

	lines << line
end

geojson["features"] = lines


#puts JSON.pretty_generate(geojson)
puts JSON.generate(geojson)



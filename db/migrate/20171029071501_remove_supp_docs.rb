class RemoveSuppDocs < ActiveRecord::Migration
  def up
    # only one amendment per protocol was being saved
    # this is fixed but not the supplemental documents that
    # exist for precincts with > 1 amendment need to be deleted
    # so they can be re-entered

    SupplementalDocument.transaction do
      # format: [election id, district id, precinct id]
      ids = [["14", "23", "51"], ["14", "23", "60"], ["14", "57", "21"], ["14", "52", "10"], ["14", "52", "21"], ["14", "44", "15"], ["14", "49", "12"], ["14", "49", "3"], ["14", "49", "23"], ["14", "83", "41"], ["14", "83", "1"], ["14", "83", "46"], ["14", "48", "9"], ["14", "48", "4"], ["14", "48", "27"], ["14", "28", "12"], ["14", "28", "53"], ["14", "28", "50"], ["14", "61", "22"], ["14", "25", "30"], ["14", "25", "26"], ["14", "30", "29"], ["14", "30", "36"], ["14", "35", "51"], ["14", "35", "47"], ["14", "35", "11"], ["14", "13", "29"], ["14", "13", "26"], ["14", "58", "45"], ["14", "58", "1"], ["14", "66", "7"], ["14", "45", "24"], ["14", "26", "34"], ["14", "26", "37"], ["14", "26", "11"], ["14", "26", "20"], ["14", "33", "1"], ["14", "56", "55"], ["14", "56", "3"], ["14", "56", "48"], ["14", "19", "20"], ["14", "39", "20"], ["14", "12", "22"], ["14", "22", "67"], ["14", "22", "25"], ["14", "22", "57"], ["14", "22", "61"], ["14", "43", "11"], ["14", "43", "8"], ["14", "64", "31"], ["14", "64", "13"], ["14", "64", "32"], ["14", "64", "7"], ["14", "64", "40"], ["14", "67", "30"], ["14", "67", "20"], ["14", "67", "75"], ["14", "67", "70"], ["14", "67", "45"], ["14", "67", "99"], ["14", "24", "40"], ["14", "24", "15"], ["14", "24", "23"], ["14", "24", "30"], ["14", "24", "13"], ["14", "24", "38"], ["14", "32", "42"], ["14", "32", "65"], ["14", "47", "27"], ["14", "47", "34"], ["14", "47", "29"], ["14", "60", "29"], ["14", "60", "31"], ["14", "60", "14"], ["14", "60", "54"], ["14", "82", "1"], ["14", "51", "40"], ["14", "16", "22"], ["14", "40", "50"], ["14", "40", "69"], ["14", "40", "17"], ["14", "40", "36"], ["14", "80", "11"], ["13", "23", "51"], ["13", "23", "43"], ["13", "23", "28"], ["13", "23", "23"], ["13", "23", "21"], ["13", "23", "7"], ["13", "23", "29"], ["13", "23", "42"], ["13", "23", "11"], ["13", "23", "13"], ["13", "23", "18"], ["13", "23", "55"], ["13", "23", "17"], ["13", "23", "16"], ["13", "23", "41"], ["13", "57", "21"], ["13", "8", "46"], ["13", "8", "15"], ["13", "8", "54"], ["13", "8", "49"], ["13", "8", "7"], ["13", "8", "53"], ["13", "2", "68"], ["13", "2", "28"], ["13", "2", "27"], ["13", "2", "7"], ["13", "2", "80"], ["13", "59", "124"], ["13", "59", "113"], ["13", "59", "12"], ["13", "59", "2"], ["13", "59", "4"], ["13", "59", "38"], ["13", "59", "35"], ["13", "59", "15"], ["13", "59", "9"], ["13", "59", "3"], ["13", "59", "62"], ["13", "59", "72"], ["13", "59", "29"], ["13", "59", "50"], ["13", "59", "44"], ["13", "59", "121"], ["13", "59", "95"], ["13", "6", "98"], ["13", "6", "83"], ["13", "6", "97"], ["13", "6", "71"], ["13", "6", "105"], ["13", "6", "41"], ["13", "6", "27"], ["13", "6", "94"], ["13", "6", "21"], ["13", "6", "106"], ["13", "41", "25"], ["13", "52", "10"], ["13", "52", "26"], ["13", "44", "16"], ["13", "44", "12"], ["13", "49", "12"], ["13", "1", "30"], ["13", "1", "29"], ["13", "1", "7"], ["13", "1", "31"], ["13", "1", "35"], ["13", "83", "1"], ["13", "83", "46"], ["13", "48", "24"], ["13", "48", "19"], ["13", "48", "9"], ["13", "48", "4"], ["13", "48", "27"], ["13", "48", "25"], ["13", "28", "12"], ["13", "28", "53"], ["13", "28", "50"], ["13", "61", "2"], ["13", "25", "26"], ["13", "30", "20"], ["13", "30", "36"], ["13", "30", "30"], ["13", "35", "43"], ["13", "35", "51"], ["13", "35", "21"], ["13", "7", "2"], ["13", "7", "16"], ["13", "7", "40"], ["13", "7", "23"], ["13", "13", "29"], ["13", "11", "23"], ["13", "11", "32"], ["13", "58", "45"], ["13", "50", "39"], ["13", "45", "24"], ["13", "26", "34"], ["13", "26", "22"], ["13", "26", "15"], ["13", "26", "37"], ["13", "26", "21"], ["13", "33", "17"], ["13", "33", "8"], ["13", "33", "1"], ["13", "56", "55"], ["13", "56", "3"], ["13", "56", "48"], ["13", "69", "12"], ["13", "69", "18"], ["13", "3", "66"], ["13", "3", "16"], ["13", "3", "14"], ["13", "3", "72"], ["13", "3", "33"], ["13", "3", "7"], ["13", "3", "65"], ["13", "3", "35"], ["13", "3", "85"], ["13", "3", "40"], ["13", "3", "67"], ["13", "3", "87"], ["13", "3", "37"], ["13", "3", "68"], ["13", "3", "21"], ["13", "3", "59"], ["13", "3", "5"], ["13", "39", "9"], ["13", "12", "22"], ["13", "22", "67"], ["13", "22", "6"], ["13", "22", "25"], ["13", "22", "62"], ["13", "43", "11"], ["13", "43", "8"], ["13", "29", "1"], ["13", "79", "11"], ["13", "79", "88"], ["13", "79", "14"], ["13", "64", "13"], ["13", "64", "32"], ["13", "64", "7"], ["13", "64", "40"], ["13", "67", "14"], ["13", "67", "30"], ["13", "67", "11"], ["13", "67", "58"], ["13", "67", "75"], ["13", "67", "70"], ["13", "67", "48"], ["13", "67", "38"], ["13", "67", "54"], ["13", "67", "45"], ["13", "67", "26"], ["13", "5", "57"], ["13", "5", "34"], ["13", "5", "54"], ["13", "5", "63"], ["13", "5", "30"], ["13", "5", "47"], ["13", "5", "76"], ["13", "5", "75"], ["13", "24", "40"], ["13", "24", "15"], ["13", "24", "23"], ["13", "24", "34"], ["13", "24", "5"], ["13", "24", "30"], ["13", "24", "4"], ["13", "24", "6"], ["13", "24", "22"], ["13", "24", "8"], ["13", "24", "3"], ["13", "24", "37"], ["13", "24", "38"], ["13", "10", "24"], ["13", "10", "83"], ["13", "10", "95"], ["13", "10", "91"], ["13", "10", "85"], ["13", "10", "86"], ["13", "10", "8"], ["13", "10", "59"], ["13", "32", "42"], ["13", "32", "77"], ["13", "27", "2"], ["13", "17", "52"], ["13", "47", "27"], ["13", "47", "30"], ["13", "47", "23"], ["13", "47", "29"], ["13", "60", "45"], ["13", "60", "29"], ["13", "60", "31"], ["13", "60", "60"], ["13", "60", "46"], ["13", "60", "54"], ["13", "60", "58"], ["13", "60", "38"], ["13", "82", "1"], ["13", "51", "40"], ["13", "51", "30"], ["13", "16", "24"], ["13", "16", "22"], ["13", "16", "13"], ["13", "9", "24"], ["13", "9", "74"], ["13", "40", "50"], ["13", "40", "21"], ["13", "40", "36"], ["13", "55", "25"], ["13", "21", "27"], ["13", "4", "11"], ["13", "4", "17"], ["13", "4", "15"], ["13", "4", "9"], ["13", "4", "1"], ["13", "4", "27"], ["13", "4", "30"], ["13", "4", "32"], ["13", "4", "12"], ["13", "4", "19"], ["11", "23", "51"], ["11", "23", "10"], ["11", "23", "48"], ["11", "70", "26"], ["11", "57", "21"], ["11", "8", "50"], ["11", "8", "19"], ["11", "8", "34"], ["11", "8", "48"], ["11", "8", "53"], ["11", "2", "49"], ["11", "2", "74"], ["11", "2", "68"], ["11", "2", "10"], ["11", "2", "23"], ["11", "59", "124"], ["11", "59", "12"], ["11", "59", "80"], ["11", "59", "120"], ["11", "59", "40"], ["11", "59", "121"], ["11", "59", "74"], ["11", "6", "50"], ["11", "6", "98"], ["11", "6", "83"], ["11", "6", "53"], ["11", "6", "78"], ["11", "6", "105"], ["11", "6", "74"], ["11", "6", "41"], ["11", "6", "27"], ["11", "6", "92"], ["11", "6", "14"], ["11", "20", "25"], ["11", "52", "10"], ["11", "52", "21"], ["11", "44", "16"], ["11", "49", "12"], ["11", "49", "31"], ["11", "49", "30"], ["11", "49", "29"], ["11", "1", "30"], ["11", "1", "23"], ["11", "1", "31"], ["11", "1", "35"], ["11", "83", "3"], ["11", "83", "13"], ["11", "83", "1"], ["11", "83", "46"], ["11", "48", "19"], ["11", "48", "16"], ["11", "48", "9"], ["11", "48", "28"], ["11", "48", "4"], ["11", "28", "12"], ["11", "28", "53"], ["11", "28", "50"], ["11", "25", "30"], ["11", "25", "18"], ["11", "25", "14"], ["11", "30", "28"], ["11", "30", "36"], ["11", "35", "7"], ["11", "35", "17"], ["11", "35", "11"], ["11", "7", "32"], ["11", "7", "23"], ["11", "13", "29"], ["11", "13", "4"], ["11", "11", "45"], ["11", "58", "45"], ["11", "58", "6"], ["11", "66", "4"], ["11", "50", "39"], ["11", "81", "63"], ["11", "45", "24"], ["11", "26", "34"], ["11", "26", "37"], ["11", "26", "38"], ["11", "26", "20"], ["11", "33", "1"], ["11", "56", "55"], ["11", "56", "3"], ["11", "56", "48"], ["11", "56", "50"], ["11", "69", "24"], ["11", "3", "43"], ["11", "3", "16"], ["11", "3", "72"], ["11", "3", "7"], ["11", "3", "65"], ["11", "3", "6"], ["11", "3", "40"], ["11", "3", "11"], ["11", "3", "88"], ["11", "3", "37"], ["11", "3", "68"], ["11", "3", "21"], ["11", "3", "48"], ["11", "3", "59"], ["11", "3", "5"], ["11", "39", "20"], ["11", "12", "2"], ["11", "12", "18"], ["11", "12", "22"], ["11", "22", "90"], ["11", "22", "7"], ["11", "22", "67"], ["11", "22", "25"], ["11", "22", "57"], ["11", "43", "11"], ["11", "43", "8"], ["11", "79", "83"], ["11", "79", "88"], ["11", "79", "14"], ["11", "54", "30"], ["11", "54", "36"], ["11", "64", "13"], ["11", "64", "32"], ["11", "64", "7"], ["11", "64", "40"], ["11", "67", "30"], ["11", "67", "75"], ["11", "67", "70"], ["11", "67", "16"], ["11", "67", "45"], ["11", "67", "102"], ["11", "5", "14"], ["11", "5", "34"], ["11", "5", "49"], ["11", "5", "63"], ["11", "5", "47"], ["11", "5", "76"], ["11", "24", "40"], ["11", "24", "23"], ["11", "24", "30"], ["11", "24", "4"], ["11", "24", "17"], ["11", "24", "25"], ["11", "24", "38"], ["11", "10", "83"], ["11", "10", "95"], ["11", "10", "91"], ["11", "10", "85"], ["11", "10", "107"], ["11", "10", "4"], ["11", "10", "59"], ["11", "10", "44"], ["11", "32", "42"], ["11", "32", "26"], ["11", "27", "40"], ["11", "47", "9"], ["11", "47", "27"], ["11", "47", "29"], ["11", "47", "5"], ["11", "60", "36"], ["11", "60", "29"], ["11", "60", "31"], ["11", "60", "1"], ["11", "60", "54"], ["11", "60", "25"], ["11", "60", "43"], ["11", "82", "1"], ["11", "51", "40"], ["11", "16", "24"], ["11", "16", "10"], ["11", "16", "1"], ["11", "9", "24"], ["11", "9", "28"], ["11", "36", "1"], ["11", "40", "41"], ["11", "40", "50"], ["11", "40", "36"], ["11", "4", "13"], ["11", "4", "14"], ["11", "4", "17"], ["11", "4", "8"], ["11", "4", "15"], ["11", "4", "16"], ["11", "4", "9"], ["11", "4", "1"], ["11", "4", "26"], ["11", "4", "27"], ["11", "4", "5"], ["11", "4", "32"], ["11", "4", "12"], ["11", "4", "19"], ["12", "70", "16"], ["12", "8", "2"], ["12", "8", "44"], ["12", "8", "30"], ["12", "2", "31"], ["12", "2", "7"], ["12", "2", "80"], ["12", "59", "87"], ["12", "59", "124"], ["12", "59", "12"], ["12", "59", "46"], ["12", "59", "54"], ["12", "59", "72"], ["12", "59", "110"], ["12", "59", "121"], ["12", "59", "27"], ["12", "6", "13"], ["12", "6", "98"], ["12", "6", "83"], ["12", "6", "71"], ["12", "6", "105"], ["12", "6", "41"], ["12", "6", "38"], ["12", "6", "27"], ["12", "6", "92"], ["12", "1", "30"], ["12", "1", "7"], ["12", "1", "31"], ["12", "1", "35"], ["12", "7", "40"], ["12", "7", "23"], ["12", "7", "1"], ["12", "3", "79"], ["12", "3", "16"], ["12", "3", "72"], ["12", "3", "7"], ["12", "3", "65"], ["12", "3", "42"], ["12", "3", "40"], ["12", "3", "68"], ["12", "3", "21"], ["12", "3", "59"], ["12", "3", "5"], ["12", "3", "90"], ["12", "79", "76"], ["12", "79", "30"], ["12", "79", "88"], ["12", "79", "14"], ["12", "5", "49"], ["12", "5", "63"], ["12", "5", "60"], ["12", "5", "76"], ["12", "5", "11"], ["12", "5", "25"], ["12", "10", "83"], ["12", "10", "95"], ["12", "10", "91"], ["12", "10", "85"], ["12", "10", "107"], ["12", "10", "21"], ["12", "10", "35"], ["12", "10", "59"], ["12", "9", "38"], ["12", "4", "14"], ["12", "4", "17"], ["12", "4", "15"], ["12", "4", "9"], ["12", "4", "4"], ["12", "4", "29"], ["12", "4", "27"], ["12", "4", "32"], ["12", "4", "12"], ["12", "4", "19"], ["12", "79", "29"], ["13", "57", "27"], ["11", "26", "22"], ["13", "6", "38"], ["12", "20", "27"], ["11", "13", "28"], ["11", "3", "27"]]

      ids.each_with_index do |id, index|
        puts "finished #{index} so far" if index%100 == 0

        dp = DistrictPrecinct.by_ids(id[0], id[1], id[2]).first

        if dp.present?
          dp.supplemental_documents.delete_all
        end

      end
    end
  end

  def down
    puts "do nothing"
  end
end
require 'ostruct'

module NxtBuilder
  module Benchmark
    FIXTURES = {
      catalog: OpenStruct.new({
        cd: [
          OpenStruct.new({
            title: "Empire Burlesque",
            artist: "Bob Dylan",
            country: "USA",
            company: "Columbia",
            price: 10.90,
            year: 1985,
          }),
          OpenStruct.new({
            title: "Hide your heart",
            artist: "Bonnie Tylor",
            country: "UK",
            company: "CBS Records",
            price: 9.90,
            year: 1988,
          }),
          OpenStruct.new({
            title: "Greatest Hits",
            artist: "Dolly Parton",
            country: "USA",
            company: "RCA",
            price: 9.90,
            year: 1982,
          }),
        ]
      })
    }
  end
end

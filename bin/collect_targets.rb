#!/usr/bin/env ruby

ARGF.each do |line|
  if line =~ /^resource "(.+)" "(.+)" {$/
    puts "-target=#{$1}.#{$2}"
  end
end

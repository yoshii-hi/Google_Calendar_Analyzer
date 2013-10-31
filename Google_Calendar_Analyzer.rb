# -*- coding: utf-8 -*-
require 'yaml'
require 'rubygems'
require 'google/api_client'
require File.dirname(__FILE__) + '/GCal'

class GCalAnalyzer
  def initialize(gcal=nil)
    @gcal = gcal
    @google_calendar_ids = YAML.load_file(File.dirname(__FILE__) + '/settings.yaml')["google_calendar_ids"]
  end

  # 作成日と実施日の差を調べる．
  def analyze_of_association_between_start_time_and_created_time
    difference_start_betweent_created = []
    @google_calendar_ids.each do |google_calendar_id|
      event_list = @gcal.event_list(google_calendar_id)

      event_list.each do |ev|
        if ev.start == nil
        elsif ev.start.date_time == nil
          difference_start_betweent_created << (Date.parse(ev.start.date) - ev.created.localtime.to_date).to_i.round(2)
          #print_data(ev.summary, ev.start, ev.created.localtime.to_date, Date.parse(ev.start.date) - ev.created.localtime.to_date).to_i.round(2))
        else
          difference_start_betweent_created << (ev.start.date_time.to_date - ev.created.localtime.to_date).to_i.round(2)
          #print_data(ev.summary, ev.start.date_time.to_date, ev.created.localtime.to_date, ev.start.date_time.to_date - ev.created.localtime.to_date).to_i.round(2))
        end
      end
    end
    export_difference_start_betweent_created_to_txt(difference_start_betweent_created)
  end

  def export_difference_start_betweent_created_to_txt(data)
    open(File.dirname(__FILE__) + '/data/data.txt', "w") do |f|
      data.each do |d|
        f.write(d)
        f.write("\n")
      end
      f.close
    end
  end

  def print_data(summary, start, created, difference_start_betweent_created)
    print "| #{summary} | #{start.date} | #{created} | #{difference_start_between_created} |\n"
  end

end

gcal = GCal.new('AnalysisOfGCal')
gcal_analyzer = GCalAnalyzer.new(gcal)
gcal_analyzer.analyze_of_association_between_start_time_and_created_time

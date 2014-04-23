require 'spec_helper'
require 'sidekiq/testing'

describe 'Pinging' do
  it do
    stub_request :get, "http://example.com/"

    visit '/'
    click_link 'Add URL'
    fill_in 'Title', :with => 'TITLE'
    fill_in 'URL', :with => 'http://example.com/'
    fill_in 'Seconds', :with => 600
    click_on 'Add URL'

    freeze_time Time.now

    visit current_url

    expect(page).to have_content 'Next ping in 10 minutes.'
    expect(page).to have_content 'No pings yet'

    freeze_time 7.minutes.from_now
    visit current_url

    expect(page).to have_content 'Next ping in 3 minutes.'
    expect(page).to have_content 'No pings yet'

    freeze_time 5.minutes.from_now
    visit current_url

    expect(page).to have_content 'Next ping in 8 minutes.'
    expect(all('.ping').size).to eq 1

    freeze_time 6.minutes.from_now
    visit current_url

    expect(page).to have_content 'Next ping in 2 minutes.'
    expect(all('.ping').size).to eq 1
  end

  def saop
    save_and_open_page
  end

  def freeze_time(time)
    if job = PingWorker.jobs.shift
      if job['at'] <= time.to_f
        Timecop.freeze Time.at(job['at'])
        worker = PingWorker.new
        worker.jid = job['jid']
        worker.perform(*job['args'])
      else
        PingWorker.jobs.unshift job
      end
    end

    Timecop.freeze time
    APP.schedule_pings!
  end
end
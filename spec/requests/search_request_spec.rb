require 'rails_helper'

RSpec.describe "Search", type: :request do
  let!(:sorn) { create :sorn }
  let(:search) { nil }
  let(:fields) { nil }
  let(:agency) { nil }

  before { get "/search?search=#{search}&#{fields}&#{agency}" }

  context "/search" do
    it "succeeds" do
      expect(response.successful?).to be_truthy
    end

    it "returns eveything with the default columns" do
      expect(response.body).to include sorn.system_name
      expect(response.body).to include sorn.agencies.first.name
      expect(response.body).to include sorn.action
      expect(response.body).to include sorn.publication_date
      expect(response.body).to include sorn.citation
      expect(response.body).to include sorn.html_url
    end

    it "no search result summaries" do
      expect(response.body).not_to include 'FOUND IN'
    end
  end

  context "search with agency select" do
    let(:search) { "FAKE" }
    let(:fields) { 'fields[]=action' }
    let(:agency) { "agency=FAKE+AGENCIES" }

    it "succeeds" do
      expect(response.successful?).to be_truthy
    end

    it "agencies accordian is open" do
      expect(response.body).to include '<button class="usa-accordion__button" aria-expanded="true" aria-controls="a1" type="button">Agencies</button>'
    end

    it "default agency set" do
      expect(response.body).to include 'data-default-value="FAKE AGENCIES"'
    end

    it "with search result summaries" do
      expect(response.body).to include 'FOUND IN'
      expect(response.body).to include "<div class='sorn-attribute-header'>Action</div>"
      expect(response.body).to include "<div class='found-section-snippet'><mark>FAKE</mark> ACTION</div>"
    end
  end

  context "search without agency select" do
    let(:search) { "FAKE" }
    let(:fields) { 'fields[]=action' }
    let(:agency) { nil }

    it "succeeds" do
      expect(response.successful?).to be_truthy
    end

    it "agencies accordian is closed" do
      expect(response.body).to include '<button class="usa-accordion__button" aria-expanded="false" aria-controls="a1" type="button">Agencies</button>'
    end

    it "no default agency selected" do
      expect(response.body).to include 'data-default-value=""'
    end

    it "with search result summaries" do
      expect(response.body).to include 'FOUND IN'
      expect(response.body).to include "<div class='sorn-attribute-header'>Action</div>"
      expect(response.body).to include "<div class='found-section-snippet'><mark>FAKE</mark> ACTION</div>"
    end
  end

  context "search with default columns" do
    let(:search) { "FAKE" }
    let(:fields) { "fields%5B%5D=agency_names&fields%5B%5D=action&fields%5B%5D=summary&fields%5B%5D=system_name&fields%5B%5D=html_url&fields%5B%5D=publication_date" }

    it "succeeds" do
      expect(response.successful?).to be_truthy
    end

    it "returns found results with default columns" do
      # default fields
      expect(response.body).to include "FAKE SYSTEM NAME"
      expect(response.body).to include 'FAKE AGENCIES'
      expect(response.body).to include "HTML URL"
      expect(response.body).to include "2000-01-13"
    end

    it "with search result summaries" do
      expect(response.body).to include 'FOUND IN'
      expect(response.body).to include "<div class='sorn-attribute-header'>Agency names</div>"
      expect(response.body).to include "<div class='found-section-snippet'>[\"<mark>FAKE</mark> AGENCY NAMES\"]</div>"
      expect(response.body).to include "<div class='sorn-attribute-header'>Action</div>"
      expect(response.body).to include "<div class='found-section-snippet'><mark>FAKE</mark> ACTION</div>"
      expect(response.body).to include "<div class='sorn-attribute-header'>Summary</div>"
      expect(response.body).to include "<div class='found-section-snippet'><mark>FAKE</mark> SUMMARY</div>"
      expect(response.body).to include "<div class='sorn-attribute-header'>System name</div>"
      expect(response.body).to include "<div class='found-section-snippet'><mark>FAKE</mark> SYSTEM NAME</div>"
    end
  end

  context "search with different columns" do
    let(:search) { "citation" }
    let(:fields) { "fields%5B%5D=citation" }

    it "succeeds" do
      expect(response.successful?).to be_truthy
    end

    it "with search result summaries" do
      expect(response.body).to include 'FOUND IN'
      expect(response.body).to include "<div class='sorn-attribute-header'>Citation</div>"
      expect(response.body).to include "<div class='found-section-snippet'><mark>citation</mark></div>"
    end
  end

  context "blank search, with different columns" do
    let(:search) { nil }
    let(:fields) { "fields%5B%5D=citation" }

    it "succeeds" do
      expect(response.successful?).to be_truthy
    end
  end

  context "publication date search" do
    before { create :sorn, publication_date: "2019-01-13", citation: "different citation" }

    it "only returns the newer sorn in date range" do
      get "/search?starting_date_month=01&starting_date_day=01&starting_date_year=2019"

      expect(response.body).to include "2019-01-13" # Newer sorn date
      expect(response.body).not_to include "2000-01-13" # Older sorn date
    end

    it "only returns the older sorn in date range" do
      get "/search?ending_date_month=12&ending_date_day=31&ending_date_year=2000"

      expect(response.body).to include "2000-01-13" # Older sorn date
      expect(response.body).not_to include "2019-01-13" # Newer sorn date
    end
  end
end

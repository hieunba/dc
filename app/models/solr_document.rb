# frozen_string_literal: true
class SolrDocument
  include Blacklight::Solr::Document
  include Blacklight::Gallery::OpenseadragonSolrDocument
  include MetadataIndexTerms
  include CharacterizationIndexTerms

  # Adds CurationConcerns behaviors to the SolrDocument.
  include CurationConcerns::SolrDocumentBehavior
  # Adds Sufia behaviors to the SolrDocument.
  include Sufia::SolrDocumentBehavior

  # Add OAI-PMH provider extension
  include BlacklightOaiProvider::SolrDocumentBehavior

  # self.unique_key = 'id'

  field_semantics.merge!(contributor: Solrizer.solr_name('contributor'),
                         coverage:    Solrizer.solr_name('spatial'),
                         creator:     Solrizer.solr_name('creator'),
                         date:        Solrizer.solr_name('date_created'),
                         description: Solrizer.solr_name('description'),
                         format:      Solrizer.solr_name('format'),
                         identifier:  Solrizer.solr_name('identifier'),
                         language:    Solrizer.solr_name('language'),
                         publisher:   Solrizer.solr_name('publisher'),
                         rights:      Solrizer.solr_name('rights'),
                         source:      Solrizer.solr_name('source'),
                         subject:     Solrizer.solr_name('subject'),
                         title:       Solrizer.solr_name('title'),
                         type:        Solrizer.solr_name('resource_type'))

  # Override image mime types to include 'application/octet-stream'
  def self.image_mime_types
    ['image/png', 'image/jpeg', 'image/jpg', 'image/jp2', 'image/bmp', 'image/gif', 'image/tiff', "application/octet-stream"]
  end

  # Email uses the semantic field mappings below to generate the body of an email.
  use_extension Blacklight::Document::Email

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  use_extension Blacklight::Document::Sms

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension Blacklight::Document::DublinCore

  # Do content negotiation for AF models.
  use_extension Hydra::ContentNegotiation

  def self.timestamp_field
    'system_modified_dtsi'
  end
end

(function() {
  "use strict";

  // Load Google Analytics libraries
  GOVUK.Tracker.load();

  // Use document.domain in dev, preview and staging so that tracking works
  // Otherwise explicitly set the domain as www.gov.uk (and not gov.uk).
  var cookieDomain = (document.domain === 'www.gov.uk') ? '.www.gov.uk' : document.domain;

  // Configure profiles and make interface public
  // for custom dimensions, virtual pageviews and events
  GOVUK.analytics = new GOVUK.Tracker({
    universalId: 'UA-26179049-1',
    cookieDomain: cookieDomain
  });

  var $section = $('head meta[name="govuk:section"]'),
      $needIds = $('head meta[name="govuk:need-ids"]');

  // Set custom dimensions before tracking pageviews
  if ($section) {
    GOVUK.analytics.setDimension(1, $section.attr('content'), 'Section');
  }

  if ($needIds) {
    GOVUK.analytics.setDimension(3, $needIds.attr('content'), 'NeedID');
  }

  GOVUK.analytics.setDimension(2, 'custom-tool', 'Format');
  if (window.devicePixelRatio) {
    GOVUK.analytics.setDimension(11, window.devicePixelRatio, 'Pixel Ratio', 2);
  }

  // Activate any event plugins eg. print intent, error tracking
  GOVUK.analyticsPlugins.error();
  GOVUK.analyticsPlugins.printIntent();

  // Track initial pageview
  GOVUK.analytics.trackPageview();
})();

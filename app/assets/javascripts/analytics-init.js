(function() {
  "use strict";

  // Load Google Analytics libraries
  GOVUK.Analytics.load();

  var cookieDomain = (document.domain === 'www.gov.uk') ? '.www.gov.uk' : document.domain;

  // Configure profiles and make interface public
  // for custom dimensions, virtual pageviews and events
  GOVUK.analytics = new GOVUK.Analytics({
    universalId: 'UA-97208357-1',
    cookieDomain: cookieDomain
  });

  // Activate any event plugins eg. print intent, error tracking
  GOVUK.analyticsPlugins.error();
  GOVUK.analyticsPlugins.printIntent();

  // Track initial pageview
  GOVUK.analytics.trackPageview();
})();

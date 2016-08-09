var TariffBreadcrumbs = (function() {
  var fullTree = $('.js-tariff-breadcrumbs .js-full-tree');
  var summaryTree = $('.js-tariff-breadcrumbs .js-summary-tree');
  var showBtn = $('.js-tariff-breadcrumbs .js-show-full-tree-btn');

  return {
    init: function() {
      this.hideTree();
      showBtn.click(function() {
        TariffBreadcrumbs.showTree();
      });
    },
    hideTree: function() {
      fullTree.hide();
      summaryTree.show();
    },
    showTree: function() {
      fullTree.show();
      summaryTree.hide();
    }
  }
})();

TariffBreadcrumbs.init();
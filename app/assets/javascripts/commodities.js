var loadExportMeasures, loadImportMeasures, loadMeasures;

loadMeasures = function() {
  var e_objectId, e_type, i_objectId, i_type, measures;
  measures = $("#measures-js").length !== 0;
  if (measures) {
    i_objectId = $("#import-measures").attr("data-id");
    i_type = $("#import-measures").attr("data-class");
    loadImportMeasures(i_objectId, i_type);
    e_objectId = $("#export-measures").attr("data-id");
    e_type = $("#export-measures").attr("data-class");
    loadExportMeasures(e_objectId, e_type);
    return true;
  }
};

loadImportMeasures = function(oid, type) {
  return $.ajax({
    type: 'GET',
    headers: {
      'X-AJAX': true
    },
    url: "/" + type + "/" + oid + "/import_measures",
    success: function(data) {
      return $("#import-measures").append(data);
    },
    error: function(data) {
      return console.log(':(');
    }
  });
};

loadExportMeasures = function(oid, type) {
  return $.ajax({
    type: 'GET',
    headers: {
      'X-AJAX': true
    },
    url: "/" + type + "/" + oid + "/export_measures",
    success: function(data) {
      return $("#export-measures").append(data);
    },
    error: function(data) {
      return console.log(':(');
    }
  });
};

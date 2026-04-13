// The available statuses defined in your Cloud Functions
final List<String> workflowStatuses = [
  'Pending',
  'In Progress',
  'Ready',
  'Given Out to Delivery'
];
// Users can toggle these to filter the view
final List<String> selectedStatuses = ['Pending', 'In Progress', 'Ready'];
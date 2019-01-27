# MultipleContextCoreDataExample

Simple Demo of how you can use multiple contexts in core data to process data on private queue.<br />
Data processing can be CPU-intensive, and if it is performed on the main queue, it can result in unresponsiveness in the user interface.<br /> If your application will be processing data, such as importing data into Core Data from JSON, create a private queue context and perform the import on the private context


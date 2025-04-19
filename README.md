# InputViewDemo
This project demonstrates the implementation of a simple form in iOS with a custom input view and validation mechanism. It includes a table view with text fields, where each field has validation rules, floating labels, and custom error messages. The form is designed to capture user information, including name, email, phone, address, and company.

# Features
- Custom floating label input view with error messages.
- Table view-based form structure.
- Text field validation with custom error messages.
- Toolbar with "Previous", "Next", and "Done" buttons for text field navigation.
- Simple submit button to handle form submission.
- Reusable components for easy integration.

# Components
### ViewController.swift
The main view controller of the app, responsible for handling the form's structure, validation, and form submission.

`TableView:` Displays the form fields.

`Fields:` The form contains multiple fields represented by an array of FormField objects.

`FormFieldType Enum:` Defines different field types such as fullName, email, phone, address, and company.

`Toolbar:` Custom toolbar with "Previous", "Next", and "Done" buttons to navigate between text fields.

### Key Functions:
`setupTableView():` Configures the table view and its constraints.

`createToolbar(for:):` Creates a custom toolbar for navigating through text fields.

`submitTapped():` Handles form submission, validates input, and prints form data.

### CustomInputCell.swift
A custom table view cell that includes a FloatingInputView for each text field. The cell manages the presentation of the input field, including the floating label and error messages.

### Key Functions:
`configure(placeholder:isRequired:text:error:):` Configures the text field's properties, such as the placeholder, required status, text, and error message.

### FloatingInputView.swift
A custom input view used in each form cell. It contains a text field, a floating label, and an error message label. The floating label animates up when the user starts typing.

### Key Functions:
`updatePlaceholder():` Updates the floating label text and adjusts the placeholder based on the isRequired flag.

`updateErrorUI():` Displays the error message and changes the border color if the text field contains an error.

`animateLabelUp():` Animates the floating label to move up when the user starts typing.

`animateLabelDown():` Animates the floating label to move down if the text field is empty.

### FormField.swift
Contains utility structures and enums:

`FormField:` Represents a single form field, including its type, text, error message, and required status.

`FormFieldType Enum:` Defines the possible types of form fields (e.g., fullName, email, etc.) and provides a placeholder for each type.

### Form Validation
The form uses simple validation to ensure required fields are filled and the email follows a valid format. The following checks are implemented:

`Required Fields:` If a required field is empty, an error message is displayed below the field.

`Email Validation:` If the email is not in a valid format, an error message is displayed.

`Error Handling:` If any field has an error, the form will not be submitted until all errors are resolved.

### Custom Input View
The custom input view (FloatingInputView) features a floating label that animates when the user starts typing, making the placeholder text float above the input field. The text field also supports dynamic error messages below the field when validation fails.

### Text Field Navigation
A custom toolbar is added to the text fields with buttons that allow the user to easily navigate between fields:

`Previous:` Moves to the previous text field.

`Next:` Moves to the next text field.

`Done:` Dismisses the keyboard.

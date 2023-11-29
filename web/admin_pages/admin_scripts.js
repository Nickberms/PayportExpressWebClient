function LettersOnly(inputField) {
    // Regular expression to allow only letters and a single space
    var pattern = /^[A-Za-z]+( [A-Za-z]+)*$/;
    var inputValue = inputField.value;
    if (!pattern.test(inputValue)) {
        // Remove non-alphabet characters and extra spaces
        inputField.value = inputValue.replace(/[^A-Za-z\s]/g, '').replace(/\s{2,}/g, ' ');
    }
}
function NumbersOnly(inputField) {
    // Regular expression to allow only numbers
    var pattern = /^[0-9]+$/;
    var inputValue = inputField.value;
    if (!pattern.test(inputValue)) {
        // Remove non-number characters
        inputField.value = inputValue.replace(/[^0-9]/g, '');
    }
}
function AmountOnly(inputField) {
    var inputValue = inputField.value;
    // Remove any extra periods
    var cleanedValue = inputValue.replace(/(\.\d*)\./, '$1');
    // Regular expression to allow numbers with one decimal point
    var pattern = /^\d*\.?\d*$/;
    if (!pattern.test(cleanedValue)) {
        // Remove non-number or extra decimal characters
        cleanedValue = cleanedValue.replace(/[^0-9.]/g, '');
    }
    // Set the cleaned value back in the input field
    inputField.value = cleanedValue;
}
function EmailOnly(inputField) {
    // Regular expression to allow only email address characters
    var pattern = /^[a-z0-9@.]*$/;
    var inputValue = inputField.value;
    if (!pattern.test(inputValue)) {
        // Remove invalid characters
        inputField.value = inputValue.replace(/[^a-z0-9@.]/g, '');
    }
}
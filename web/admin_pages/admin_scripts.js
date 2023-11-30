function LettersOnly(inputField) {
    var pattern = /^[A-Za-z]+( [A-Za-z]+)*$/;
    var inputValue = inputField.value;
    if (!pattern.test(inputValue)) {
        inputField.value = inputValue.replace(/[^A-Za-z\s]/g, '').replace(/\s{2,}/g, ' ');
    }
}
function NumbersOnly(inputField) {
    var pattern = /^[0-9]+$/;
    var inputValue = inputField.value;
    if (!pattern.test(inputValue)) {
        inputField.value = inputValue.replace(/[^0-9]/g, '');
    }
}
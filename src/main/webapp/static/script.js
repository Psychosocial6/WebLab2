document.addEventListener("DOMContentLoaded", () => {
    const apiUrl = `${contextPath}/api`;
    const check_button = document.getElementById("button");
    const clear_button = document.getElementById("clear");
    const text_field = document.getElementById("Ytext");

    const image = document.getElementById('image');
    const container = document.querySelector('.x-button-container');
    const buttons = document.querySelectorAll('button');
    let x_value = 0;

    text_field.addEventListener("input", () => {
       validate(text_field.value);
    });

    container.addEventListener('click', function(event) {
        if (event.target.tagName === 'BUTTON') {
            const clickedButton = event.target;
            buttons.forEach(button => {
                button.classList.remove('active-button');
            });

            clickedButton.classList.add('active-button');

            x_value = clickedButton.textContent;
        }
    });


    function clearServerTable() {
        fetch(apiUrl, {
            method: 'DELETE',
            headers: {
                'Accept': 'application/json',
            }
        })
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            const table_body = document.getElementById('table-body');
            table_body.innerHTML = '';
            return response;
        })
        .catch(error => {
            console.error('Ошибка при очистке данных:', error);
        });
    }

    function validate(value) {
        const val = value.trim().replace(',', '.');

        if (val === "") {
            check_button.disabled = true;
            text_field.setCustomValidity("Число не введено");
            text_field.reportValidity();
            return;
        }

        const re = /^-?((\d+\.\d+)|(\d+)|(\.\d+))$/;
        if (!re.test(val)) {
            text_field.setCustomValidity("Введено не число");
            check_button.disabled = true;
            text_field.reportValidity();
            return;
        }

        const negativeOutOfBoundsRe = /^-([6-9]|\d{2,}|5\.\d*[1-9])/;
        const positiveOutOfBoundsRe = /^([4-9]|\d{2,}|3\.\d*[1-9])/;
        let isOutOfBounds = false;
        if (val.startsWith('-')) {
            if (negativeOutOfBoundsRe.test(val)) {
                isOutOfBounds = true;
            }
        }
        else {
            if (positiveOutOfBoundsRe.test(val)) {
                isOutOfBounds = true;
            }
        }
        if (isOutOfBounds) {
            text_field.setCustomValidity("Число не входит в диапазон");
            check_button.disabled = true;
            text_field.reportValidity();
            return;
        }

        text_field.setCustomValidity("");
        check_button.disabled = false;

        const num = parseFloat(val);

        if (num <= 3 && num >= -5) {
            text_field.setCustomValidity("");
            check_button.disabled = false;
            text_field.reportValidity();
        }

        else {
            text_field.setCustomValidity("Число не входит в диапазон");
            check_button.disabled = true;
            text_field.reportValidity();
        }
    }

    function sendRequest(url, requestData) {
        const params = new URLSearchParams(requestData);
        const fullUrl = `${url}?${params.toString()}`;
        return fetch(fullUrl, {
            method: 'GET'
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`Ошибка запроса: ${response.status}`);
                }
                return response.text();
            })
            .then(newTableHtml => {
                const currentTableBlock = document.querySelector('.table-block');
                if (currentTableBlock) {
                    currentTableBlock.outerHTML = newTableHtml;
                } else {
                    console.error('table error');
                }
                return newTableHtml;
            })
            .catch(error => {
                console.error('Произошла ошибка:', error);
                throw error;
            });
    }

    function image_click(event) {
        const r_radio = document.querySelector('input[name="R"]:checked');
        const r_value = parseFloat(r_radio.value);

        const svg = event.currentTarget;
        const rect = svg.getBoundingClientRect();

        const svgX = event.clientX - rect.left;
        const svgY = event.clientY - rect.top;

        const centerX = rect.width / 2;
        const centerY = rect.height / 2;

        const scale = rect.width * (150 / 400);

        const mathX = ((svgX - centerX) / scale) * r_value;
        const mathY = ((-(svgY - centerY)) / scale) * r_value;

        const requestData = {
            x: Math.round(mathX),
            y: mathY,
            r: r_value
        };
        const params = new URLSearchParams(requestData);
        const fullUrl = `${apiUrl}?${params.toString()}`;
        fetch(fullUrl, {
            method: 'GET'
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`Ошибка запроса: ${response.status}`);
                }
                return response.text();
            })
            .then(newTableHtml => {
                const currentTableBlock = document.querySelector('.table-block');
                if (currentTableBlock) {
                    currentTableBlock.outerHTML = newTableHtml;
                } else {
                    console.error('table error');
                }
            })
            .catch(error => {
                console.error('Error: ', error);
            });
    }

    async function button_click() {
        let y_value = text_field.value;
        const r_radio = document.querySelector('input[name="R"]:checked');
        let r_value = r_radio.value;

        const data = { x: x_value, y: y_value, r: r_value };

        sendRequest(apiUrl, data)
            .then(result => {
                console.log("Ответ от сервера:", result);
            })
            .catch(error => {
                console.error("Произошла ошибка:", error);
            });
    }

    function clear_click() {
        let clear = confirm("Вы уверены, что хотите отчистить таблицу?")

        if (clear) {
            clearServerTable();
        }
    }

    clear_button.addEventListener("click", clear_click);
    check_button.addEventListener("click", button_click);
    image.addEventListener("click", image_click);
});
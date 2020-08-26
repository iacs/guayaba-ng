function filterName() {
    var box = document.querySelector('input.filter');
    var filterStr = box.value.toUpperCase();
    var table = document.querySelector('table');
    var trs = table.getElementsByTagName('tr');

    for (tr of trs) {
        td = tr.getElementsByTagName('td')[0];
        if (td) {
            let txtval = td.textContent || td.innerText;
            if (txtval.toUpperCase().indexOf(filterStr) > -1) {
                tr.style.display = '';
            } else {
                tr.style.display = 'none';
            }
        }
    };
}
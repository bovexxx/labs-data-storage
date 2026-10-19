//  БД: avtosalon — отдел продаж автосалона (ЛР3, MongoDB)
//  Вариант 9. Коллекции соответствуют таблицам из ЛР1 (3НФ).
//  MongoDB 4.4+ / mongosh (вкладка MONGOSH в MongoDB Compass)

use("avtosalon")

// ========== 1. MARKA ==========
db.marka.insertMany([
  { _id: 1, nazvanie: "Toyota", strana: "Япония" },
  { _id: 2, nazvanie: "Kia", strana: "Южная Корея" },
  { _id: 3, nazvanie: "Hyundai", strana: "Южная Корея" },
  { _id: 4, nazvanie: "Lada", strana: "Россия" },
  { _id: 5, nazvanie: "Haval", strana: "Китай" },
  { _id: 6, nazvanie: "Chery", strana: "Китай" },
  { _id: 7, nazvanie: "Geely", strana: "Китай" },
  { _id: 8, nazvanie: "Volkswagen", strana: "Германия" },
  { _id: 9, nazvanie: "Skoda", strana: "Чехия" },
  { _id: 10, nazvanie: "BMW", strana: "Германия" }
])

// ========== 2. TIP_KUZOVA ==========
db.tip_kuzova.insertMany([
  { _id: 1, nazvanie: "Седан" },
  { _id: 2, nazvanie: "Хэтчбек" },
  { _id: 3, nazvanie: "Универсал" },
  { _id: 4, nazvanie: "Кроссовер" },
  { _id: 5, nazvanie: "Внедорожник" },
  { _id: 6, nazvanie: "Лифтбек" },
  { _id: 7, nazvanie: "Минивэн" },
  { _id: 8, nazvanie: "Купе" },
  { _id: 9, nazvanie: "Пикап" },
  { _id: 10, nazvanie: "Кабриолет" }
])

// ========== 3. MODEL ==========
db.model.insertMany([
  { _id: 1, nazvanie: "Camry", marka_id: 1, tip_kuzova_id: 1, pokolenie: "XV80" },
  { _id: 2, nazvanie: "RAV4", marka_id: 1, tip_kuzova_id: 4, pokolenie: "XA50" },
  { _id: 3, nazvanie: "Sportage", marka_id: 2, tip_kuzova_id: 4, pokolenie: "NQ5" },
  { _id: 4, nazvanie: "Rio", marka_id: 2, tip_kuzova_id: 1, pokolenie: "FB" },
  { _id: 5, nazvanie: "Creta", marka_id: 3, tip_kuzova_id: 4, pokolenie: "SU2" },
  { _id: 6, nazvanie: "Vesta", marka_id: 4, tip_kuzova_id: 1, pokolenie: "NG" },
  { _id: 7, nazvanie: "Jolion", marka_id: 5, tip_kuzova_id: 4, pokolenie: "I" },
  { _id: 8, nazvanie: "Tiggo 7 Pro", marka_id: 6, tip_kuzova_id: 4, pokolenie: "I" },
  { _id: 9, nazvanie: "Monjaro", marka_id: 7, tip_kuzova_id: 4, pokolenie: "KX11" },
  { _id: 10, nazvanie: "Octavia", marka_id: 9, tip_kuzova_id: 6, pokolenie: "A8" }
])

// ========== 4. KOMPLEKTATSIYA ==========
db.komplektatsiya.insertMany([
  { _id: 1, model_id: 1, nazvanie: "Comfort", obem_dvigatelya: 2.0, moshchnost_ls: 150, tip_topliva: "benzin", korobka: "variator", privod: "peredniy", bazovaya_tsena: 3900000 },
  { _id: 2, model_id: 1, nazvanie: "Prestige", obem_dvigatelya: 2.5, moshchnost_ls: 200, tip_topliva: "benzin", korobka: "AKPP", privod: "peredniy", bazovaya_tsena: 4600000 },
  { _id: 3, model_id: 2, nazvanie: "Style", obem_dvigatelya: 2.0, moshchnost_ls: 149, tip_topliva: "benzin", korobka: "variator", privod: "polnyy", bazovaya_tsena: 4100000 },
  { _id: 4, model_id: 3, nazvanie: "Luxe", obem_dvigatelya: 2.0, moshchnost_ls: 150, tip_topliva: "benzin", korobka: "AKPP", privod: "polnyy", bazovaya_tsena: 3450000 },
  { _id: 5, model_id: 4, nazvanie: "Comfort", obem_dvigatelya: 1.6, moshchnost_ls: 123, tip_topliva: "benzin", korobka: "AKPP", privod: "peredniy", bazovaya_tsena: 1950000 },
  { _id: 6, model_id: 5, nazvanie: "Family", obem_dvigatelya: 1.6, moshchnost_ls: 123, tip_topliva: "benzin", korobka: "AKPP", privod: "peredniy", bazovaya_tsena: 2250000 },
  { _id: 7, model_id: 6, nazvanie: "Enjoy", obem_dvigatelya: 1.6, moshchnost_ls: 106, tip_topliva: "benzin", korobka: "MKPP", privod: "peredniy", bazovaya_tsena: 1450000 },
  { _id: 8, model_id: 6, nazvanie: "Techno", obem_dvigatelya: 1.8, moshchnost_ls: 122, tip_topliva: "benzin", korobka: "variator", privod: "peredniy", bazovaya_tsena: 1780000 },
  { _id: 9, model_id: 7, nazvanie: "Elite", obem_dvigatelya: 1.5, moshchnost_ls: 143, tip_topliva: "benzin", korobka: "robot", privod: "peredniy", bazovaya_tsena: 2350000 },
  { _id: 10, model_id: 8, nazvanie: "Prestige", obem_dvigatelya: 1.6, moshchnost_ls: 150, tip_topliva: "benzin", korobka: "robot", privod: "polnyy", bazovaya_tsena: 2700000 },
  { _id: 11, model_id: 9, nazvanie: "Flagship", obem_dvigatelya: 2.0, moshchnost_ls: 238, tip_topliva: "benzin", korobka: "AKPP", privod: "polnyy", bazovaya_tsena: 4300000 },
  { _id: 12, model_id: 10, nazvanie: "Ambition", obem_dvigatelya: 1.4, moshchnost_ls: 150, tip_topliva: "benzin", korobka: "AKPP", privod: "peredniy", bazovaya_tsena: 2900000 }
])

// ========== 5. TSVET ==========
db.tsvet.insertMany([
  { _id: 1, nazvanie: "Белый", kod_kraski: "040", tip_pokrytiya: "nemetallik" },
  { _id: 2, nazvanie: "Чёрный", kod_kraski: "218", tip_pokrytiya: "metallik" },
  { _id: 3, nazvanie: "Серебристый", kod_kraski: "1F7", tip_pokrytiya: "metallik" },
  { _id: 4, nazvanie: "Серый графит", kod_kraski: "1G3", tip_pokrytiya: "metallik" },
  { _id: 5, nazvanie: "Красный", kod_kraski: "3R3", tip_pokrytiya: "metallik" },
  { _id: 6, nazvanie: "Синий", kod_kraski: "8X8", tip_pokrytiya: "metallik" },
  { _id: 7, nazvanie: "Белый перламутр", kod_kraski: "070", tip_pokrytiya: "perlamutr" },
  { _id: 8, nazvanie: "Зелёный хаки", kod_kraski: "6X3", tip_pokrytiya: "matovyy" },
  { _id: 9, nazvanie: "Бежевый", kod_kraski: "4V8", tip_pokrytiya: "metallik" },
  { _id: 10, nazvanie: "Оранжевый", kod_kraski: "4R8", tip_pokrytiya: "nemetallik" }
])

// ========== 6. STATUS_AVTOMOBILYA ==========
db.status_avtomobilya.insertMany([
  { _id: 1, nazvanie: "В наличии" },
  { _id: 2, nazvanie: "Зарезервирован" },
  { _id: 3, nazvanie: "Продан" },
  { _id: 4, nazvanie: "В пути" },
  { _id: 5, nazvanie: "Предпродажная подготовка" }
])

// ========== 7. AVTOMOBIL ==========
db.avtomobil.insertMany([
  { _id: 1, vin: "XW7BF4FK10S123451", komplektatsiya_id: 1, tsvet_id: 1, status_id: 3, god_vypuska: 2024, probeg_km: 12, data_postupleniya: new Date("2024-02-10"), tsena: 3950000 },
  { _id: 2, vin: "XW7BF3FK20S123452", komplektatsiya_id: 2, tsvet_id: 2, status_id: 3, god_vypuska: 2024, probeg_km: 8, data_postupleniya: new Date("2024-02-10"), tsena: 4690000 },
  { _id: 3, vin: "JTMW43FV30D234563", komplektatsiya_id: 3, tsvet_id: 4, status_id: 1, god_vypuska: 2024, probeg_km: 15, data_postupleniya: new Date("2024-03-01"), tsena: 4150000 },
  { _id: 4, vin: "XWEPH81BDR0034564", komplektatsiya_id: 4, tsvet_id: 3, status_id: 3, god_vypuska: 2024, probeg_km: 20, data_postupleniya: new Date("2024-03-05"), tsena: 3490000 },
  { _id: 5, vin: "Z94C251BBR2345675", komplektatsiya_id: 5, tsvet_id: 5, status_id: 3, god_vypuska: 2024, probeg_km: 10, data_postupleniya: new Date("2024-03-12"), tsena: 1990000 },
  { _id: 6, vin: "XWEJ3813BR0045676", komplektatsiya_id: 6, tsvet_id: 1, status_id: 2, god_vypuska: 2024, probeg_km: 18, data_postupleniya: new Date("2024-04-02"), tsena: 2290000 },
  { _id: 7, vin: "XTAGFK440R1456787", komplektatsiya_id: 7, tsvet_id: 1, status_id: 3, god_vypuska: 2024, probeg_km: 5, data_postupleniya: new Date("2024-04-15"), tsena: 1470000 },
  { _id: 8, vin: "XTAGFL110R1456798", komplektatsiya_id: 8, tsvet_id: 6, status_id: 1, god_vypuska: 2024, probeg_km: 7, data_postupleniya: new Date("2024-04-15"), tsena: 1810000 },
  { _id: 9, vin: "XZGFF06A9RA567809", komplektatsiya_id: 9, tsvet_id: 4, status_id: 3, god_vypuska: 2024, probeg_km: 9, data_postupleniya: new Date("2024-05-03"), tsena: 2390000 },
  { _id: 10, vin: "LVVDB21B5RD678910", komplektatsiya_id: 10, tsvet_id: 2, status_id: 3, god_vypuska: 2024, probeg_km: 11, data_postupleniya: new Date("2024-05-20"), tsena: 2750000 },
  { _id: 11, vin: "Y4K8752A6RB789011", komplektatsiya_id: 11, tsvet_id: 7, status_id: 3, god_vypuska: 2024, probeg_km: 6, data_postupleniya: new Date("2024-06-01"), tsena: 4390000 },
  { _id: 12, vin: "TMBJR7NX5R0890112", komplektatsiya_id: 12, tsvet_id: 3, status_id: 4, god_vypuska: 2024, probeg_km: 0, data_postupleniya: new Date("2024-06-25"), tsena: 2950000 },
  { _id: 13, vin: "XTAGFK440R1456813", komplektatsiya_id: 7, tsvet_id: 8, status_id: 5, god_vypuska: 2024, probeg_km: 3, data_postupleniya: new Date("2024-07-01"), tsena: 1490000 },
  { _id: 14, vin: "XZGFF06A9RA567814", komplektatsiya_id: 9, tsvet_id: 9, status_id: 1, god_vypuska: 2024, probeg_km: 4, data_postupleniya: new Date("2024-07-05"), tsena: 2380000 },
  { _id: 15, vin: "LVVDB21B5RD678915", komplektatsiya_id: 10, tsvet_id: 10, status_id: 2, god_vypuska: 2024, probeg_km: 6, data_postupleniya: new Date("2024-07-10"), tsena: 2790000 }
])

// ========== 8. DOP_OBORUDOVANIE ==========
db.dop_oborudovanie.insertMany([
  { _id: 1, nazvanie: "Комплект зимней резины", tsena: 65000 },
  { _id: 2, nazvanie: "Коврики в салон и багажник", tsena: 9500 },
  { _id: 3, nazvanie: "Тонировка задних стёкол", tsena: 12000 },
  { _id: 4, nazvanie: "Сигнализация с автозапуском", tsena: 38000 },
  { _id: 5, nazvanie: "Защита картера", tsena: 14000 },
  { _id: 6, nazvanie: "Видеорегистратор", tsena: 15500 },
  { _id: 7, nazvanie: "Фаркоп", tsena: 28000 },
  { _id: 8, nazvanie: "Антигравийная плёнка", tsena: 45000 },
  { _id: 9, nazvanie: "Брызговики", tsena: 4500 },
  { _id: 10, nazvanie: "Багажник на крышу", tsena: 22000 }
])

// ========== 9. KLIENT ==========
db.klient.insertMany([
  { _id: 1, imya: "Алексей", familiya: "Смирнов", otchestvo: "Игоревич", data_rozhdeniya: new Date("1985-04-12"), telefon: "+79161234501", email: "smirnov.a@mail.ru", adres: "Москва, ул. Профсоюзная, 54", data_registratsii: new Date("2024-02-03") },
  { _id: 2, imya: "Екатерина", familiya: "Кузнецова", otchestvo: "Андреевна", data_rozhdeniya: new Date("1990-09-23"), telefon: "+79161234502", email: "kuznetsova.e@yandex.ru", adres: "Москва, Ленинский пр-т, 112", data_registratsii: new Date("2024-02-08") },
  { _id: 3, imya: "Дмитрий", familiya: "Попов", otchestvo: "Сергеевич", data_rozhdeniya: new Date("1978-01-05"), telefon: "+79161234503", email: "popov.d@gmail.com", adres: "Химки, ул. Молодёжная, 7", data_registratsii: new Date("2024-03-01") },
  { _id: 4, imya: "Ольга", familiya: "Васильева", otchestvo: "Петровна", data_rozhdeniya: new Date("1993-06-17"), telefon: "+79161234504", email: "vasilyeva.o@mail.ru", adres: "Москва, ул. Вавилова, 19", data_registratsii: new Date("2024-03-06") },
  { _id: 5, imya: "Михаил", familiya: "Соколов", otchestvo: "Владимирович", data_rozhdeniya: new Date("1999-11-30"), telefon: "+79161234505", email: "sokolov.m@yandex.ru", adres: "Люберцы, Октябрьский пр-т, 3", data_registratsii: new Date("2024-03-14") },
  { _id: 6, imya: "Анна", familiya: "Михайлова", otchestvo: "Олеговна", data_rozhdeniya: new Date("1988-02-14"), telefon: "+79161234506", email: "mikhaylova.a@mail.ru", adres: "Москва, ул. Тверская, 22", data_registratsii: new Date("2024-04-03") },
  { _id: 7, imya: "Сергей", familiya: "Новиков", otchestvo: "Николаевич", data_rozhdeniya: new Date("1975-08-09"), telefon: "+79161234507", email: "novikov.s@gmail.com", adres: "Подольск, ул. Кирова, 41", data_registratsii: new Date("2024-04-16") },
  { _id: 8, imya: "Наталья", familiya: "Фёдорова", otchestvo: "Викторовна", data_rozhdeniya: new Date("1996-05-02"), telefon: "+79161234508", email: "fedorova.n@yandex.ru", adres: "Москва, ул. Бутлерова, 10", data_registratsii: new Date("2024-05-04") },
  { _id: 9, imya: "Игорь", familiya: "Морозов", otchestvo: "Алексеевич", data_rozhdeniya: new Date("1982-12-25"), telefon: "+79161234509", email: "morozov.i@mail.ru", adres: "Мытищи, Новомытищинский пр-т, 30", data_registratsii: new Date("2024-05-21") },
  { _id: 10, imya: "Татьяна", familiya: "Волкова", otchestvo: "Игоревна", data_rozhdeniya: new Date("1991-07-07"), telefon: "+79161234510", email: "volkova.t@gmail.com", adres: "Москва, Каширское ш., 65", data_registratsii: new Date("2024-06-02") }
])

// ========== 10. DOKUMENT ==========
db.dokument.insertMany([
  { _id: 1, klient_id: 1, tip_dokumenta: "Паспорт РФ", seriya: "4505", nomer: "112233", kem_vydan: "ОВД Обручевского р-на г. Москвы", data_vydachi: new Date("2005-05-20") },
  { _id: 2, klient_id: 2, tip_dokumenta: "Паспорт РФ", seriya: "4510", nomer: "223344", kem_vydan: "ОУФМС по г. Москве", data_vydachi: new Date("2010-10-01") },
  { _id: 3, klient_id: 3, tip_dokumenta: "Паспорт РФ", seriya: "4603", nomer: "334455", kem_vydan: "ОВД г. Химки", data_vydachi: new Date("2003-02-11") },
  { _id: 4, klient_id: 4, tip_dokumenta: "Паспорт РФ", seriya: "4513", nomer: "445566", kem_vydan: "ОУФМС по г. Москве", data_vydachi: new Date("2013-07-03") },
  { _id: 5, klient_id: 5, tip_dokumenta: "Паспорт РФ", seriya: "4619", nomer: "556677", kem_vydan: "ГУ МВД по Московской обл.", data_vydachi: new Date("2019-12-12") },
  { _id: 6, klient_id: 6, tip_dokumenta: "Паспорт РФ", seriya: "4508", nomer: "667788", kem_vydan: "ОВД Тверского р-на г. Москвы", data_vydachi: new Date("2008-03-01") },
  { _id: 7, klient_id: 7, tip_dokumenta: "Паспорт РФ", seriya: "4620", nomer: "778899", kem_vydan: "ГУ МВД по Московской обл.", data_vydachi: new Date("2020-09-15") },
  { _id: 8, klient_id: 8, tip_dokumenta: "Паспорт РФ", seriya: "4516", nomer: "889900", kem_vydan: "ОУФМС по г. Москве", data_vydachi: new Date("2016-05-18") },
  { _id: 9, klient_id: 9, tip_dokumenta: "Паспорт РФ", seriya: "4602", nomer: "990011", kem_vydan: "ОВД г. Мытищи", data_vydachi: new Date("2002-01-20") },
  { _id: 10, klient_id: 10, tip_dokumenta: "Паспорт РФ", seriya: "4511", nomer: "101112", kem_vydan: "ОУФМС по г. Москве", data_vydachi: new Date("2011-08-09") }
])

// ========== 11. DOLZHNOST ==========
db.dolzhnost.insertMany([
  { _id: 1, nazvanie: "Руководитель отдела продаж", oklad: 150000 },
  { _id: 2, nazvanie: "Старший менеджер по продажам", oklad: 90000 },
  { _id: 3, nazvanie: "Менеджер по продажам", oklad: 70000 },
  { _id: 4, nazvanie: "Менеджер по кредитованию", oklad: 75000 },
  { _id: 5, nazvanie: "Специалист по trade-in", oklad: 80000 },
  { _id: 6, nazvanie: "Администратор зала", oklad: 50000 },
  { _id: 7, nazvanie: "Кассир", oklad: 55000 },
  { _id: 8, nazvanie: "Логист", oklad: 65000 },
  { _id: 9, nazvanie: "Специалист предпродажной подготовки", oklad: 60000 },
  { _id: 10, nazvanie: "Маркетолог", oklad: 85000 }
])

// ========== 12. SOTRUDNIK ==========
db.sotrudnik.insertMany([
  { _id: 1, imya: "Владимир", familiya: "Орлов", otchestvo: "Павлович", telefon: "+79037770001", email: "orlov@avtosalon.ru", data_priema: new Date("2019-03-01"), dolzhnost_id: 1 },
  { _id: 2, imya: "Кирилл", familiya: "Лебедев", otchestvo: "Андреевич", telefon: "+79037770002", email: "lebedev@avtosalon.ru", data_priema: new Date("2020-06-15"), dolzhnost_id: 2 },
  { _id: 3, imya: "Марина", familiya: "Козлова", otchestvo: "Сергеевна", telefon: "+79037770003", email: "kozlova@avtosalon.ru", data_priema: new Date("2021-02-01"), dolzhnost_id: 3 },
  { _id: 4, imya: "Артём", familiya: "Зайцев", otchestvo: "Денисович", telefon: "+79037770004", email: "zaytsev@avtosalon.ru", data_priema: new Date("2022-09-12"), dolzhnost_id: 3 },
  { _id: 5, imya: "Юлия", familiya: "Павлова", otchestvo: "Михайловна", telefon: "+79037770005", email: "pavlova@avtosalon.ru", data_priema: new Date("2021-11-01"), dolzhnost_id: 4 },
  { _id: 6, imya: "Роман", familiya: "Семенов", otchestvo: "Игоревич", telefon: "+79037770006", email: "semenov@avtosalon.ru", data_priema: new Date("2020-04-20"), dolzhnost_id: 5 },
  { _id: 7, imya: "Дарья", familiya: "Голубева", otchestvo: "Алексеевна", telefon: "+79037770007", email: "golubeva@avtosalon.ru", data_priema: new Date("2023-01-16"), dolzhnost_id: 6 },
  { _id: 8, imya: "Елена", familiya: "Виноградова", otchestvo: "Юрьевна", telefon: "+79037770008", email: "vinogradova@avtosalon.ru", data_priema: new Date("2022-03-09"), dolzhnost_id: 7 },
  { _id: 9, imya: "Максим", familiya: "Богданов", otchestvo: "Олегович", telefon: "+79037770009", email: "bogdanov@avtosalon.ru", data_priema: new Date("2023-05-22"), dolzhnost_id: 3 },
  { _id: 10, imya: "Олег", familiya: "Воробьёв", otchestvo: "Петрович", telefon: "+79037770010", email: "vorobyov@avtosalon.ru", data_priema: new Date("2021-08-02"), dolzhnost_id: 9 }
])

// ========== 13. UCHET_ZAPIS ==========
db.uchet_zapis.insertMany([
  { _id: 1, sotrudnik_id: 1, login: "orlov", khesh_parolya: "$2b$12$2e336f270f19c5b99f1192adb13c7f4f904abfc66576c0147e00a", rol: "admin", aktiven: 1 },
  { _id: 2, sotrudnik_id: 2, login: "lebedev", khesh_parolya: "$2b$12$7fa900ed9da7b1fa1caefb7ec266f87d615566f6bf8af2a56c50e", rol: "menedzher", aktiven: 1 },
  { _id: 3, sotrudnik_id: 3, login: "kozlova", khesh_parolya: "$2b$12$4bf440d1a28a1e753041b88fd577b2ac5fb061e4e75d5a172c9b3", rol: "menedzher", aktiven: 1 },
  { _id: 4, sotrudnik_id: 4, login: "zaytsev", khesh_parolya: "$2b$12$3f124de32c99aabf584d82774aaa85844dcb4511938d63516c8a8", rol: "menedzher", aktiven: 1 },
  { _id: 5, sotrudnik_id: 5, login: "pavlova", khesh_parolya: "$2b$12$03de2639b919a9ff5e814ef32738219034ba3360762696a6681ef", rol: "kredit", aktiven: 1 },
  { _id: 6, sotrudnik_id: 6, login: "semenov", khesh_parolya: "$2b$12$e65c1b1698356a7c31f3097eaaed1e4af92e9d79dfa066a1e25ac", rol: "trade_in", aktiven: 1 },
  { _id: 7, sotrudnik_id: 7, login: "golubeva", khesh_parolya: "$2b$12$ed550340ce06b22e69fe3196b69f59c7d17558960a48a2a76a8ee", rol: "administrator", aktiven: 1 },
  { _id: 8, sotrudnik_id: 8, login: "vinogradova", khesh_parolya: "$2b$12$0fa2a5848a932f24b7efba02fc96615ebb9f1b9a9e7238577795a", rol: "kassir", aktiven: 1 },
  { _id: 9, sotrudnik_id: 9, login: "bogdanov", khesh_parolya: "$2b$12$88f5d8a0aa760bdf0daf8305786369be9f901eb35ca73e00b0808", rol: "menedzher", aktiven: 1 },
  { _id: 10, sotrudnik_id: 10, login: "vorobyov", khesh_parolya: "$2b$12$e039213100ad6da511ca2fc4234bffb56e633e88c8ac12498eb3f", rol: "servis", aktiven: 0 }
])

// ========== 14. TEST_DRAYV ==========
db.test_drayv.insertMany([
  { _id: 1, avtomobil_id: 1, klient_id: 1, sotrudnik_id: 3, data_vremya: new Date("2024-02-12T11:00:00"), dlitelnost_min: 30, otzyv: "Понравилась плавность хода" },
  { _id: 2, avtomobil_id: 3, klient_id: 2, sotrudnik_id: 2, data_vremya: new Date("2024-03-02T14:30:00"), dlitelnost_min: 40, otzyv: "Хочет полный привод, но дороговато" },
  { _id: 3, avtomobil_id: 4, klient_id: 2, sotrudnik_id: 2, data_vremya: new Date("2024-03-09T12:00:00"), dlitelnost_min: 30, otzyv: "Выбрала Sportage" },
  { _id: 4, avtomobil_id: 5, klient_id: 4, sotrudnik_id: 4, data_vremya: new Date("2024-03-14T16:00:00"), dlitelnost_min: 20, otzyv: null },
  { _id: 5, avtomobil_id: 7, klient_id: 5, sotrudnik_id: 9, data_vremya: new Date("2024-04-17T10:30:00"), dlitelnost_min: 25, otzyv: "Первый автомобиль, всё устроило" },
  { _id: 6, avtomobil_id: 9, klient_id: 6, sotrudnik_id: 3, data_vremya: new Date("2024-05-05T13:00:00"), dlitelnost_min: 30, otzyv: "Хорошая шумоизоляция" },
  { _id: 7, avtomobil_id: 10, klient_id: 7, sotrudnik_id: 4, data_vremya: new Date("2024-05-22T15:00:00"), dlitelnost_min: 45, otzyv: "Проверил по бездорожью" },
  { _id: 8, avtomobil_id: 11, klient_id: 8, sotrudnik_id: 2, data_vremya: new Date("2024-06-03T11:30:00"), dlitelnost_min: 40, otzyv: "Очень мощный, берёт" },
  { _id: 9, avtomobil_id: 6, klient_id: 9, sotrudnik_id: 9, data_vremya: new Date("2024-06-10T17:00:00"), dlitelnost_min: 30, otzyv: "Взял время подумать" },
  { _id: 10, avtomobil_id: 2, klient_id: 10, sotrudnik_id: 3, data_vremya: new Date("2024-06-15T12:00:00"), dlitelnost_min: 35, otzyv: null },
  { _id: 11, avtomobil_id: 15, klient_id: 3, sotrudnik_id: 4, data_vremya: new Date("2024-07-12T14:00:00"), dlitelnost_min: 30, otzyv: "Удобный салон" },
  { _id: 12, avtomobil_id: 8, klient_id: 9, sotrudnik_id: 9, data_vremya: new Date("2024-07-20T10:00:00"), dlitelnost_min: 20, otzyv: "Сравнивал с Creta" }
])

// ========== 15. STATUS_DOGOVORA ==========
db.status_dogovora.insertMany([
  { _id: 1, nazvanie: "Черновик" },
  { _id: 2, nazvanie: "Подписан" },
  { _id: 3, nazvanie: "Оплачен" },
  { _id: 4, nazvanie: "Автомобиль выдан" },
  { _id: 5, nazvanie: "Расторгнут" }
])

// ========== 16. DOGOVOR_PRODAZHI ==========
db.dogovor_prodazhi.insertMany([
  { _id: 1, nomer_dogovora: "ДКП-2024-0001", klient_id: 1, sotrudnik_id: 3, avtomobil_id: 1, status_id: 4, data_zaklyucheniya: new Date("2024-02-14"), skidka: 50000, itogovaya_summa: 3974500, data_vydachi_avto: new Date("2024-02-20") },
  { _id: 2, nomer_dogovora: "ДКП-2024-0002", klient_id: 2, sotrudnik_id: 2, avtomobil_id: 4, status_id: 4, data_zaklyucheniya: new Date("2024-03-10"), skidka: 40000, itogovaya_summa: 3502000, data_vydachi_avto: new Date("2024-03-15") },
  { _id: 3, nomer_dogovora: "ДКП-2024-0003", klient_id: 4, sotrudnik_id: 4, avtomobil_id: 5, status_id: 4, data_zaklyucheniya: new Date("2024-03-16"), skidka: 0, itogovaya_summa: 1999500, data_vydachi_avto: new Date("2024-03-22") },
  { _id: 4, nomer_dogovora: "ДКП-2024-0004", klient_id: 5, sotrudnik_id: 9, avtomobil_id: 7, status_id: 4, data_zaklyucheniya: new Date("2024-04-18"), skidka: 20000, itogovaya_summa: 1519500, data_vydachi_avto: new Date("2024-04-25") },
  { _id: 5, nomer_dogovora: "ДКП-2024-0005", klient_id: 6, sotrudnik_id: 3, avtomobil_id: 9, status_id: 4, data_zaklyucheniya: new Date("2024-05-06"), skidka: 30000, itogovaya_summa: 2375500, data_vydachi_avto: new Date("2024-05-12") },
  { _id: 6, nomer_dogovora: "ДКП-2024-0006", klient_id: 7, sotrudnik_id: 4, avtomobil_id: 10, status_id: 4, data_zaklyucheniya: new Date("2024-05-24"), skidka: 50000, itogovaya_summa: 2742000, data_vydachi_avto: new Date("2024-06-01") },
  { _id: 7, nomer_dogovora: "ДКП-2024-0007", klient_id: 8, sotrudnik_id: 2, avtomobil_id: 11, status_id: 3, data_zaklyucheniya: new Date("2024-06-04"), skidka: 90000, itogovaya_summa: 4383000, data_vydachi_avto: null },
  { _id: 8, nomer_dogovora: "ДКП-2024-0008", klient_id: 10, sotrudnik_id: 3, avtomobil_id: 2, status_id: 4, data_zaklyucheniya: new Date("2024-06-17"), skidka: 100000, itogovaya_summa: 4602000, data_vydachi_avto: new Date("2024-06-25") },
  { _id: 9, nomer_dogovora: "ДКП-2024-0009", klient_id: 3, sotrudnik_id: 4, avtomobil_id: 15, status_id: 2, data_zaklyucheniya: new Date("2024-07-13"), skidka: 40000, itogovaya_summa: 2815000, data_vydachi_avto: null },
  { _id: 10, nomer_dogovora: "ДКП-2024-0010", klient_id: 9, sotrudnik_id: 9, avtomobil_id: 6, status_id: 1, data_zaklyucheniya: new Date("2024-07-21"), skidka: 0, itogovaya_summa: 2299500, data_vydachi_avto: null }
])

// ========== 17. POZITSIYA_DOP ==========
db.pozitsiya_dop.insertMany([
  { _id: { dogovor_id: 1, dop_oborudovanie_id: 1 }, dogovor_id: 1, dop_oborudovanie_id: 1, kolichestvo: 1, tsena_fiks: 65000 },
  { _id: { dogovor_id: 1, dop_oborudovanie_id: 2 }, dogovor_id: 1, dop_oborudovanie_id: 2, kolichestvo: 1, tsena_fiks: 9500 },
  { _id: { dogovor_id: 2, dop_oborudovanie_id: 4 }, dogovor_id: 2, dop_oborudovanie_id: 4, kolichestvo: 1, tsena_fiks: 38000 },
  { _id: { dogovor_id: 2, dop_oborudovanie_id: 5 }, dogovor_id: 2, dop_oborudovanie_id: 5, kolichestvo: 1, tsena_fiks: 14000 },
  { _id: { dogovor_id: 3, dop_oborudovanie_id: 2 }, dogovor_id: 3, dop_oborudovanie_id: 2, kolichestvo: 1, tsena_fiks: 9500 },
  { _id: { dogovor_id: 4, dop_oborudovanie_id: 1 }, dogovor_id: 4, dop_oborudovanie_id: 1, kolichestvo: 1, tsena_fiks: 65000 },
  { _id: { dogovor_id: 4, dop_oborudovanie_id: 9 }, dogovor_id: 4, dop_oborudovanie_id: 9, kolichestvo: 1, tsena_fiks: 4500 },
  { _id: { dogovor_id: 5, dop_oborudovanie_id: 6 }, dogovor_id: 5, dop_oborudovanie_id: 6, kolichestvo: 1, tsena_fiks: 15500 },
  { _id: { dogovor_id: 6, dop_oborudovanie_id: 7 }, dogovor_id: 6, dop_oborudovanie_id: 7, kolichestvo: 1, tsena_fiks: 28000 },
  { _id: { dogovor_id: 6, dop_oborudovanie_id: 5 }, dogovor_id: 6, dop_oborudovanie_id: 5, kolichestvo: 1, tsena_fiks: 14000 },
  { _id: { dogovor_id: 7, dop_oborudovanie_id: 8 }, dogovor_id: 7, dop_oborudovanie_id: 8, kolichestvo: 1, tsena_fiks: 45000 },
  { _id: { dogovor_id: 7, dop_oborudovanie_id: 4 }, dogovor_id: 7, dop_oborudovanie_id: 4, kolichestvo: 1, tsena_fiks: 38000 },
  { _id: { dogovor_id: 8, dop_oborudovanie_id: 3 }, dogovor_id: 8, dop_oborudovanie_id: 3, kolichestvo: 1, tsena_fiks: 12000 },
  { _id: { dogovor_id: 9, dop_oborudovanie_id: 1 }, dogovor_id: 9, dop_oborudovanie_id: 1, kolichestvo: 1, tsena_fiks: 65000 },
  { _id: { dogovor_id: 10, dop_oborudovanie_id: 2 }, dogovor_id: 10, dop_oborudovanie_id: 2, kolichestvo: 1, tsena_fiks: 9500 }
])

// ========== 18. TRADE_IN ==========
db.trade_in.insertMany([
  { _id: 1, dogovor_id: 2, vin: "Z94CB41AAGR123401", marka_model: "Hyundai Solaris", god_vypuska: 2016, probeg_km: 118000, otsenochnaya_stoimost: 820000 },
  { _id: 2, dogovor_id: 6, vin: "XTA217030C0123402", marka_model: "Lada Priora", god_vypuska: 2012, probeg_km: 164000, otsenochnaya_stoimost: 390000 },
  { _id: 3, dogovor_id: 8, vin: "XW8ZZZ61ZEG123403", marka_model: "Volkswagen Polo", god_vypuska: 2014, probeg_km: 132000, otsenochnaya_stoimost: 760000 }
])

// ========== 19. SPOSOB_OPLATY ==========
db.sposob_oplaty.insertMany([
  { _id: 1, nazvanie: "Наличные" },
  { _id: 2, nazvanie: "Банковская карта" },
  { _id: 3, nazvanie: "Безналичный перевод" },
  { _id: 4, nazvanie: "Автокредит" },
  { _id: 5, nazvanie: "Зачёт trade-in" }
])

// ========== 20. PLATEZH ==========
db.platezh.insertMany([
  { _id: 1, dogovor_id: 1, sposob_id: 2, summa: 100000, data_platezha: new Date("2024-02-14T12:10:00"), tip_platezha: "predoplata" },
  { _id: 2, dogovor_id: 1, sposob_id: 3, summa: 3874500, data_platezha: new Date("2024-02-19T10:00:00"), tip_platezha: "doplata" },
  { _id: 3, dogovor_id: 2, sposob_id: 5, summa: 820000, data_platezha: new Date("2024-03-10T13:00:00"), tip_platezha: "trade_in" },
  { _id: 4, dogovor_id: 2, sposob_id: 4, summa: 2682000, data_platezha: new Date("2024-03-14T11:00:00"), tip_platezha: "kredit" },
  { _id: 5, dogovor_id: 3, sposob_id: 3, summa: 1999500, data_platezha: new Date("2024-03-18T15:00:00"), tip_platezha: "doplata" },
  { _id: 6, dogovor_id: 4, sposob_id: 1, summa: 50000, data_platezha: new Date("2024-04-18T11:30:00"), tip_platezha: "predoplata" },
  { _id: 7, dogovor_id: 4, sposob_id: 4, summa: 1469500, data_platezha: new Date("2024-04-24T12:00:00"), tip_platezha: "kredit" },
  { _id: 8, dogovor_id: 5, sposob_id: 2, summa: 200000, data_platezha: new Date("2024-05-06T14:00:00"), tip_platezha: "predoplata" },
  { _id: 9, dogovor_id: 5, sposob_id: 3, summa: 2175500, data_platezha: new Date("2024-05-11T10:00:00"), tip_platezha: "doplata" },
  { _id: 10, dogovor_id: 6, sposob_id: 5, summa: 390000, data_platezha: new Date("2024-05-24T16:00:00"), tip_platezha: "trade_in" },
  { _id: 11, dogovor_id: 6, sposob_id: 3, summa: 2352000, data_platezha: new Date("2024-05-30T12:00:00"), tip_platezha: "doplata" },
  { _id: 12, dogovor_id: 7, sposob_id: 2, summa: 300000, data_platezha: new Date("2024-06-04T12:00:00"), tip_platezha: "predoplata" },
  { _id: 13, dogovor_id: 7, sposob_id: 4, summa: 4083000, data_platezha: new Date("2024-06-10T09:30:00"), tip_platezha: "kredit" },
  { _id: 14, dogovor_id: 8, sposob_id: 5, summa: 760000, data_platezha: new Date("2024-06-17T13:00:00"), tip_platezha: "trade_in" },
  { _id: 15, dogovor_id: 8, sposob_id: 3, summa: 3842000, data_platezha: new Date("2024-06-24T10:00:00"), tip_platezha: "doplata" },
  { _id: 16, dogovor_id: 9, sposob_id: 2, summa: 100000, data_platezha: new Date("2024-07-13T15:00:00"), tip_platezha: "predoplata" }
])

print("========== ИТОГО ==========")
db.getCollectionNames().sort().forEach(function(c) {
  print(c + ": " + db[c].countDocuments());
});
print("==========================")

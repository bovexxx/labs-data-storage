//  ЛР3. MongoDB — запросы к БД avtosalon (вариант 9, отдел продаж автосалона)
//  Выполнять во вкладке MONGOSH в MongoDB Compass ПОСЛЕ avtosalon_mongo.js.
//  Каждый блок — отдельный шаг для скриншота в отчёт.

use("avtosalon")

// ---------------------------------------------------------------------
// 1. Поиск: все модели-кроссоверы (tip_kuzova_id = 4)
// ---------------------------------------------------------------------
db.model.find({ tip_kuzova_id: 4 }).pretty()

// ---------------------------------------------------------------------
// 2. Поиск с условиями: автомобили «В наличии» (status_id = 1) дешевле 3 млн,
//    с названием модели и комплектации (связь через $lookup)
// ---------------------------------------------------------------------
db.avtomobil.aggregate([
  { $match: { status_id: 1, tsena: { $lt: 3000000 } } },
  { $lookup: { from: "komplektatsiya", localField: "komplektatsiya_id", foreignField: "_id", as: "k" } },
  { $unwind: "$k" },
  { $lookup: { from: "model", localField: "k.model_id", foreignField: "_id", as: "m" } },
  { $unwind: "$m" },
  { $project: { _id: 0, vin: 1, model: "$m.nazvanie", komplektatsiya: "$k.nazvanie", tsena: 1 } },
  { $sort: { tsena: 1 } }
])

// ---------------------------------------------------------------------
// 3. Добавление новых моделей, комплектаций и автомобилей
// ---------------------------------------------------------------------
var maxM = db.model.find().sort({ _id: -1 }).limit(1).toArray()[0]._id
db.model.insertMany([
  { _id: maxM + 1, nazvanie: "K5",    marka_id: 2, tip_kuzova_id: 1, pokolenie: "DL3" },
  { _id: maxM + 2, nazvanie: "Dargo", marka_id: 5, tip_kuzova_id: 5, pokolenie: "I" }
])

var maxK = db.komplektatsiya.find().sort({ _id: -1 }).limit(1).toArray()[0]._id
db.komplektatsiya.insertMany([
  { _id: maxK + 1, model_id: maxM + 1, nazvanie: "Prestige", obem_dvigatelya: 2.5, moshchnost_ls: 194, tip_topliva: "benzin", korobka: "AKPP",  privod: "peredniy", bazovaya_tsena: 3600000 },
  { _id: maxK + 2, model_id: maxM + 2, nazvanie: "Premium",  obem_dvigatelya: 2.0, moshchnost_ls: 192, tip_topliva: "benzin", korobka: "robot", privod: "polnyy",   bazovaya_tsena: 3300000 }
])

var maxA = db.avtomobil.find().sort({ _id: -1 }).limit(1).toArray()[0]._id
db.avtomobil.insertMany([
  { _id: maxA + 1, vin: "XWEG4417BR0000101", komplektatsiya_id: maxK + 1, tsvet_id: 2, status_id: 1, god_vypuska: 2024, probeg_km: 5,  data_postupleniya: new Date(), tsena: 3650000 },
  { _id: maxA + 2, vin: "XWEG4417BR0000102", komplektatsiya_id: maxK + 1, tsvet_id: 1, status_id: 4, god_vypuska: 2024, probeg_km: 0,  data_postupleniya: new Date(), tsena: 3650000 },
  { _id: maxA + 3, vin: "XZGHD05A1RA000103", komplektatsiya_id: maxK + 2, tsvet_id: 8, status_id: 1, god_vypuska: 2024, probeg_km: 12, data_postupleniya: new Date(), tsena: 3350000 },
  { _id: maxA + 4, vin: "XZGHD05A1RA000104", komplektatsiya_id: maxK + 2, tsvet_id: 4, status_id: 5, god_vypuska: 2024, probeg_km: 3,  data_postupleniya: new Date(), tsena: 3350000 }
])

// ---------------------------------------------------------------------
// 4. Добавление характеристик (новые поля в существующих документах)
// ---------------------------------------------------------------------
// гарантия для всех комплектаций
db.komplektatsiya.updateMany({}, { $set: { garantiya: { let: 3, probeg_km: 100000 } } })
// у полноприводных — дополнительное поле с опциями
db.komplektatsiya.updateMany(
  { privod: "polnyy" },
  { $set: { optsii: ["Подогрев руля", "Камера 360°", "Режимы бездорожья"] } }
)
// клиенту — отметка о согласии на рассылку
db.klient.updateOne({ telefon: "+79161234501" }, { $set: { soglasie_na_rassylku: true } })

db.komplektatsiya.find({ privod: "polnyy" }, { nazvanie: 1, privod: 1, garantiya: 1, optsii: 1 })

// ---------------------------------------------------------------------
// 5. Вывод всех автомобилей с датой поступления (по дате, новые сверху)
// ---------------------------------------------------------------------
db.avtomobil.find(
  {},
  { _id: 0, vin: 1, god_vypuska: 1, tsena: 1, data_postupleniya: 1 }
).sort({ data_postupleniya: -1 })

// ---------------------------------------------------------------------
// 6. Общее количество автомобилей и моделей + распределение по статусам
// ---------------------------------------------------------------------
print("Всего моделей: "     + db.model.countDocuments())
print("Всего автомобилей: " + db.avtomobil.countDocuments())
print("Автомобилей в наличии: " + db.avtomobil.countDocuments({ status_id: 1 }))

db.avtomobil.aggregate([
  { $lookup: { from: "status_avtomobilya", localField: "status_id", foreignField: "_id", as: "s" } },
  { $unwind: "$s" },
  { $group: { _id: "$s.nazvanie", kolichestvo: { $sum: 1 }, summa: { $sum: "$tsena" } } },
  { $sort: { kolichestvo: -1 } }
])

// ---------------------------------------------------------------------
// 7. Выручка по менеджерам (сумма договоров, кроме черновиков и расторгнутых)
// ---------------------------------------------------------------------
db.dogovor_prodazhi.aggregate([
  { $match: { status_id: { $in: [2, 3, 4] } } },
  { $group: { _id: "$sotrudnik_id", dogovorov: { $sum: 1 }, vyruchka: { $sum: "$itogovaya_summa" } } },
  { $lookup: { from: "sotrudnik", localField: "_id", foreignField: "_id", as: "s" } },
  { $unwind: "$s" },
  { $project: { _id: 0, menedzher: { $concat: ["$s.familiya", " ", "$s.imya"] }, dogovorov: 1, vyruchka: 1 } },
  { $sort: { vyruchka: -1 } }
])

// ---------------------------------------------------------------------
// 8. Изменение данных: договор ДКП-2024-0009 полностью оплачен
// ---------------------------------------------------------------------
db.dogovor_prodazhi.updateOne({ nomer_dogovora: "ДКП-2024-0009" }, { $set: { status_id: 3 } })
db.avtomobil.updateOne({ vin: "LVVDB21B5RD678915" }, { $set: { status_id: 3 } })
db.dogovor_prodazhi.find({ nomer_dogovora: "ДКП-2024-0009" })

// ---------------------------------------------------------------------
// 9. Удаление автомобиля по VIN
// ---------------------------------------------------------------------
db.avtomobil.find({ vin: "XZGHD05A1RA000104" })
db.avtomobil.deleteOne({ vin: "XZGHD05A1RA000104" })
print("Осталось автомобилей: " + db.avtomobil.countDocuments())
print("Найдено по удалённому VIN: " + db.avtomobil.countDocuments({ vin: "XZGHD05A1RA000104" }))

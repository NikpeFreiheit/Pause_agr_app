-- Запросы в БД:
-- - селект списка всех приостановок по договору и здесь же подсчитанная сумма дней для паузы
select
agr_id
,min(day_count) as rest_days
(
Select 
a.id as agr_id
, hist.pause_start_at   
, hist.pause_end_at   
, coalesce(DATE_PART('day', hist.pause_end_at - hist.pause_start_at),0) as pause_day--количество дней паузы
,case
    when
    hist.agr_id is null
    then 1
    else CEIL(DATE_PART('year', hist.pause_start_at-start_at)) --количество лет (округленное в больш.ст.) между датой начала паузы и датой начала договора
end agr_year
, case
    when
    hist.agr_id is null
    then 90
    else 90-(sum(pause_day) over (partition by hist.agr_id, agr_year order by hist.pause_start_at))  ---!!!вместо pause_day,agr_year вставить полный расчет атрибута
end day_count
from
agreement a
left join hist_event_Agr hist
on a.id = hist.agr_id
where hist.pause_status_id in('completed','plane')
);


-- - инсерт приостановки
-- - апдейт приостановки
-- - апдейт договора (статус)
-- - делит приостановки
-- - получить информацию по договору (просто из таблицы договор)
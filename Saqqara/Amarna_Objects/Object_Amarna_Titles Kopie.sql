SELECT
    o.id_object,
    o.object_type,
    o.object_subtype_1 AS object_subtype,
    o.link_collection,
    o.inventory_number,

    o.provenience_detail,
    o.provenance_detail,

    d.id_dating,
    d.pharaonic_ruler,

    pi.id_provenience,
    pi.place,
    pi.archaeological_site,
    pi.archaeological_context,

    l.id_location,
    l.place,
    l.country,
    l.lat,
    l.lon,

    STRING_AGG(DISTINCT pr.name, '; ' ORDER BY pr.name)
        AS current_or_former_provenances,

    STRING_AGG(DISTINCT t.id_title::text, '; ' ORDER BY t.id_title::text)
        AS tomb_owner_title_ids,

    STRING_AGG(DISTINCT t.title_unicode, '; ' ORDER BY t.title_unicode)
        AS tomb_owner_titles_unicode

FROM prom.object o

JOIN prom.object_dating od
    ON od.id_object = o.id_object
JOIN prom.dating d
    ON d.id_dating = od.id_dating

LEFT JOIN prom.object_provenience opi
    ON opi.id_object = o.id_object
LEFT JOIN prom.provenience pi
    ON pi.id_provenience = opi.id_provenience

LEFT JOIN prom.provenience_location pil
    ON pil.id_provenience = pi.id_provenience
LEFT JOIN prom.location l
    ON l.id_location = pil.id_location

LEFT JOIN prom.object_provenance op
    ON op.id_object = o.id_object
LEFT JOIN prom.provenance pr
    ON pr.id_provenance = op.id_provenance

LEFT JOIN prom.person_provenience pp
    ON pp.id_provenience = pi.id_provenience
LEFT JOIN prom.person p
    ON p.id_person = pp.id_person
LEFT JOIN prom.person_title pt
    ON pt.id_person = p.id_person
LEFT JOIN prom.title t
    ON t.id_title = pt.id_title

WHERE d.id_dating IN (8, 9, 14, 15, 16, 30, 31)

GROUP BY
    o.id_object,
    o.object_type,
    o.object_subtype_1,
    o.link_collection,
    o.inventory_number,
    o.provenience_detail,
    o.provenance_detail,
    d.id_dating,
    d.period_general,
    d.pharaonic_period,
    d.pharaonic_ruler,
    d.time_data,
    pi.id_provenience,
    pi.place,
    pi.archaeological_site,
    pi.archaeological_context,
    l.id_location,
    l.place,
    l.country,
    l.lat,
    l.lon

ORDER BY
    d.id_dating,
    pi.id_provenience NULLS LAST,
    l.id_location NULLS LAST,
    o.object_type,
    o.object_subtype_1,
    o.link_collection,
    o.inventory_number;
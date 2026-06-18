SELECT
    -- Location
    loc.id_location,
    loc.continent,
    loc.country,
    loc.place,
    loc.lat_decimal,
    loc.lon_decimal,
    loc.wikidata_id,
    loc.wikidata_link,
    loc.geonames_id,
    loc.geonames_link,
    loc.tm_id,
    loc.tm_link,

    -- Provenance / Collection
    prov.id_provenance,
    prov.name                AS provenance_name,
    prov.online_catalogue,
    prov.collection_link,
    prov.thot_id,
    prov.thot_link,
    prov.tm_id               AS provenance_tm_id,
    prov.tm_link             AS provenance_tm_link,
    prov.tla_id,
    prov.tla_link,
    prov.pnm_id              AS provenance_pnm_id,
    prov.pnm_link            AS provenance_pnm_link,

    -- Object count per provenance at this location
    COUNT(DISTINCT op.id_object) AS object_count

FROM prom.provenance_location pl
    JOIN prom.provenance     prov ON prov.id_provenance = pl.id_provenance
    JOIN prom.location       loc  ON loc.id_location    = pl.id_location
    LEFT JOIN prom.object_provenance op ON op.id_provenance = prov.id_provenance

GROUP BY
    loc.id_location,
    loc.continent,
    loc.country,
    loc.place,
    loc.lat_decimal,
    loc.lon_decimal,
    loc.wikidata_id,
    loc.wikidata_link,
    loc.geonames_id,
    loc.geonames_link,
    loc.tm_id,
    loc.tm_link,
    prov.id_provenance,
    prov.name,
    prov.online_catalogue,
    prov.collection_link,
    prov.thot_id,
    prov.thot_link,
    prov.tm_id,
    prov.tm_link,
    prov.tla_id,
    prov.tla_link,
    prov.pnm_id,
    prov.pnm_link

ORDER BY
    loc.continent,
    loc.country,
    loc.place,
    prov.name;
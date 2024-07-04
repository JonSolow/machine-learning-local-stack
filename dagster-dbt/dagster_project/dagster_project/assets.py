from dagster import AssetExecutionContext
from dagster_dbt import DbtCliResource, dbt_assets
from dagster_embedded_elt.dlt import DagsterDltResource, dlt_assets
from dlt import pipeline
from dlt_sources.pokemon import source as pokemon_source

from .constants import dbt_manifest_path


@dbt_assets(manifest=dbt_manifest_path)
def dbt_project_dbt_assets(context: AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["build"], context=context).stream()


@dlt_assets(
    dlt_source=pokemon_source(),
    dlt_pipeline=pipeline(
        pipeline_name="pokemon",
        dataset_name="pokemon_data",
        destination="duckdb",
        progress="log",
    ),
    name="pokemon",
    group_name="pokemon",
)
def dlt_pokemon_assets(context: AssetExecutionContext, dlt: DagsterDltResource):
    yield from dlt.run(context=context)

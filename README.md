## Configure environment

1. Install prerequisites:
    - IDE (e.g. [VS Code](https://code.visualstudio.com/docs/setup/setup-overview))
    - [Docker](https://docs.docker.com/engine/install/)

1. Fork & Clone this repository and open in IDE

1. Spin up Docker containers

    All the services are configured via [Docker containers](./docker-compose.yml).

    - devcontainer
    - Postgres

    ```bash
    # build dev container
    devcontainer build .

    # open dev container
    devcontainer open .
    ```

    ![](./docs/1_docker_compose_services.png)

1. Verify you are in a development container by running commands:

    ```bash
    dbt --version
    ```

    ![](./docs/2_dbt_version.png)

    If any of these commands fails printing out used software version then you are probably running it on your local machine not in a dev container!


## Install dbt packages

1. Install modules via [packages.yml](./packages.yml)

    ```bash
    dbt clean # clean temp files
    dbt deps # install dependencies (modules)
    ```


## Homework

1. Build a data mart over Data Vault.

Dynamics of changes in the number of orders by calendar week and order status.

##  Этапы выполнения ДЗ

1. 
- Добавила строку в файл source_orders.csv
(В Hub для заказов появится новая запись с этим новым ключом
В Link/спутниках — обновятся связи/атрибуты по новому ключу
В витринах количество заказов по неделям увеличится там, где попал новый заказ)
- Изменила строку в source_orders.csv
(В Hub новая запись не появится (ключ уже есть)
В Satellite добавится новая версия атрибутов order'а (историзация!)
В витрине изменится кол-во заказов)
- Удалила строку в source_orders.csv
(В Hub запись не удалится (Data Vault обычно хранит всю историческую инфу — потребуется специальная логика для фактического удаления)
В новых загрузках заказ с этим ключом отсутствует
В витрине количество заказов уменьшится)
2. Создала витрины запросами customers_order_rank.sql и order_dynamics.sql в папке models

WITH orders_weekly AS (
  SELECT
    DATE_TRUNC('week', order_date) AS calendar_week,
    COUNT(DISTINCT id) AS orders_count
  FROM {{ ref('source_orders') }}
  GROUP BY calendar_week
)
SELECT * FROM orders_weekly
ORDER BY calendar_week


WITH completed_orders AS (
  SELECT
    user_id,
    COUNT(DISTINCT id) AS completed_count
  FROM {{ ref('source_orders') }}
  WHERE status = 'completed'
  GROUP BY user_id
)
SELECT user_id, completed_count
FROM completed_orders
ORDER BY completed_count DESC




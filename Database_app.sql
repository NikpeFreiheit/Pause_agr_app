Create table agreement
(
    id             int,
    agr_num        varchar,
    start_at       date,
    expire_at      date,
    amount         decimal,
    curr_status_id int,

    FOREIGN KEY (curr_status_id)
        REFERENCES agr_status (id)
);

Create table agr_status
(
    id          int,
    status_name varchar
);

Create table log_users
(
    id         int,
    user_login varchar
);

Create table User_Agr
(
    id       int,
    start_at date,
    user_id  int,
    agr_id   int,

    FOREIGN KEY (user_id)
        REFERENCES log_users (id),
    FOREIGN KEY (agr_id)
        REFERENCES agreement (id)
);


Create table hist_pause_Agr
(
    id              int,
    agr_id          int,
    pause_start_at  date,
    pause_end_at    date,
    pause_status_id int,
    delete_flg      boolean,
    reason_id       int,

    FOREIGN KEY (reason_id)
        REFERENCES reasons (id),
    FOREIGN KEY (agr_id)
        REFERENCES agreement (id),
    FOREIGN KEY (pause_status_id)
        REFERENCES pause_status (id)

);

Create table reasons
(
    id          int,
    reason_name varchar
);

Create table pause_status --('completed','plane','cancel')
(
    id          int,
    status_name varchar
);
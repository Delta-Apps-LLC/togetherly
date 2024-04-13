create or replace view family_redeemed_reward as
    select p.family_id, r.person_id, r.reward_id, r.quantity, r.timestamp
    from person p
    join redeemed_reward r on r.person_id = p.id;

create or replace view family_assignment as
    select p.family_id, p.id as person_id, c.id as chore_id, a.status
    from person p
    join assignment a on a.person_id = p.id
    join chore c on c.id = a.chore_id;

create or replace view family_chore_completion as
    select complete.id, chore_id, person_id, date_submitted, due_date, is_approved, p.family_id
    from chore_completion complete
    join person p on p.id = complete.person_id;

create or replace view family_chore as
    select p.family_id, p.id as person_id, c.id as chore_id, c.title, c.description, c.points, c.shared, c.date_due, a.status
    from person p
    join assignment a on a.person_id = p.id
    join chore c on c.id = a.chore_id;
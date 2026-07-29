SELECT Activity.player_id, Activity.event_date as first_login
from Activity
LEFT join Activity a1 on Activity.event_date > a1.event_date and Activity.player_id = a1.player_id
where Activity.event_date < a1.event_date or 
a1.event_date is NULL;
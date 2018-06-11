-- BEGIN_PLSQL
CREATE OR REPLACE TRIGGER aud_event_status 
AFTER DELETE OR UPDATE ON event_status
FOR EACH ROW 
DECLARE

l_user_id  users.user_id%TYPE;
l_user_name users.user_name%TYPE;
l_del_yn  VARCHAR2(1) := 'N';

BEGIN
 IF DELETING THEN 
   l_den_yn := 'Y';
   l_user_id := v('APP_USER_ID');
   IF l_user_id IS NOT NULL THEN
    l_user_name := pkg_user.getUserName(l_user_id);
   ELSE
    l_user_name := USER;
   END IF;
 END IF;
 INSERT INTO audit_event_status(
    event_status_id,
    status_name,
    created_by,            
    created_date,          
    updated_by,            
    updated_date,          
    deleted_by,            
    deleted_date)   
 VALUES(
    :OLD.event_status_id,              
    :OLD.event_name,      
    :OLD.created_by,
    :OLD.created_date,
    :OLD.updated_by,
    :OLD.updated_date,
    l_user_name,
    DECODE(l_del_yn,'Y',SYSDATE,NULL)
    );
END;
-- END_PLSQL

--BEGIN_PLSQL
CREATE OR REPLACE TRIGGER bi_event_status
  BEFORE INSERT ON event_status
  FOR EACH ROW
DECLARE 
  l_user_id NUMBER(22);
  l_user_name users.user_name%TYPE;
BEGIN
  l_user_id := v('APP_USER_ID');
  IF l_user_id IS NOT NULL THEN 
     l_user_name := pkg_user.getUserName(l_user_id);
  ELSE
     l_user_name := USER;
  END IF;
  :NEW.CREATED_BY := l_user_name;
  :NEW.CREATED_DATE := SYSDATE;
    IF :NEW.event_status_id IS NULL THEN 
     SELECT event_status_seq.NEXTVAL INTO :NEW.event_status_id FROM DUAL;
  END IF;
END;
--END_PLSQL

--BEGIN_PLSQL
CREATE OR REPLACE TRIGGER bu_event_status
  BEFORE UPDATE ON event_satus
  FOR EACH ROW
DECLARE
  l_user_id    user.user_id%TYPE;
  l_user_name  users.user_name%TYPE;
BEGIN
  l_user_id := v('APP_USER_ID');
  IF l_user_id IS NOT NULL THEN 
     l_user_name := pkg_user.getUserName(l_user_id);
  ELSE
     l_user_name := USER;
  END IF;
  :NEW.UPDATED_BY := l_user_name;
  :NEW.UPDATED_DATE := SYSDATE;
END;
--END_PLSQL

-- BEGIN_PLSQL
CREATE OR REPLACE TRIGGER aud_event
AFTER DELETE OR UPDATE ON event
FOR EACH ROW 
DECLARE

l_user_id  users.user_id%TYPE;
l_user_name users.user_name%TYPE;
l_del_yn  VARCHAR2(1) := 'N';

BEGIN
 IF DELETING THEN 
   l_den_yn := 'Y';
   l_user_id := v('APP_USER_ID');
   IF l_user_id IS NOT NULL THEN
    l_user_name := pkg_user.getUserName(l_user_id);
   ELSE
    l_user_name := USER;
   END IF;
 END IF;
 INSERT INTO audit_event(
    event_id,  
    title,       
    description, 
    date_time,   
    min_cap,     
    max_cap,     
    organiser_id,
    status_id,   
    url,         
    doodle,      
    image,       
    created_by,            
    created_date,          
    updated_by,            
    updated_date,          
    deleted_by,            
    deleted_date)   
 VALUES(
    :OLD.event_id,  
    :OLD.title,       
    :OLD.description, 
    :OLD.date_time,   
    :OLD.min_cap,     
    :OLD.max_cap,     
    :OLD.organiser_id,
    :OLD.status_id,   
    :OLD.url,         
    :OLD.doodle,      
    :OLD.image,           
    :OLD.created_by,
    :OLD.created_date,
    :OLD.updated_by,
    :OLD.updated_date,
    l_user_name,
    DECODE(l_del_yn,'Y',SYSDATE,NULL)
    );
END;
-- END_PLSQL

--BEGIN_PLSQL
CREATE OR REPLACE TRIGGER bi_event
  BEFORE INSERT ON event_status
  FOR EACH ROW
DECLARE 
  l_user_id NUMBER(22);
  l_user_name users.user_name%TYPE;
BEGIN
  l_user_id := v('APP_USER_ID');
  IF l_user_id IS NOT NULL THEN 
     l_user_name := pkg_user.getUserName(l_user_id);
  ELSE
     l_user_name := USER;
  END IF;
  :NEW.CREATED_BY := l_user_name;
  :NEW.CREATED_DATE := SYSDATE;
  IF :NEW.event_id IS NULL THEN 
     SELECT event_seq.NEXTVAL INTO :NEW.event_id FROM DUAL;
  END IF;
END;
--END_PLSQL

--BEGIN_PLSQL
CREATE OR REPLACE TRIGGER bu_event
  BEFORE UPDATE ON event
  FOR EACH ROW
DECLARE
  l_user_id    user.user_id%TYPE;
  l_user_name  users.user_name%TYPE;
BEGIN
  l_user_id := v('APP_USER_ID');
  IF l_user_id IS NOT NULL THEN 
     l_user_name := pkg_user.getUserName(l_user_id);
  ELSE
     l_user_name := USER;
  END IF;
  :NEW.UPDATED_BY := l_user_name;
  :NEW.UPDATED_DATE := SYSDATE;
END;
--END_PLSQL
 
-- BEGIN_PLSQL
CREATE OR REPLACE TRIGGER aud_event_user
AFTER DELETE OR UPDATE ON event_user
FOR EACH ROW 
DECLARE

l_user_id  users.user_id%TYPE;
l_user_name users.user_name%TYPE;
l_del_yn  VARCHAR2(1) := 'N';

BEGIN
 IF DELETING THEN 
   l_den_yn := 'Y';
   l_user_id := v('APP_USER_ID');
   IF l_user_id IS NOT NULL THEN
    l_user_name := pkg_user.getUserName(l_user_id);
   ELSE
    l_user_name := USER;
   END IF;
 END IF;
 INSERT INTO audit_event_user(
    event_user_id,
    event_id,   
    user_id,               
    status_id,             
    organiser_id,          
    created_by,            
    created_date,          
    updated_by,            
    updated_date,          
    deleted_by,            
    deleted_date)   
 VALUES(
    :OLD.event_user_id,          
    :OLD.event_id,   
    :OLD.user_id,      
    :OLD.status_id,    
    :OLD.organiser_id, 
    :OLD.created_by,
    :OLD.created_date, 
    :OLD.updated_by,   
    :OLD.updated_date,
    l_user_name,
    DECODE(l_del_yn,'Y',SYSDATE,NULL)
    );
END;
-- END_PLSQL

--BEGIN_PLSQL
CREATE OR REPLACE TRIGGER bi_event_user
  BEFORE INSERT ON event_user
  FOR EACH ROW
DECLARE 
  l_user_id NUMBER(22);
  l_user_name users.user_name%TYPE;
BEGIN
  l_user_id := v('APP_USER_ID');
  IF l_user_id IS NOT NULL THEN 
     l_user_name := pkg_user.getUserName(l_user_id);
  ELSE
     l_user_name := USER;
  END IF;
  :NEW.CREATED_BY := l_user_name;
  :NEW.CREATED_DATE := SYSDATE;
    IF :NEW.event_user_id IS NULL THEN 
     SELECT event_user_seq.NEXTVAL INTO :NEW.event_user_id FROM DUAL;
  END IF;
END;
--END_PLSQL

--BEGIN_PLSQL
CREATE OR REPLACE TRIGGER bu_event_user
  BEFORE UPDATE ON event_user
  FOR EACH ROW
DECLARE
  l_user_id    user.user_id%TYPE;
  l_user_name  users.user_name%TYPE;
BEGIN
  l_user_id := v('APP_USER_ID');
  IF l_user_id IS NOT NULL THEN 
     l_user_name := pkg_user.getUserName(l_user_id);
  ELSE
     l_user_name := USER;
  END IF;
  :NEW.UPDATED_BY := l_user_name;
  :NEW.UPDATED_DATE := SYSDATE;
END;
--END_PLSQL

-- BEGIN_PLSQL
CREATE OR REPLACE TRIGGER aud_app_user
AFTER DELETE OR UPDATE ON app_user
FOR EACH ROW 
DECLARE

l_user_id  users.user_id%TYPE;
l_user_name users.user_name%TYPE;
l_del_yn  VARCHAR2(1) := 'N';

BEGIN
 IF DELETING THEN 
   l_den_yn := 'Y';
   l_user_id := v('APP_USER_ID');
   IF l_user_id IS NOT NULL THEN
    l_user_name := pkg_user.getUserName(l_user_id);
   ELSE
    l_user_name := USER;
   END IF;
 END IF;
 INSERT INTO audit_app_user(
    app_user_id,
    username,    
    first_name,  
    last_name,   
    email,       
    password,    
    created_by,            
    created_date,          
    updated_by,            
    updated_date,          
    deleted_by,            
    deleted_date)   
 VALUES(
    :OLD.app_user_id,             
    :OLD.username,    
    :OLD.first_name,  
    :OLD.last_name,   
    :OLD.email,       
    :OLD.password,    
    :OLD.created_by,
    :OLD.created_date,
    :OLD.updated_by,
    :OLD.updated_date,
    l_user_name,
    DECODE(l_del_yn,'Y',SYSDATE,NULL)
    );
END;
-- END_PLSQL

--BEGIN_PLSQL
CREATE OR REPLACE TRIGGER bi_app_user
  BEFORE INSERT ON app_user
  FOR EACH ROW
DECLARE 
  l_user_id NUMBER(22);
  l_user_name users.user_name%TYPE;
BEGIN
  l_user_id := v('APP_USER_ID');
  IF l_user_id IS NOT NULL THEN 
     l_user_name := pkg_user.getUserName(l_user_id);
  ELSE
     l_user_name := USER;
  END IF;
  :NEW.CREATED_BY := l_user_name;
  :NEW.CREATED_DATE := SYSDATE;
    IF :NEW.app_user_id IS NULL THEN 
     SELECT app_user_seq.NEXTVAL INTO :NEW.app_user_id FROM DUAL;
  END IF;
END;
--END_PLSQL

--BEGIN_PLSQL
CREATE OR REPLACE TRIGGER bu_app_user
  BEFORE UPDATE ON app_user
  FOR EACH ROW
DECLARE
  l_user_id    user.user_id%TYPE;
  l_user_name  users.user_name%TYPE;
BEGIN
  l_user_id := v('APP_USER_ID');
  IF l_user_id IS NOT NULL THEN 
     l_user_name := pkg_user.getUserName(l_user_id);
  ELSE
     l_user_name := USER;
  END IF;
  :NEW.UPDATED_BY := l_user_name;
  :NEW.UPDATED_DATE := SYSDATE;
END;
--END_PLSQL
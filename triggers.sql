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
  IF :NEW.event_status_seq.NEXTVAL INTO :NEW.event_satus_id FROM DUAL;
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
  
  
TRUNCATE TABLE users, spaces RESTART IDENTITY;

INSERT INTO users ("name", "email_address", "password") VALUES
('John', 'john7268@email.com' , 'cat16$&' ),
('Sally', 'sally87268@gmail.com', 'dogS555!'),
('Amanda','amanda7680@email.com' , 'Nemo*123'),
('Lisa', 'lisa5667@email.com',      'donald77!'),
('Billy', 'billy1991@email.com', 'mickey199%'),
('Tommy', 'tommy1992@hotmail.com', 'greece$2023'),
('Shawn', 'Shawn1996@gmail.com', 'new_y56!!');

INSERT INTO spaces (
  name,
  description,
  price_per_night, 
  available_from, 
  available_to, 
  host_id
  ) 
  VALUES (
    'Camden Flat', 
    'Bright 2 bedroom flat in the heart of camden town.', 
    79.00,
    '2023-01-30',
    '2023-08-25',
    1
    ); 

INSERT INTO spaces (
  name, 
  description, 
  price_per_night, 
  available_from, 
  available_to, 
  host_id) 
  VALUES (
    'St Ives Cottage', 
    'Quaint old brick cottage with wood burner and a pebbles throw away from beach.', 
    119.00,
    '2023-02-15',
    '2023-04-10',
    2
    );
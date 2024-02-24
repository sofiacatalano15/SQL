/*******************************************************************************
							ESERCIZIO 1
*******************************************************************************/

use chinook;
show tables;

select*from album limit 10;

-- Trovate il numero totale di canzoni della tabella Tracks.
select COUNT(*) from track;

-- Trovate i diversi generi presenti nella tabella Genre.
select distinct Name from genre;

-- Recuperate il nome di tutte le tracce e del genere associato.
SELECT track.Name trackName, genre.Name genreName FROM track
	JOIN genre ON track.GenreId = genre.GenreId;
    
-- Recuperate il nome di tutti gli artisti che hanno almeno un album nel database. Esistono artisti senza album nel database?
 select distinct artist.Name from artist
	 JOIN album ON artist.ArtistId = album.ArtistId; -- INNER JOIN: artisti hanno almeno un album nel database 

select distinct artist.Name from artist
	LEFT JOIN album ON artist.ArtistId = album.ArtistId  -- LEFT JOIN: recupera anche artisti senza album 
    WHERE album.ArtistId is null; 
    
-- Recuperate il nome di tutte le tracce, del genere associato e della tipologia di media. Esiste un modo per recuperare il nome della tipologia di media?
select track.Name trackName, genre.Name genreName, mediatype.Name mediatypeName from track
	JOIN genre on  track.GenreId = genre.GenreId 
    JOIN mediatype on track.MediaTypeId = mediatype.MediaTypeId;
    
-- Elencate i nomi di tutti gli artisti e dei loro album.
select artist.Name, album.Title from artist
	 JOIN album ON artist.ArtistId = album.ArtistId; 
     
-- Media delle tracce per album
select album.Title albumTitle, AVG(track.Milliseconds)/1000/60 AVG_track from album
	join track on album.AlbumId = track.AlbumId
    group by album.Title;
    
/*******************************************************************************
							ESERCIZIO 2
*******************************************************************************/

-- Recuperate tutte le tracce che abbiano come genere “Pop” o “Rock”.

select track.Name trackName, genre.Name genreName from track
	JOIN genre on track.GenreId = genre.GenreId
	where genre.Name IN('Pop','Rock');
    
-- Elencate tutti gli artisti e/o gli album che inizino con la lettera “A”.

select album.Title, artist.Name from album
	left join artist on album.ArtistId = artist.ArtistId
    where album.Title like 'A%' AND artist.Name like 'A%';
    
select album.Title, artist.Name from album
	left join artist on album.ArtistId = artist.ArtistId
    where (album.Title like 'A%' OR artist.Name like 'A%') AND album.Title is not null;

-- Recuperate i nomi degli album o degli artisti che abbiano pubblicazioni precedenti all’anno 2000.
-- DATA?

-- Elencate tutte le tracce che hanno come genere “Jazz” o che durano meno di 3 minuti.
select track.Name trackName, genre.Name genreName, track.Milliseconds/60000 timeTrack from track
	join genre on track.GenreId = genre.GenreId
    where genre.Name = 'Jazz' 
		OR track.Milliseconds/60000 < 3;
        
-- oppure
select track.Name trackName, genre.Name genreName, track.Milliseconds timeTrack from track
	join genre on track.GenreId = genre.GenreId
    where genre.Name = 'Jazz' 
		OR track.Milliseconds < 180000;
        
-- Recuperate tutte le tracce più lunghe della durata media
select avg(Milliseconds) avg_track from track;
select * from track 
where Milliseconds > 
		(select AVG(Milliseconds) from track);

select Name, CONCAT(FLOOR(Milliseconds/60000), ':', LPAD(floor(Milliseconds % 60000)/1000), 2, '0')) AS Durata
from track
where Milliseconds > 
		(select AVG(Milliseconds) from track);


-- Individuate i generi che hanno tracce con una durata media maggiore di 4 minuti.
/*select genre.Name genreName from genre
	JOIN track on genre.GenreId = track.GenreId
	where genre.Name IN
		(select track.GenreId from track group by track.GenreId having avg(track.Milliseconds) > 240000);*/

select genre.Name genreName from genre
	JOIN track on genre.GenreId = track.GenreId
    group by genre.Name
    having avg(track.Milliseconds) > 240000;
    
    
-- Individuate gli artisti che hanno rilasciato più di un album.
 select artist.Name artistName, count(album.Title) n_album from artist
	JOIN album ON artist.ArtistId = album.ArtistId
	group by artist.Name
	Having count(album.Title) > 1;

-- Trovate la traccia più lunga in ogni album.
select album.Title albumTitle, MAX(track.Milliseconds)/60000 maxTrack from album
	join track on album.AlbumId = track.AlbumId
    group by album.Title;
    
select album.Title from album
	join track on album.AlbumId = track.AlbumId
    group by album.Title;  

-- Individuate gli album che hanno più di 20 tracce e mostrate il nome dell’album e il numero di tracce in esso contenute.
select album.Title albumTitle, count(track.TrackId) n_track from album
	join track on album.AlbumId = track.AlbumId
    group by album.Title
    Having count(track.TrackId) > 20;
    
/*************************************************************************************************
										ESERCIZIO 3
**************************************************************************************************/

-- Elencate il numero di tracce per ogni genere in ordine discendente, escludendo quei generi che hanno meno di 10 tracce.

select genre.GenreId, genre.Name, count(track.TrackId) as nTracks
from track
join genre using (GenreId)
group by genre.GenreId
having nTracks >= 10
order by nTracks desc;

-- Trovate le tre canzoni più costose.
select UnitPrice maxPrice, Name NameTrack from track
order by maxPrice desc
limit 3;

-- Elencate gli artisti che hanno canzoni più lunghe di 6 minuti.

select artist.Name NameArtist
from artist
join album using(ArtistId)
join track using(AlbumId)
where track.Milliseconds/60000 > 6
group by artist.Name;

-- Individuate la durata media delle tracce per ogni genere.

select genre.Name, FLOOR(AVG(track.Milliseconds/60000)) as Minutes, 
ROUND((AVG(Track.Milliseconds/60000)-FLOOR(AVG(Track.Milliseconds/60000)))*60) AS Seconds
from genre
join track using(GenreId)
group by genre.Name;


-- Elencate tutte le canzoni con la parola “Love” nel titolo, ordinandole alfabeticamente prima per genere e poi per nome.
select track.TrackId, genre.Name genreName, track.Name trackName from track
join genre using (GenreId)
where track.Name like '%Love%'
order by genre.Name, track.Name ASC;

-- Trovate il costo medio per ogni tipologia di media.
SELECT 
    mediatype.Name nameMedia, AVG(track.UnitPrice) AS avgPrice
FROM
    track
        JOIN
    mediatype USING (MediaTypeId)
GROUP BY nameMedia

-- Individuate il genere con più tracce.

select genre.Name, count(track.Name) nTracks
from genre 
join track using(GenreId)
group by genre.Name
order by nTracks DESC
limit 1;

-- Trovate gli artisti che hanno lo stesso numero di album dei Rolling Stones.


SELECT 
    artist.Name, count(album.AlbumId) nAlbum
FROM
    album
        JOIN
    artist USING (ArtistId)
    group by artist.Name
Having
  nAlbum  = 
(SELECT 
    COUNT(album.AlbumId) nAlbumRS
FROM
    album
        JOIN
    artist USING (ArtistId)
WHERE
    artist.Name LIKE 'The Rolling Stones'
GROUP BY artist.Name)



-- Trovate l’artista con l’album più costoso.
select artist.Name NameArtist, SUM(track.UnitPrice) totalAlbum, album.Title albumTitle
from artist
join album using(ArtistId)
join track using(AlbumId)
group by track.AlbumId
order by totalAlbum DESC
LIMIT 1;


Select album.Title, track.Name, track.UnitPrice, artist.Name from artist
join album using(ArtistId)
join track using(AlbumId)
where album.Title = 'Greatest Hits'



SET client_encoding = 'UTF8';
SET client_min_messages = warning;

DROP DATABASE IF EXISTS "bronnikova_205";

CREATE DATABASE "bronnikova_205" WITH ENCODING = 'UTF8';

\c "bronnikova_205"

SET client_encoding = 'UTF8';
SET client_min_messages = warning;

CREATE TABLE public.album (
    albumid integer NOT NULL,
    artistid integer NOT NULL,
    name text NOT NULL,
    description text,
    year integer,
    numberoftracks integer,
    CONSTRAINT album_description_length_chk CHECK ((length(description) <= 500)),
    CONSTRAINT album_name_length_chk CHECK ((length(name) <= 50)),
    CONSTRAINT album_numberoftracks_maxval_chk CHECK ((numberoftracks <= 500)),
    CONSTRAINT album_year_chk CHECK ((year <= (date_part('year'::text, CURRENT_DATE))::integer))
);


ALTER TABLE public.album OWNER TO postgres;

COPY public.album (albumid, artistid, name, description, year, numberoftracks) FROM stdin;
1	14	Come Over When Youre Sober, Pt. 1	The only to be released during lifetime	2017	7
2	13	Born to Die	Second studio album.	2012	12
3	13	Ultraviolence	The sound of Ultraviolence was characterized as psychedelic rock, dream pop with some elements of blues rock, soft rock and indie rock.	2014	11
4	3	The Patrick Wolf EP	The debut EP.	2002	4
5	3	Wind in the Wires	Wind in the Wires received general acclaim. At Metacritic, which assigns a normalized rating out of 100 to reviews from mainstream critics, the album received an average score of 80, based on 20 reviews, which indicates generally favorable reviews.	2005	13
6	5	Alla	The second studio album made in USSR.	1981	4
7	10	The National	The album features guest contributions from forthcoming member Bryce Dessner, with his brother Aaron noting, When we recorded [the album], my brother wasnt even in the band. We made the record before we ever played a show. We did it just to do it.	2001	12
8	1	Ceremonials	Received generally positive reviews from music critics, who drew comparisons to artists such as Kate Bush, while also praising the instrumentation	2011	12
9	6	With Russia From Love	The first studio album.	2014	7
10	6	Antipositive, Pt. 1	Album received mostly positive rewiews.	2018	10
11	2	The Hat	Most controversial album in the past 100 years	2011	5
12	1	How big How blue How beautiful	At Metacritic, which assigns a weighted mean rating out of 100 to reviews from mainstream critics, the album received an average score of 77, based on 31 reviews.	2015	11
13	1	High As Hope	Received positive reviews from music critics upon release, with critics praising Welchs vocals, her themes, and the minimalist production.	2018	10
14	1	Lungs	Received generally positive reviews from music critics.	2009	13
15	8	Visions	 At Metacritic, which assigns a weighted mean rating out of 100 to reviews from mainstream critics, the album received an average score of 80, based on 42 reviews	2012	13
\.


CREATE SEQUENCE public.album_albumid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.album_albumid_seq OWNER TO postgres;

ALTER SEQUENCE public.album_albumid_seq OWNED BY public.album.albumid;

CREATE SEQUENCE public.album_artistid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.album_artistid_seq OWNER TO postgres;

ALTER SEQUENCE public.album_artistid_seq OWNED BY public.album.artistid;

ALTER TABLE ONLY public.album ALTER COLUMN albumid SET DEFAULT nextval('public.album_albumid_seq'::regclass);

ALTER TABLE ONLY public.album ALTER COLUMN artistid SET DEFAULT nextval('public.album_artistid_seq'::regclass);


SELECT pg_catalog.setval('public.album_albumid_seq', 15, true);

SELECT pg_catalog.setval('public.album_artistid_seq', 1, false);



CREATE TABLE public.artist (
    artistid integer NOT NULL,
    name text NOT NULL,
    year integer,
    description text,
    website text,
    CONSTRAINT artist_description_length_chk CHECK ((length(description) <= 500)),
    CONSTRAINT artist_name_length_chk CHECK ((length(name) <= 50)),
    CONSTRAINT artist_website_length_chk CHECK ((length(website) <= 60)),
    CONSTRAINT artist_year_chk CHECK ((year <= (date_part('year'::text, CURRENT_DATE))::integer))
);


ALTER TABLE public.artist OWNER TO postgres;

COPY public.artist (artistid, name, year, description, website) FROM stdin;
8	Grimes	2007	Claire Elise Boucher, known professionally as Grimes, is a Canadian singer, songwriter, record producer and visual artist.	grimesmusic.com
13	Lana Del Rey	2011	Elizabeth Woolridge Grant, known professionally as Lana Del Rey, is an American singer, songwriter, and record producer.	lanadelrey.com
14	Lil Peep	2004	Gustav Elijah Ahr, known professionally as Lil Peep, was an American rapper, singer and songwriter. He was known for being dead.	lilpeep.com
15	Lil Tracy	2012	Jazz Ishmael Butler, known professionally as Lil Tracy or simply Tracy, is an American rapper, singer and songwriter.	\N
1	Florence and the Machine	2007	An English indie rock band that formed in London, consisting of vocalist Florence Welch, keyboardist Isabella Summers, and a collaboration of other musicians.	florenceandthemachine.net
2	The Horrors	2005	An English rock band formed in Southend-on-Sea in 2005, consisting of lead vocalist Faris Badwan, guitarist Joshua Hayward, keyboardist and synthesiser player Tom Cowan (also known as Tom Furse),  bassist Rhys Webb, and drummer and percussionist Joe Spurgeon.	thehorrors.co.uk
3	Patrick Wolf	2000	An English singer-songwriter from South London. He uses a wide variety of instruments in his music, most commonly the ukulele, piano, and viola.	patrickwolf.com
4	The Beatles	1960	English rock band formed in Liverpool in 1960. With members John Lennon, Paul McCartney, George Harrison and Ringo Starr, they became widely regarded as the foremost and most influential music band in history.	thebeatles.com
5	Alla Pugacheva	1965	Soviet and Russian musical performer. Born in Vitebsk.	allaradio.ru
6	Little Big	2013	Russian rave band, founded in 2013 in St. Petersburg. The set includes Ilya Ilich Prusikin, Sergey Gokk Makarov, Sophia Tayurskaya, Olympia Ivleva and Anton Boo Lissov.	littlebig.band
7	Metallica	1981	American heavy metal band. The band was formed in 1981 in Los Angeles, California by drummer Lars Ulrich and vocalist/guitarist James Hetfield, and has been based in San Francisco, California for most of its career.	metallica.com
9	Majical Cloudz	2010	Canadian music group from Montreal consisting of singer-songwriter Devon Welsh, and variously Matthew E. Duffy and Matthew Otto.	majicalcloudz.tumblr.com
10	The National	1999	American rock band from Cincinnati, Ohio, formed in 1999. The band consists of Matt Berninger, Aaron Dessner, Bryce Dessner, Scott Devendorf and Bryan Devendorf.	thenational.ae
11	Full of Hell	2009	American band from Ocean City, Maryland and Central Pennsylvania.	\N
12	Nadezhda Kadysheva	1998	Russian singer, soloist of the Zolotoe Koltso. Honorary Citizen of Bugulma. Peoples Artist of Russia, Peoples Artist of Mordovia, Honored Artist of Tatarstan.	\N
\.

CREATE SEQUENCE public.artist_artistid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.artist_artistid_seq OWNER TO postgres;

ALTER SEQUENCE public.artist_artistid_seq OWNED BY public.artist.artistid;

ALTER TABLE ONLY public.artist ALTER COLUMN artistid SET DEFAULT nextval('public.artist_artistid_seq'::regclass);

SELECT pg_catalog.setval('public.artist_artistid_seq', 15, true);




CREATE TABLE public.artistgenre (
    genreid integer NOT NULL,
    artistid integer NOT NULL
);


ALTER TABLE public.artistgenre OWNER TO postgres;

COPY public.artistgenre (genreid, artistid) FROM stdin;
2	1
3	1
1	2
5	3
8	3
1	4
2	5
2	6
1	7
3	8
5	9
1	10
6	10
1	11
2	12
2	13
6	13
8	14
4	14
4	15
8	15
\.


CREATE SEQUENCE public.artistgenre_artistid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.artistgenre_artistid_seq OWNER TO postgres;

ALTER SEQUENCE public.artistgenre_artistid_seq OWNED BY public.artistgenre.artistid;

CREATE SEQUENCE public.artistgenre_genreid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.artistgenre_genreid_seq OWNER TO postgres;

ALTER SEQUENCE public.artistgenre_genreid_seq OWNED BY public.artistgenre.genreid;

ALTER TABLE ONLY public.artistgenre ALTER COLUMN genreid SET DEFAULT nextval('public.artistgenre_genreid_seq'::regclass);

ALTER TABLE ONLY public.artistgenre ALTER COLUMN artistid SET DEFAULT nextval('public.artistgenre_artistid_seq'::regclass);

SELECT pg_catalog.setval('public.artistgenre_artistid_seq', 1, false);

SELECT pg_catalog.setval('public.artistgenre_genreid_seq', 1, false);



CREATE TABLE public.genre (
    genreid integer NOT NULL,
    name text NOT NULL,
    description text,
    CONSTRAINT genre_description_length_chk CHECK ((length(description) <= 500)),
    CONSTRAINT genre_name_length_chk CHECK ((length(name) <= 20))
);

ALTER TABLE public.genre OWNER TO postgres;

COPY public.genre (genreid, name, description) FROM stdin;
1	Rock	The sound of rock is traditionally centered on the amplified electric guitar, which emerged in its modern form in the 1950s with the popularity of rock and roll.
2	Pop	The terms "popular music" and "pop music" are often used interchangeably, although the former describes all music that is popular and includes many different styles.
3	Art Pop	Style of pop music influenced by pop arts integration of high and low culture, and which emphasizes the manipulation of signs, style, and gesture over personal expression
4	Rap	Rapping is a musical form of vocal delivery that incorporates "rhyme, rhythmic speech, and street vernacular", which is performed or chanted in a variety of ways, usually over a backbeat or musical accompaniment. 
5	Indie	Originally used to describe independent record labels
6	Sadcore	Genre is characterised by bleak lyrics, downbeat melodies and slower tempos
7	Emo	Genre of very emotional music, an emphasis on emotional expression, sometimes through confessional lyrics.
8	Alternative	Songs  lyrics tend to address topics of social concern, such as drug use, depression, suicide, and environmentalism
\.



CREATE SEQUENCE public.genre_genreid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.genre_genreid_seq OWNER TO postgres;

ALTER SEQUENCE public.genre_genreid_seq OWNED BY public.genre.genreid;

ALTER TABLE ONLY public.genre ALTER COLUMN genreid SET DEFAULT nextval('public.genre_genreid_seq'::regclass);

SELECT pg_catalog.setval('public.genre_genreid_seq', 8, true);



CREATE TABLE public.track (
    trackid integer NOT NULL,
    albumid integer NOT NULL,
    name text,
    tracklength interval,
    lyrics text,
    CONSTRAINT track_name_length_chk CHECK ((length(name) <= 50)),
    CONSTRAINT track_tracklength_duration_chk CHECK ((tracklength < '01:00:00'::interval))
);

ALTER TABLE public.track OWNER TO postgres;


CREATE SEQUENCE public.track_albumid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.track_albumid_seq OWNER TO postgres;


COPY public.track (trackid, albumid, name, tracklength, lyrics) FROM stdin;
1	2	Sammertime Sadness	00:04:30	I got that summertime, summertime sadness\\n
2	10	Beautifol Head	00:03:30	It could just be us two\\n\nIt could just be us two\\n\nWe could make some plans\\n\nI could laugh at your jokes that I dont understand\\n\nMake demands of me\\n\nIts not just your beautiful\\n\nIts not just your beautiful head\\n\nThat makes me feel this way\\n
3	7	American Mary	00:03:55	Give my jewels to the army, my silverware and jeans\\n\nGive my love to your family, tell them anything\\n\nGive yourself to anyone, give yourself away\\n\nDont be a nightingale for anyones space to fill
4	8	Intro	00:02:25	\N
5	8	Genesis	00:05:43	My heart, I never be, I never see, I never know\\n\nOh, heart, and then it falls, and then I fall, and then I know\\n\nMy heart, I never be, I never see, I never know\\n\nOh, heart, and then it falls, and then I fall, and then I know\\n\nMy heart, I never be, I never see, I never know\\n\nOh, heart, and then it falls, and then I fall, and then I know\\n\nMy heart, I never be, I never see, I never know\\n\nOh, heart, and then it falls, and then I fall, and then I know
6	8	Eight	00:03:03	Go where you want to go\\n\nWhen you get there youll be wishing you were by the phone\\n\nOh, go where you want to go\\n\nBecause the sky is lifting\\n\nAnd I cant stop drifting along
7	8	Visiting body	00:02:54	So, so, so, so, bring it all back\\n\nI would start to see that I was scared to see it\\n\n(Bring it all home, bring it all home, bring it all home\\n\nOh, oh, Im a ghost, ghost)\\n\nSo, so, so, so, bring it all back\\n\nI would start to see that I was scared to see it\\n\n(Bring it all home, bring it all home, bring it all home
8	5	Wind in the Wires	00:04:09	Wind in the wires\nIts the sigh of wild electricity\nIm on the edge of a cliff\nSurpassing\nComfort and security\nBut here comes a gale \nA crippling anger \nSea birds are blown \nInto the rocks \nGrace is lost to thunder
9	5	The Libertine	00:04:19	The circus girl fell off her horse and now shes paralyzed\nThe hitchhiker was bound and gagged, raped on the roadside\nThe libertine is locked in jail\nThe pirate sunk and broke his sail\n\nBut I still have to go
10	5	The Gypsy King	00:03:51	Drawing a line\nBut how do I follow? \nWhat road to be choosing? \nDo I follow the star \nOr the gypsy king? \n\nI recall when I was younger \nThere was a fire \nTo travel the world \nAnd shine with a passion \n\nBut as ambition shoots blank \nDay by Day \nOn a train from Edinburgh \nTo the Kings Cross rain
11	5	Tristan	00:02:11	I am the tragedy.\nI am the tragedy.\nAnd the heroine.\nI am lost And I am rescuing.\n\nThe storm is come.\nAnd I am following.\n\nMy name is Tristan.\nAnd I am alive.\n\nForever young.\nI come from God knows where.\nCos now Im here.\nWithout a hope or care.\n\nI am trouble.\nAnd I am troubled too.\n\nMy name is Tristan.\nAnd I am alive.\n\nSorrow by name.\nAnd sorrow by nature.\nWorking for joy.\nOn overtime.\n\nStuck on a line.\nOf misadventure.\nI fear no crime.\n\nI am the victim.\nAnd the murderer.\nYou speak of love.\nBut Ive never heard of her.
12	5	Eulogy	00:05:11	So long, my friend\nThere must always be an end\nBut all our love and life and song\nCarries on, I carry it on\n\nNow the lightships are guiding you\nOver the sea\nAnd the lightships are sailing you\nAway from me
13	10	Faradenza	00:05:16	Denza, Faradenza\nLa bokka de la cokka\nGrande love-ua and ribaua villa vida loca\nGusto rico dante\nPereto presto power\nKarma denza purra kawa konnichiwa-ua\nRa-ta-ta-ta\nRa-ta-ta-ta-ta\nRa-ta-ta-ta\nDenza Faradenza\nRa-ta-ta-ta\nRa-ta-ta-ta-ta\nRa-ta-ta-ta\nDenza Faradenza\nDenza, denza\nDenza Faradenza\nDenza, denza\nDenza Faradenza (yama!)\nDenza (denza), denza (denza)\nDenza Faradenza\nDenza (denza), denza (denza)\nDenza Faradenza\nHa!\nHa!\nDenza Faradenza\nHa!\nYama!\nHa!\nDenza Faradenza\n(Denza Faradenza)\n(Denza Faradenza)
14	11	Town	00:04:28	Little Bo-Peep fell fast asleep,\nAnd dreamt she heard them bleating;\nBut when she awoke, she found it a joke,\nFor they were still all fleeting.
15	4	Wolf Song	00:05:01	Walk tall beneath these trees, boy\nYou monolith, not scarred by fallout\nUs wolves were right behind you\nAnd Lucifer will never find you, oh no\n\nThe moon, let it guide you\nWhen Selene comes, well all know how to fight\nDear Fenrir, my savior\nCome and eat the ones, we know who taste the best
16	8	What the Water Gave Me	00:03:07	Time it took us\nTo where the water was\nThats what the water gave me\nAnd time goes quicker\nBetween the two of us\nOh, my love, dont forsake me\nTake what the water gave me\n\nLay me down\nLet the only sound\nBe the overflow\nPockets full of stones
17	8	Leave My Body	00:03:33	Im gonna leave my body\n(moving up to higher ground)\nIm gonna lose my mind\n(History keeps pulling me down)\nSaid Im gonna leave my body\n(moving up to higher ground)\nIm gonna lose my mind\n(History keeps pulling me, pulling me down)\n\nI dont need a husband, dont need no wife\nAnd dont need the day, I dont need the night\nAnd I dont need the birds let them fly away\nAnd I dont want the clouds, they never seem to stay
\.

ALTER SEQUENCE public.track_albumid_seq OWNED BY public.track.albumid;

CREATE SEQUENCE public.track_trackid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.track_trackid_seq OWNER TO postgres;

ALTER SEQUENCE public.track_trackid_seq OWNED BY public.track.trackid;

ALTER TABLE ONLY public.track ALTER COLUMN trackid SET DEFAULT nextval('public.track_trackid_seq'::regclass);

ALTER TABLE ONLY public.track ALTER COLUMN albumid SET DEFAULT nextval('public.track_albumid_seq'::regclass);

SELECT pg_catalog.setval('public.track_albumid_seq', 1, false);

SELECT pg_catalog.setval('public.track_trackid_seq', 17, true);


ALTER TABLE ONLY public.artist
    ADD CONSTRAINT artist_description_unq UNIQUE (description);

ALTER TABLE ONLY public.artist
    ADD CONSTRAINT artist_name_unq UNIQUE (name);

ALTER TABLE ONLY public.artist
    ADD CONSTRAINT artist_pkey PRIMARY KEY (artistid);


ALTER TABLE ONLY public.album
    ADD CONSTRAINT album_description_unq UNIQUE (description);

ALTER TABLE ONLY public.album
    ADD CONSTRAINT album_pkey PRIMARY KEY (albumid);

ALTER TABLE ONLY public.album
    ADD CONSTRAINT album_artistid_fkey FOREIGN KEY (artistid) REFERENCES public.artist(artistid);



ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_name_unq UNIQUE (name);

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (genreid);


ALTER TABLE ONLY public.artistgenre
    ADD CONSTRAINT artistgenre_pkey PRIMARY KEY (genreid, artistid);

ALTER TABLE ONLY public.artistgenre
    ADD CONSTRAINT artistgenre_artistid_fkey FOREIGN KEY (artistid) REFERENCES public.artist(artistid);

ALTER TABLE ONLY public.artistgenre
    ADD CONSTRAINT artistgenre_genreid_fkey FOREIGN KEY (genreid) REFERENCES public.genre(genreid);



ALTER TABLE ONLY public.track
    ADD CONSTRAINT track_pkey PRIMARY KEY (trackid);

ALTER TABLE ONLY public.track
    ADD CONSTRAINT track_albumid_fkey FOREIGN KEY (albumid) REFERENCES public.album(albumid);

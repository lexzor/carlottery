-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 17, 2023 at 11:26 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `loterie`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `upassword` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `access` int(11) NOT NULL DEFAULT 0,
  `login_key` varchar(33) NOT NULL,
  `cart` text DEFAULT NULL,
  `firstName` text NOT NULL,
  `lastName` text NOT NULL,
  `phoneNumber` text NOT NULL,
  `companyName` text NOT NULL,
  `country` text NOT NULL,
  `streetName` text NOT NULL,
  `houseNumber` text NOT NULL,
  `postCode` text NOT NULL,
  `city` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `email`, `upassword`, `username`, `access`, `login_key`, `cart`, `firstName`, `lastName`, `phoneNumber`, `companyName`, `country`, `streetName`, `houseNumber`, `postCode`, `city`) VALUES
(39, 'super.alexx@yahoo.com', 'parolamea', 'lexzor', 1, 'e9ae7a34b7dea9fdb0ce73182aa1e251', NULL, 'Nicolae', 'Alex', '0740222107', '', 'Romania', 'strada', 'nr8', '277701', 'Craiova'),
(51, 'lexzor_hnspro11@yahoo.com', 'lexzor', 'l3231231', 0, 'daace68ffcb84fe1036f017a689ac174', NULL, '', '', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `configuration`
--

CREATE TABLE `configuration` (
  `type` varchar(64) NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `configuration`
--

INSERT INTO `configuration` (`type`, `content`) VALUES
('terms', '<p><strong class=\"ql-size-huge\">1. Promotor-ul:</strong></p><p><strong>1.1</strong> Organizatorul este: CarScor Limited, Numărul de înregistrare al companiei 11320154 și sediul înregistrat se află la Goodrich House, 39 Moor Street, Worcester, Worcestershire, Anglia WR1 3DB.</p><p><strong>1.2</strong> Dacă doriți să ne contactați pentru orice motiv, vă rugăm să ne trimiteți un email la adresa <strong>info@carscor.com</strong>.</p><p><br></p><h2><strong>2. Concursul</strong></h2><p>2.1 Acești termeni și condiții se aplică tuturor concursurilor listate pe website-ul Promotor-ului la carscor.com („Website-ul”).</p><p>2.2 Toate concursurile sunt bazate pe abilități, iar o taxă de participare trebuie plătită de fiecare dată când participați. În cazul în care Organizatorul oferă o întrebare ușoară sau o întrebare cu alegere multiplă, există o rută de intrare gratuită disponibilă.</p><p>2.3Pentru a avea șansa de a câștiga, toți cei care participă la concurs („Participanții”) vor trebui să răspundă corect la o întrebare sau să rezolve o problemă stabilită de Promotor („Întrebarea de Concurs”). \"</p><p><br></p><p><strong><u>3. Cum să participi:</u></strong></p><p><br></p><p>3.1Concursul se va desfășura începând cu datele de deschidere și de închidere specificate pe site, inclusiv. Aceste date vor fi denumite „ Data de deschidere ” și „Data de închidere”. Toate orele și datele la care se face referire sunt orele și datele din Bucharest / Romania.</p><p><br></p><p>3.2 Dacă este absolut necesar să facă acest lucru, Promotorul își rezervă dreptul de a modifica Datele de Deschidere și Închidere. Dacă Promotorul modifică Data Deschiderii și/sau Data Închiderii unei competiții, noile detalii vor fi afișate pe Site. Promotorul nu va prelungi Data de Închidere pur și simplu pentru a vinde mai multe intrări.</p><p><br></p><p>3.3 Toate înscrierile la concurs trebuie să fie primite de către Promotor până cel târziu la ora specificată la Data Închiderii. Toate înscrierile la concurs primite după ora specificată la Data de închidere sunt automat descalificate și nu se vor acorda rambursări.</p><p>3.4 Numărul maxim de înscrieri la concurs va fi menționat pe site. Numărul de intrări pe care le puteți face poate fi limitat dacă este atins numărul maxim de intrări.</p><p>Înscrierile, inclusiv intrările gratuite, sunt limitate de persoană per competiție. Înscrierile pot fi limitate dacă se atinge numărul maxim de înscrieri pentru concurs.</p><p><br></p><p>4. Pentru a participa la concurs:</p><p><br></p><p>4.1. Accesați site-ul web și vizualizați Competiția la care doriți să participați; apoi</p><p>4.2. Introduceți răspunsul dvs. la intrebarea concursului \"quizz\" - participanții trebuie să răspundă corect la întrebări pentru a participa la premiul final.</p><p>4.3. Selectați numărul necesar de intrări și treceți la checkout; apoi</p><p>4.4. Autentificați-vă sau înregistrați-vă dacă nu v-ați autentificat deja; apoi</p><p>4.5. Acceptați Termenii și condițiile și finalizați achiziția.</p><p>4.6. Utilizarea PayPal este restricționată numai persoanelor cu vârsta peste 18 ani și rezidenților din Romania</p><p>4.7 Promotorul va trimite confirmarea că înscrierea dvs. a fost primită.</p><p>4.8 Promotorul nu va accepta responsabilitatea pentru înscrierile la concurs care nu sunt finalizate cu succes, sunt pierdute sau sunt întârziate indiferent de cauză, inclusiv, de exemplu, ca urmare a oricărei defecțiuni a echipamentului, defecțiuni tehnice, sisteme, satelit, rețea, server, hardware de computer. sau defecțiuni software de orice fel.</p><p>4.9. Utilizatorii care nu răspund corect vor primi un e-book online sau alt premiu tangibil. De asemenea, utilizatorii vor putea obține puncte, punctele pot fi acumulate atât de utilizatorii care răspund corect la întrebările jocului, cât și de cei care nu reușesc să răspundă corect. Însă, punctele primite de aceștia din urmă vor fi mai mici.[/color]</p><p>4.10. Utilizatorii vor putea obține puncte și în alte moduri, cum ar fi înregistrarea pe website (\"carscor.com\"), și invitarea de prieteni, precum și oferirea de feedback-uri. Punctele acumulate pot fi apoi folosite pentru a obține diverse beneficii, inclusiv participarea la viitoare extrageri organizate special pentru utilizatorii care au acumulat puncte.</p><p>4.11. Prin achiziționarea de înscrieri și trimiterea unei înscrieri la concurs, încheiați un contract cu Promotorul și sunteți de acord să respectați acești termeni și condiții.</p><p>4.12. Te poți înscrie gratuit la concurs respectând următoarele condiții:</p><p>5.1 Trimiteți intrarea dvs. prin poșta de clasa întâi sau a doua la Promotor la adresa următoare: DCG, PO Box 243, Droitwich, WR9 1DY;</p><p>5.2 Intrările livrate personal nu vor fi acceptate și nu vor fi incluse în tragerea la sorți;</p><p>5.3 Includeți cu intrarea dvs. următoarele informații:</p><p>- Numele complet și data nașterii;</p><p>- Adresa dvs.;</p><p>- Un număr de telefon de contact și o adresă de e-mail; și</p><p>- Răspunsul dvs. (corect) la întrebarea concursului.</p><p>- Intrările incomplete sau ilegibile vor fi descalificate;</p><p>5.4 Puteți face mai multe intrări gratuite pentru orice concurs (până la limita impusă de Promotor), dar fiecare intrare gratuită trebuie să fie trimisă și postată la Promotor separat. Intrările în vrac într-un singur plic nu vor fi acceptate ca intrări multiple și, dacă este primită o intrare în vrac, aceasta va fi considerată o singură intrare;</p><p>5.5 Prin participarea la concurs, confirmați că sunteți eligibil să participați și acceptați acești termeni și condiții;</p><p>5.6 Intrarea dvs. trebuie să fie primită de Promotor înainte de data limită. Intrările primite după data limită nu vor fi incluse în tragerea la sorți. Dovezile de trimitere prin poștă nu garantează că veți fi inclus în tragerea la sorți;</p><p>5.7 Dacă numărul de intrări primite atinge o anumită limită înainte ca intrarea dvs. gratuită să fie primită, nu veți fi inclus în tragerea la sorți.</p><p><br></p><p>6. Alegerea unui câștigător</p><p><br></p><p>6.1 Toți participanții care răspund corect la întrebarea competiției vor fi incluși într-o extragere și câștigătorul va fi ales prin extragere aleatorie cu generatorul de numere Google Random (\"Rezultatul final nu depinde de o decizie a operatorului sau de o anumita actiune a utilizatorului, rezultatul final este complet aleatoriu si nu poate fi infulentat de nicio parte implicata.\")</p><p>6.2 Extragerea aleatorie va avea loc cât mai curând posibil și, în orice caz, în termen de 7 zile de la data închiderii (\"Data extragerii\").</p><p>6.3 Toți participanții vor avea numele și numerele de înregistrare incluse într-un registru care poate fi publicat pe site-ul web și pot fi vizibile în timpul extragerii live. Dacă nu doriți ca numele dumneavoastră să fie inclus în acest registru, trebuie să contactați Promotorul prin e-mail la info@carscor.com cât mai curând posibil după ce ați completat înregistrarea și în orice caz, cu cel puțin 48 de ore înainte de extragerea live.</p><p>Pentru ajutor cu înregistrarea, vă rugăm să ne contactați la 074035955924 sau prin e-mail la info@carscor.com</p><p>6.4 Extragerile de premii sunt organizate în mod aleatoriu și nu sunt bazate pe nicio formă de jocuri de noroc sau de pariere.</p><p>6.5 Participanții care răspund corect la întrebările competiției și care plătesc taxa de participare sunt incluși automat în extragerea finală, fără nicio influență asupra șanselor lor de a câștiga.</p><p><br></p><p><br></p><p>7. Eligibilitatea</p><p>7.1 Concursul este deschis tuturor rezidenților din Romania, cu vârsta de 18 ani sau peste aceasta, cu excepția:</p><p><br></p><p>- Angajaților Promotorului;</p><p>- Angajaților agenților sau furnizorilor Promotorului, care sunt profesional conectați cu concursul sau cu administrarea acestuia; sau</p><p>- Membrii familiei sau ai gospodăriilor imediate ale celor menționați mai sus la punctele (a) și (b).</p><p>7.2 Prin participarea la concurs, confirmați că sunteți eligibil să o faceți și să revendicați orice premiu pe care l-ați putea câștiga. Promotorul poate solicita dovada că sunteți eligibil să participați la concurs și să revendicați premiul. Dacă nu furnizați Promotorului astfel de dovezi sau alte informații pe care aceștia le pot solicita într-un timp rezonabil, puteți fi descalificat din concurs.</p><p>7.3 Promotorul nu va accepta înscrieri la concurs care sunt:</p><p>- generate automat de calculator; sau incomplete.</p><p>7.4 Promotorul își rezervă toate drepturile de a vă descalifica dacă conduita dvs. este contrară spiritului sau intenției concursului. Aceasta include și dacă sunteți nepoliticos sau abuziv față de Promotor sau oricine asociat cu aceștia.</p><p>7.5 Sub rezerva clauzei 11.3 de mai jos, nu se vor oferi rambursări ale taxei de înscriere în niciun caz, inclusiv:</p><p>- dacă, după înscrierea dvs. la concurs, aflați ulterior că nu sunteți eligibil să participați la concurs sau să revendicați Premiul;</p><p>- dacă, după înscrierea dvs. la concurs, criteriile de eligibilitate pentru participarea la concurs sau revendicarea Premiului se schimbă și nu mai sunteți eligibil; sau</p><p>- dacă sunteți descalificat din concurs de către Promotor din orice motiv.</p><p>7.6 Dacă Participanții angajează în:</p><p>- orice formă de fraudă (reală sau aparentă);</p><p>- reprezentare frauduloasă;</p><p>- ascundere frauduloasă;</p><p>- hacking sau interferență cu funcționarea corectă a site-ului web; sau</p><p>- modificarea sau utilizarea neautorizată a oricărui cod care constituie site-ul web</p><p>- toate intrările lor vor fi declarate nule, nu se vor oferi rambursări, iar aceștia pot fi împiedicați să participe în viitoarele concursuri.</p><p><br></p><p><br></p><p>8. Premiul</p><p><br></p><p>8.1 Premiul pentru fiecare competiție este descris pe site-ul web („ Premiul ”). Detaliile Premiului sunt, după cunoștințele, informațiile și convingerile Promotorului, corecte la Data Deschiderii.</p><p>8.2 Premiile sunt în funcție de disponibilitate. Promotorul își rezervă dreptul de a înlocui orice premiu cu un premiu de valoare egală sau mai mare. În cazul în care orice detalii ale Premiului se modifică, Promotorul se va strădui să actualizeze Site-ul cât mai curând posibil.</p><p>8.3 Promotorul nu face declarații și nu oferă nicio garanție cu privire la Premiu, valoarea acestuia, starea acestuia sau orice alte informații furnizate pe Site.</p><p>8.4 Promotorul nu face nicio declarație și nu oferă nicio garanție că informațiile furnizate pe site sunt exacte, complete sau actualizate.</p><p>8.5 Nu există nicio alternativă în numerar pentru Premiu decât dacă este menționat în Premiu(\"Această opțiune este oferită în mod transparent și clar, astfel încât participanții să fie informați corespunzător înainte de achitarea taxei de participare.\"), cu toate acestea, Promotorul va face tot posibilul pentru a oferi una dacă Câștigătorul preferă să încaseze în numerar decât Premiul.</p><p>8.6 Premiul nu este negociabil sau transferabil.</p><p>8.7 Dacă premiul este un vehicul:</p><p>Promotorul se va asigura, cu excepția cazului în care se specifică altfel, că vine cu un MOT valid (dacă este necesar);</p><p>8.8 Nu este inclusă nicio asigurare cu Premiul și este responsabilitatea Câștigului să se asigure că vehiculul este asigurat corespunzător înainte de a-l lua pe drumurile publice (dacă este legal să facă acest lucru);</p><p>8.9 Promotorul nu are nicio responsabilitate pentru Premiu odată ce acesta a fost livrat. Câștigătorul este singurul responsabil pentru respectarea tuturor legilor și reglementărilor relevante referitoare la vehicul, funcționarea acestuia și pentru a se asigura că îl operează într-un mod sigur și responsabil;</p><p>nu este inclusă taxa auto/drum;</p><p>8.10 Câștigătorul este responsabil să se asigure că are licențele, calificarea, cunoștințele și experiența necesare pentru a conduce vehiculul în siguranță și în mod legal;</p><p>8.11 Câștigătorul este singurul responsabil pentru a se asigura că are toate echipamentele și îmbrăcămintea de siguranță necesare (de exemplu, căști, cizme și mănuși) și pentru a le purta în timpul conducerii vehiculului.</p><p>8.12 Dacă premiul este o sărbătoare sau un eveniment:</p><p>8.13 Descrierea Premiului va specifica numărul de bilete incluse în ce clasă de transport și tipul de transportator către care destinație de călătorie. În funcție de tipul de premiu, flexibilitatea datelor poate fi disponibilă pentru câștigător, adică biletele pentru Grand Prix ar fi o dată fixă, în timp ce o vacanță generală poate fi flexibilă. Premiul nu include asigurarea de călătorie, costul transferurilor către</p><p>costul transferurilor către și de la aeroporturi sau stații, mâncare și băutură, bani cheltuiți, taxe sau cheltuieli personale. Orice alte costuri suportate în plus față de cele menționate mai sus și care sunt accesorii pentru îndeplinirea premiului sunt responsabilitatea câștigătorului(i). Suplimentul în numerar poate fi inclus în premiu, totuși aceasta este întinderea răspunderii Promotorului.</p><p>8.14 Veți fi responsabil să vă asigurați că dvs. și orice persoană care călătorește cu dvs. sunteți disponibili pentru a călători și dețineți pașapoarte valabile, vize și documente de călătorie necesare pentru vacanța în cauză la datele de călătorie specificate. Datele odată notificate agentului de turism nu pot fi modificate.</p><p><br></p><p>9. Câștigători</p><p>9.1 Decizia Promotorului este definitivă și nu se va intra în corespondență sau discuție.</p><p>9.2 Promotorul va contacta personal câștigătorul cât mai curând posibil după data extragerii, nu mai târziu de 7 zile de la data extragerii, folosind numărul de telefon sau adresa de e-mail furnizate odată cu înscrierea la concurs. Dacă câștigătorul nu poate fi contactat sau nu este disponibil sau nu a revendicat Premiul în termen de 14 zile de la Data Tragerii, Promotorul își rezervă dreptul de a oferi Premiul următorului Participant eligibil selectat dintre înscrierile corecte care au fost primite înainte de Data limită.</p><p>9.3 Promotorul trebuie fie să publice, fie să pună la dispoziție informații care indică faptul că a avut loc un premiu valabil. Pentru a respecta această obligație, Promotorul va publica numele și numărul câștigătorilor premiului pe site și va trimite numele și câștigătorii premiului cu numărul câștigător oricărei persoane care s-au înscris.</p><p>9.4 Dacă vă opuneți publicării sau punerii la dispoziție a unuia sau a întregului nume și a înscrierii dvs. câștigătoare, vă rugăm să contactați Promotorul la info@carscor.com înainte de Data de închidere. În astfel de circumstanțe, la cerere, Promotorul trebuie să furnizeze informațiile Autorității pentru Standarde de Publicitate.</p><p><br></p><p>10.Revendicarea premiului</p><p>10.1 Trebuie să revendicați personal premiul. Premiul nu poate fi revendicat de o terță parte în numele dumneavoastră. Detaliile despre cum vă va fi livrat Premiul (sau pus la dispoziție pentru colectare) sunt publicate pe site-ul web.</p><p>10.2 În cazul în care datele dumneavoastră personale, inclusiv informațiile de contact, se modifică în orice moment, trebuie să anunțați Promotorul cât mai curând posibil. 10.3 Notificările trebuie trimise promotorului prin e-mail la info@carscor.com</p><p>10.4 Notificările trebuie să includă detalii despre competiția la care te-ai înscris, detaliile tale vechi și detaliile tale noi. Dacă detaliile dumneavoastră se modifică în termen de 10 zile de la Data Închiderii, Promotorul va utiliza datele dumneavoastră vechi dacă trebuie să încerce să vă contacteze.</p><p>10.5 Orice premiu în numerar va fi transferat direct în contul bancar desemnat de câștigători. Câștigătorul trebuie să facă dovada că este beneficiarul unic sau comun al contului bancar. Nerespectarea acestui lucru în termen de 14 zile va duce la descalificarea din concurs, iar câștigătorul va pierde premiul. În astfel de circumstanțe, Promotorul își rezervă dreptul de a oferi premiul următorului Participant eligibil selectat dintre înscrierile corecte care au fost primite înainte de Data Închiderii.</p><p>10.6 Promotorul nu acceptă nicio responsabilitate și nu este responsabil să plătească nicio compensație dacă nu puteți sau nu acceptați premiul.</p><p><br></p><p>11. Limitare a răspunderii</p><p>11.1 În măsura în care este permis de lege, Promotorul, agenții sau distribuitorii săi nu vor fi în nicio circumstanță responsabili sau răspunzători să despăgubească câștigătorul sau să accepte nicio răspundere pentru orice pierdere, daune, vătămare corporală sau deces survenită ca urmare a preluării premiului. cu excepția cazului în care este cauzată de neglijența Promotorului, a agenților sau distribuitorilor săi sau a angajaților acestora. Drepturile dumneavoastră statutare nu sunt afectate.</p><p><br></p><p><br></p><p>12. Protecția datelor și publicitate</p><p><br></p><p>12.1 Prin înscrierea în competiție, sunteți de acord că orice informații personale furnizate de dvs. odată cu înscrierea la concurs pot fi păstrate și utilizate numai de către Promotor sau agenții și furnizorii săi pentru a administra competiția sau așa cum se prevede în Politica de confidențialitate a Promotorului www.carscor.com a cărui copie este disponibilă pe site-ul web.</p><p>12.2 Dacă sunteți câștigătorul concursului, sunteți de acord ca Promotorul să vă poată folosi numele, imaginea și orașul sau județul de reședință pentru a anunța câștigătorul acestui concurs. În plus, sunteți de acord să participați la orice publicitate rezonabilă cerută de Promotor.</p><p>12.3 Dacă nu doriți să participați la nicio publicitate, trebuie să anunțați Promotorul înainte de Data Închiderii. Acest lucru nu vă va afecta șansele de a câștiga Premiul. Dacă nu sunteți de acord să participați la nicio publicitate despre competiție, este posibil să furnizăm în continuare detaliile dvs. Autorității pentru Standarde de Publicitate. Aceasta este o cerință legală pe care trebuie să o respectăm pentru a demonstra că concursul a fost administrat corespunzător și că Premiul a fost acordat.</p><p>12.4 Dacă sunteți câștigătorul concursului, vi se poate solicita să furnizați informații personale suplimentare și dovada identității dumneavoastră pentru a vă confirma eligibilitatea de a revendica Premiul și de a vă transfera dreptul de proprietate asupra Premiului. Sunteți de acord cu utilizarea informațiilor dumneavoastră în acest mod. Aveți dreptul să solicitați detalii suplimentare despre modul în care sunt utilizate informațiile dumneavoastră personale. De asemenea, vă puteți retrage consimțământul pentru ca informațiile dvs. personale să fie utilizate în acest fel, dar, prin aceasta, puteți împiedica transferul Premiului către dvs. În astfel de circumstanțe, se va considera că te-ai retras din concurs și că ai renunțat la premiu. Nu veți avea dreptul la nicio rambursare a taxei de intrare.</p><p>12.5 Vă rugăm să rețineți că, în conformitate cu legile privind protecția datelor, aveți dreptul să solicitați ca Promotorul să nu vă contacteze și să vă șteargă datele din baza de date. Dacă faceți o astfel de solicitare, vă veți retrage din competiție deoarece nu va fi posibil să vă contactați în cazul în care sunteți câștigătorul. Nu veți avea dreptul la nicio rambursare a taxei de înscriere dacă vă retrageți din competiție. Dacă nu doriți ca niciuna dintre detaliile dumneavoastră personale să fie utilizată de către Promotor în scopuri promoționale, vă rugăm să trimiteți un e-mail către Promotor la info@carscor.com la Data Închiderii.</p><p><br></p><p><br></p><p>13. General</p><p><br></p><p>13.1 Promotorul își rezervă dreptul de a modifica acești termeni și condiții din când în când. Cea mai recentă versiune a acestor termeni și condiții va fi disponibilă pe site.</p><p>13.2 Dacă există vreun motiv de a crede că a existat o încălcare a acestor termeni și condiții, Promotorul își poate rezerva, la discreția sa, dreptul de a vă exclude de la participarea la concurs și la orice competiție viitoare.</p><p>13.3 Promotorul își rezervă dreptul de a anula, suspenda, anula sau modifica competiția cu premii atunci când devine necesar să facă acest lucru pentru circumstanțe în afara controlului său. În astfel de circumstanțe, Promotorul va rambursa toate taxele de intrare pe care le-ați plătit.</p><p>13.4 Exista un număr minim pentru ca concursul sa fie valabil, este necesar ca numarul de inscrieri sa fie de cel putin 80% din numarul total de bilete puse in joc.</p><p>13.5 Promotorul (www.carscor.ro) își rezervă dreptul de a prelungi durata competiției până la atingerea numărului minim de 80% din biletele vândute.</p><p>13.6 Competițiile de pe website nu sunt în niciun fel sponsorizate, avizate, administrate sau asociate cu Facebook. Prin înscrierea la concursuri, participanții sunt de acord că Facebook nu are nicio răspundere și nu este responsabil pentru administrarea sau promovarea competițiilor.</p><p>Acești termeni și condiții vor fi guvernați de legea romana, iar părțile se supun jurisdicției exclusive a instanțelor din Romania.</p><p>Ar trebui să tipăriți o copie a acestor termeni și condiții și să le păstrați pentru evidența dvs.</p><p>13.7 Participanții care nu răspund corect la întrebările competiției, dar plătesc taxa de participare, vor primi un e-book gratuit și puncte de recompensă în cadrul sistemului nostru de puncte, pe care le pot utiliza pentru a participa la viitoarele competiții, punctele de recompensă sunt oferite și pentru alte acțiuni legate de site, cum ar fi înregistrarea și invitarea prietenilor.</p><p>13.8 Aceste puncte nu pot fi convertite în bani sau alte valori monetare și sunt destinate exclusiv pentru a fi folosite în cadrul competițiilor organizate de site-ul nostru.</p><p>13.9 Prin urmare, competiția noastră nu este considerată un joc de noroc sau o formă de pariere, ci este o competiție bazată pe cunoștințe și abilități, cu premii tangibile oferite pentru participanții care răspund corect la întrebări.</p>');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `start` text NOT NULL,
  `end` text NOT NULL,
  `max_tickets` text NOT NULL,
  `price` float NOT NULL,
  `description` text NOT NULL,
  `images` text NOT NULL,
  `winnerText` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `title`, `start`, `end`, `max_tickets`, `price`, `description`, `images`, `winnerText`) VALUES
(67, 'dasdasdas', '05-04-2023 03:39', '30-04-2023 17:46', '1888', 0.1, '<p><em>P</em>a<u>rol</u>a m<strong>ea</strong> <span style=\"background-color: rgb(230, 0, 0);\">12</span><span style=\"color: rgb(0, 102, 204);\">3</span></p>', '[\"events_images/1680655188/01680655188Untitled_design__8_-removebg-preview.png\"]', NULL),
(73, 'Test castigatori', '17-04-2023 23:00', '17-04-2023 23:05', '8', 0.1, '<p>test cas<span style=\"color: rgb(255, 153, 0);\">tigatori</span></p>', '[\"events_images/1681762311/16817623110Screenshot_7.png\",\"events_images/1681762311/01681762311Screenshot_2.png\"]', '<h1><u>Text c</u>a<strong>stigatori:</strong></h1><p>dsada<strong>sdsadsa</strong></p>');

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` int(11) NOT NULL,
  `firstName` text NOT NULL,
  `lastName` text NOT NULL,
  `phoneNumber` text NOT NULL,
  `emailAddress` text NOT NULL,
  `companyName` text NOT NULL,
  `country` text NOT NULL,
  `streetName` text NOT NULL,
  `houseNumber` text NOT NULL,
  `postCode` text NOT NULL,
  `city` text NOT NULL,
  `notes` text NOT NULL,
  `products` text NOT NULL,
  `paymentStatus` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`id`, `firstName`, `lastName`, `phoneNumber`, `emailAddress`, `companyName`, `country`, `streetName`, `houseNumber`, `postCode`, `city`, `notes`, `products`, `paymentStatus`) VALUES
(1, 'Pavel', 'Marin', '07949099021', 'pavel@eway-design.com', '', 'Romania', 'pl n cur', '2a', '12939', 'Baicoi', 'am pl mare', '[{\"id\":\"67\",\"title\":\"BMW ROSU FA\",\"quantity\":44,\"price\":660},{\"id\":\"68\",\"title\":\"dasdsadsad\",\"quantity\":3,\"price\":45}]', 'paid'),
(2, 'Nicolae', 'Alex', '07949099021', 'super.alexx@yahoo.com', '', 'Romania', '12313', 'fwewe', 'asd', 'Baicoi2', 'am pl mareeeeeeeeeeeeeeeeeee', '[{\"id\":\"67\",\"title\":\"BMW ROSU FA\",\"quantity\":44,\"price\":660},{\"id\":\"68\",\"title\":\"dasdsadsad\",\"quantity\":3,\"price\":45}]', 'paid');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `accountEmail` text NOT NULL,
  `ticketQuantity` int(6) NOT NULL,
  `eventId` int(11) NOT NULL,
  `createdAt` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `accountEmail`, `ticketQuantity`, `eventId`, `createdAt`) VALUES
(1, 'super.alexx@yahoo.com', 777, 67, '2023-04-02'),
(2, 'super.alexx@yahoo.com', 3, 68, '2023-04-02'),
(3, 'super.alexx@yahoo.com', 300, 67, '2023-04-03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `configuration`
--
ALTER TABLE `configuration`
  ADD PRIMARY KEY (`type`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

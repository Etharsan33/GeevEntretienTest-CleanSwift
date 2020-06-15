# Projet avec une architecture Clean Swift

### Application builder sur Xcode 11.4, Swift 5

## Arborescence

-> | Extensions = Contient toutes les extensions UIKit, Foundation, MapKit pour pouvoir étendre les classes Swift et qu'ils soivent réutilisable
<br>
-> | Common = Contient des fichiers qui sont communs à l'application (Color, Localizable, Constants...)
<br>
-> | Manager = Singleton pour gérer la partie network, resources et user Location
<br>
-> | Protocols  = Tous les procolols
<br>
-> | Helper = Tous les Helper
<br>
-> | Models = Tous les models de l'application lié aux données du serveur
<br>
-> | Core = Le noyau de l'application (ViewController, Views, CSConfig, Worker, Interactor, Presenter, Router)
<br>
-> | Resources = Localizable strings, Assets, LauchScreen
<br>

## Explication Architecture

Exemple Donations (Liste des donations) :

J'ai découpé cette partie avec l'architecture Clean Swift.

DonationsCSConfig = Le squelette du fonctionnement de la liste des donations<br>
DonationsWorker = Une structure qui permet d'appeler le serveur avec les bons paramètres<br>
DonationsInteractor = Gère la demande du viewController et appel le worker<br>
DonationsPresenter = Transforme les données reçu par l'Interactor et le transmets au Controller<br>
DonationsRouter = Gère les redirections et les données à transiter vers différents Controllers<br>
DonationsViewController = Afficher les données fourni par le presenter et gère l'interface avec RxSwift<br>

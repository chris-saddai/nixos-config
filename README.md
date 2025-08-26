# NixOS Triple-Flake-Setup

Dieses Repository enthält die NixOS-Konfigurationen für ein vielseitiges Setup, das drei Hauptanwendungsfälle auf zwei verschiedenen Systemen abdeckt: einen Haupt-PC (Intel/NVIDIA) und einen Laptop (AMD/AMD).

Das Setup ist vollständig deklarativ und verwendet NixOS Flakes, um die Konfigurationen reproduzierbar und leicht umschaltbar zu machen.

### Ordnerstruktur

Die Konfiguration ist modular aufgebaut, um die Wartung zu vereinfachen:

  * `flake.nix`: Das zentrale Manifest, das alle Profile und Module definiert.
  * `profiles/`: Enthält die logischen Profile für die verschiedenen Anwendungsfälle.
      * `common.nix`: Gemeinsame, geräteunabhängige Basiskonfigurationen (Benutzer, Netzwerk, grundlegende Pakete).
      * `work/`: Profil für die Arbeit (Hyprland, Entwicklungstools).
      * `leisure/`: Profil für Gaming und Kreatives (KDE Plasma, Gaming-Tools).
      * `vm-hypervisor/`: Profil für die Windows-VM mit GPU-Passthrough.
      * `laptop-work/`: Profil für die Arbeit auf dem Laptop.
  * `hardware/`: Enthält die hardware-spezifischen Konfigurationen.
      * `main-pc.nix`: Konfiguration für den Intel/NVIDIA-PC.
      * `laptop.nix`: Konfiguration für den AMD-Laptop.

### Profile und Anwendungsfälle

Die `flake.nix`-Datei definiert die folgenden Profile, zwischen denen du wechseln kannst:

  * `#main-pc-work`: Dezentrales Setup für die Arbeit mit Hyprland auf dem Haupt-PC.
  * `#main-pc-leisure`: Setup für Gaming und Kreatives mit KDE Plasma auf dem Haupt-PC.
  * `#main-pc-vm`: Minimaler Hypervisor für die Windows-VM auf dem Haupt-PC (mit GPU-Passthrough).
  * `#laptop`: Dein Work-Setup mit Hyprland, optimiert für den Laptop.

### Wichtige Befehle

Verwende diese Befehle, um dein System zu verwalten und zwischen den Profilen zu wechseln. Stelle sicher, dass du dich im Stammverzeichnis des `nixos-config`-Ordners befindest.

#### 1\. System wechseln (Wechseln zwischen Profilen)

Dieser Befehl wendet die Konfiguration des angegebenen Profils an.

```bash
# Beispiel: Wechseln zum Arbeitsprofil auf dem Haupt-PC
sudo nixos-rebuild switch --flake .#main-pc-work
```

#### 2\. System aktualisieren

Dieser Befehl aktualisiert alle Pakete und Inputs in deinem Flake. Führe ihn regelmäßig aus.

```bash
sudo nixos-rebuild switch --update-input nixpkgs
```

#### 3\. System neu bauen (ohne Update)

Dieser Befehl baut das System basierend auf den aktuellen Konfigurationsdateien neu. Nützlich, wenn du Änderungen vornimmst.

```bash
sudo nixos-rebuild switch
```

#### 4\. Vorherige Generationen wiederherstellen

Falls ein Wechsel fehlschlägt, kannst du einfach zu einer früheren, funktionierenden Systemkonfiguration zurückkehren.

```bash
sudo nixos-rebuild switch --rollback
```

**Hinweis:** Die `main-pc-vm`-Konfiguration erfordert eine funktionierende VM-Konfiguration und GPU-Passthrough-Einstellungen in den entsprechenden Modulen.

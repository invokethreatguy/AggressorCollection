# Aggressor Scripts
This is just a random collection of Aggressor Scripts I've written for [Cobalt Strike](https://www.cobaltstrike.com) 3.x.

Please note that most of them could probably use some tweaking to better suit your environment/tactics.

Shoot me any questions and feel free to submit a pull request for any improvements you may have!

## Using this repository

I make use of [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules), so clone this repo with ```git clone --recursive```

If you didn't follow my instructions and already cloned the repo, go to the root of the repo and run ```git submodule update --init --recursive```

## Kits

Most of the useful scripts here are organized in [kits](kits). All you have to do is load the [KitLoader.cna](kits/KitLoader.cna) script, and it will automatically load all other kits (execpt the DebugKit).

### Kit descriptions
1. **AnnoyKit**

  Actions in this kit center around miscellaneous fun that generally involve messing with the user

2. **AntiForensicsKit**

  Actions in this kit center around antiforensics. If it slows an investigator down, it likely belongs in this kit. We all know antiforensics is best forensics.

3. **CredKit**

  Actions in this kit center around credential theft, be it via memory scraping or reading files in. If it involves stealing passwords, it should be here.

4. **DebugKit**

  This kit is limited to actions that I use for development and debugging, and thus is not loaded with the rest of them.

5. **EnumKit**

  Actions in this kit center around host and network enumeration. Credential enumeration actions should go in CredKit instead.

6. **PersistKit**

  Actions in this kit center around endpoint persistence. Examples include backdoor service creation, backdoor process creation, etc

7. **PrivEscKit**

  Actions in this kit center around endpoint privilege escalation. Actions that involve forceful scanning (powerup.ps1, unix-privesc-check) should go in the apporiate section

8. **ThirdParty**
  This is is just a random collection of .cna scripts that other people have created that I like to use. I just have it loaded with kitloader for conveience. There may be changes to the third party scripts to better integerate with my workflow.

## Other scripts
>inveigh/ 

Runs [Inveigh](https://github.com/Kevin-Robertson/Inveigh) against the selected machine(s) for a specified amount of time. This does automatically enable LLMNR and NBNS spoofing.

>Ebowla/

Adds interoperability between Cobalt Strike and [Ebowla](https://github.com/Genetic-Malware/Ebowla). I plan on making this process much more integrated and automated, but at this time, you can generate an Ebowla payload within Cobalt Strike by going to ```Attacks -> Generate Ebowla Payload```. See [ewbowla-interop.cna](Ebowla/ebowla-interop.cna) for instructions.

>Pushover/

[Pushover](https://pushover.net) support for Cobalt Strike, ridiculously useful.

See [pushover-cs](Pushover/pushover-cs) for instructions.

>Reports/

These are reporting (.rpt) scripts created for Cobalt Strike.

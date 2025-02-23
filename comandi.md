
{ ... }:
{
  ...
  programs.git = {
    enable = true;
    userName = "Your Name";
    userEmail = "youremail@example.com";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
      safe.directory = "/home/yourusername/.dotfiles";
    };
  };
  ...
}


cd /wherever/your/config/is
git add *

Individual files can be staged by supplying filenames to git add:

git add file1 file2

  Committing

Once some changes have been staged, run git commit -m "commit message" to commit the changes as a new version:

git commit -m "First commit"

Setting Up Remote(s)

Pick a remote (or multiple if you want) to store your git repo on. A few choices include:

    GitHub - Owned by Microsoft
    GitLab - Owned independently
    Codeberg - Nonprofit, very FOSS
    Sourcehut - Owned independently, very FOSS, doesn’t require Javascript
    Self-hosting - Something like GitLab or Gitea, if you’re into that

I have my repositories stored on GitHub, GitLab, Codeberg and a self-hosted Gitea instance.

For every remote you want to configure for your repository, first login to the remote and create a new empty repository.

Before you push to the remote, you’ll want to setup an SSH key. If you’ve never done this, go ahead and run:

ssh-keygen

Then, go and find the file ~/.ssh/id_rsa.pub (if it isn’t “idrsa”, that’s fine, just make sure you open the one marked as “pub”). The one with .pub is the public key. The other one is your private key. The private key is like a password, so don’t share it with anyone. The public key, however, will need to be copied to the remote.

On the remote’s website, there should be a settings menu where you can “Add an SSH Key.” Do this, copying the text from the public key. If you accidentally copy your private key, just delete both keys and start over from the ssh-keygen command.

Once you have an SSH key setup, you can push to the remote.

Navigate to the blank repository on your remote, and copy the SSH link. Then, you can add this as a remote using:

git remote add name the-ssh-link-you-copied

where name is the name for the remote and what follows is the ssh link you copied. You can add as many remotes as you want!

For me, it’s something like:

git remote add gitlab git@gitlab.com:librephoenix/nixos-config.git
git remote add github git@gitlab.com:librephoenix/nixos-config.git
git remote add codeberg git@codeberg.org:librephoenix/nixos-config.git

Pushing to your Remote(s)

Now, it’s very simple to push committed changes to your git repo, using:

git push remote-name branch-name

So for me, if I want to push to all of my remotes, I’d be running:

git push gitlab main
git push github main
git push codeberg main

Rinse, Wash and Repeat

Now, every time you make changes, you follow those steps:

    git add file1 file2 (etc..) to stage commits
    git commit -m "commit message" to commit changes
    git push remote-name branch-name to push to the remote

Several IDEs also have git support out-of-the-box, such as VSCodium (in nixpkgs).

If you want to have a fast workflow with git, I recommend not doing everything via the CLI, and instead finding a good git wrapper like the aforementioned ones.
How do I restore my git repo or get my git repo on a new system?

You can copy the git repo using git clone.

Simply navigate to your remote and find a git clone link, then run either:

git clone the-link-you-copied

git clone the-link-you-copied /path/to/custom/directory

If you do this, git may name your remote something different. You can find the remote name using:

git remote

If you want to change the name of the remote, use:

git remote rm remote-name
git remote add new-remote-name clone-link-copied-from-remote

Keep in mind that it is usually easier in the long run to use an SSH clone link rather than an HTTPS one.
Nix Integrations With Git
File Not Found Error

This bears brief mentioning, because now that your config is stored in a git repo, you may encounter this error.

If your configuration references a file inside the repo that isn’t staged or committed, it will fail and complain that the file doesn’t exist. This is a feature and not a bug, as Nix is telling you that you haven’t included the file in the repo, so you may not be able to reproduce the build later.

You can fix this by simply by staging and/or committing the new file

Unstaged changes to files that were committed before will still be picked up; it’s only completely unstaged files that Nix will complain about.
Git and Flakes Allow You to Run Software Without Installing It!

If you’re using a flake, now that your flake is stored in a remote git repository, you can setup your flake to allow a NixOS machine to run a script (even if it has dependencies you haven’t installed) directly from the remote git repo. This is achieved by defining programs and apps in your flake, and then running the flake scripts using the nix run command.

This can be better than simply curling a script and piping it into sh, because with this method, the script can have dependencies which automatically get pulled by nix before the script is run.

I’ve used this to setup an autoinstall script for my dotfiles, which is run with a command (essentially) as simple as:

nix run gitlab:librephoenix/nixos-config

If you want to set something like this up, you’ll need:

    A few definitions in a let binding for your outputs (I actually just took these while studying how plasma-manager works, since my wife uses that)
    Definitions for packages and apps in your outputs

You can see the below example for reference:

{
  description = "My first flake!";

  inputs = { ... };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};

      # Systems that can run tests:
      supportedSystems = [ "aarch64-linux" "i686-linux" "x86_64-linux" ];

      # Function to generate a set based on supported systems:
      forAllSystems = inputs.nixpkgs.lib.genAttrs supportedSystems;

      # Attribute set of nixpkgs for each system:
      nixpkgsFor =
        forAllSystems (system: import inputs.nixpkgs { inherit system; });
   in {
     nixosConfigurations = { ... };

     homeConfigurations = { ... };

     packages = forAllSystems (system:
        let pkgs = nixpkgsFor.${system};
        in {
          default = self.packages.${system}.install;

          install = pkgs.writeShellApplication {
            name = "install";
            runtimeInputs = with pkgs; [ git ]; # deps
            text = ''${./install.sh} "$@"''; # the script
          };
        });

     apps = forAllSystems (system: {
       default = self.apps.${system}.install;

       install = {
         type = "app";
         program = "${self.packages.${system}.install}/bin/install";
       };
     });
   }
}

In this example, install.sh is a separate script file in the same directory as the flake.

Note, that the advantage to this is that Nix can autoinstall dependencies needed to run the script, so you could, for example, make your script a python script, like so:

{
  description = "My first flake!";

  inputs = { ... };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};

      # Systems that can run tests:
      supportedSystems = [ "aarch64-linux" "i686-linux" "x86_64-linux" ];

      # Function to generate a set based on supported systems:
      forAllSystems = inputs.nixpkgs.lib.genAttrs supportedSystems;

      # Attribute set of nixpkgs for each system:
      nixpkgsFor =
        forAllSystems (system: import inputs.nixpkgs { inherit system; });
   in {
     nixosConfigurations = { ... };

     homeConfigurations = { ... };

     packages = forAllSystems (system:
        let pkgs = nixpkgsFor.${system};
        in {
          default = self.packages.${system}.install;

          install = pkgs.writeShellApplication {
            name = "install";
            runtimeInputs = with pkgs; [ python3 ]; # deps
            text = ''python ${./install.py} "$@"''; # the script
          };
        });

     apps = forAllSystems (system: {
       default = self.apps.${system}.install;

       install = {
         type = "app";
         program = "${self.packages.${system}.install}/bin/install";
       };
     });
   }
}

Once you’ve set this up, committed changes to the flake, and pushed it to your git remote, the script can be run using nix run. If you’re hosting on GitHub or GitLab, the syntax will look something like this:

nix run github:username/repo

nix run gitlab:username/repo

If your git repo is elsewhere, you can use the git+https syntax, for example:

nix run git+https://codeberg.org/username/repo

Additionally, you can include more than one script, i.e:

{
  description = "My first flake!";

  inputs = { ... };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};

      # Systems that can run tests:
      supportedSystems = [ "aarch64-linux" "i686-linux" "x86_64-linux" ];

      # Function to generate a set based on supported systems:
      forAllSystems = inputs.nixpkgs.lib.genAttrs supportedSystems;

      # Attribute set of nixpkgs for each system:
      nixpkgsFor =
        forAllSystems (system: import inputs.nixpkgs { inherit system; });
   in {
     nixosConfigurations = { ... };

     homeConfigurations = { ... };

     packages = forAllSystems (system:
        let pkgs = nixpkgsFor.${system};
        in {
          default = self.packages.${system}.install;

          install = pkgs.writeShellApplication {
            name = "install";
            runtimeInputs = with pkgs; [ python3 ]; # deps
            text = ''python ${./install.py} "$@"''; # the script
          };

          another-script = pkgs.writeShellApplication {
            name = "another-script";
            runtimeInputs = with pkgs; [ python3 ]; # deps
            text = ''python ${./another-script.py} "$@"''; # the script
          };
        });

     apps = forAllSystems (system: {
       default = self.apps.${system}.install;

       install = {
         type = "app";
         program = "${self.packages.${system}.install}/bin/install";
       };

       another-script = {
         type = "app";
         program = "${self.packages.${system}.another-script}/bin/another-script";
       };
     });
   }
}

The “default” script is run whenever nix run is called normally, i.e:

nix run github:username/repo

However, if you’d like to select a different script, you pass it using the normal flake output selection syntax, i.e:

nix run github:username/repo#install
nix run github:username/repo#another-script

If you’d like to learn more about how this works:

    Determinate Systems has a really good writeup about it
    There’s also some official documentation about nix run

Errors Using Nix Run

nix run requires git to be available in order to run, and also requires the experimental features nix-command and flakes. None of these are available by default, so if you want to keep it as one command, you can wrap the command with nix-shell and then use the --experimental-features flag:

nix-shell -p git --command "nix run --experimental-features 'nix-command flakes' github:username/repo"

https://librephoenix.com/2024-03-14-managing-your-nixos-config-with-git

https://nixos-and-flakes.thiscute.world/nixos-with-flakes/modularize-the-configuration
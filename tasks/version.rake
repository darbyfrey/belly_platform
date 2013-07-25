desc "bump the gem version"
namespace :version do
  namespace :bump do

    task :major do
      new_version = BellyPlatform::Version.next_major
      execute_version_bump(new_version)
    end

    task :minor do
      new_version = BellyPlatform::Version.next_minor
      execute_version_bump(new_version)
    end

    task :patch do
      new_version = BellyPlatform::Version.next_patch
      execute_version_bump(new_version)
    end

    def execute_version_bump(new_version)
      if !clean_staging_area?
        system "git status"
        raise "Unclean staging area! Be sure to commit or .gitignore everything first. See `git status` above."
      else
        require 'git'
        git = Git.open('.')

        write_update(new_version)
        git.add('lib/belly_platform/version.rb')
        git.add_tag(release_tag)
        git.commit("Version bump: #{release_tag}")
        puts "Version bumped: #{release_tag}"
      end
    end

    def write_update(new_version)
      filedata = File.read('lib/belly_platform/version.rb')
      changed_filedata = filedata.gsub("VERSION = \"#{BellyPlatform::VERSION}\"\n", "VERSION = \"#{new_version}\"\n")
      File.open('lib/belly_platform/version.rb',"w"){|file| file.puts changed_filedata}
    end

    def clean_staging_area?
      `git ls-files --deleted --modified --others --exclude-standard` == ""
    end

    def release_tag
      "v#{BellyPlatform::VERSION}"
    end
  end
end
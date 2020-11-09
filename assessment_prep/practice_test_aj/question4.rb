# question4.rb

class Gallery
  def make_exhibition(workers)
    workers.each do |worker|
      worker.mount_exhibition(self)
    end
  end
end

class Framer
  def mount_exhibition
    fit_artwork(exhibit.works)
  end

  def fit_artwork(works)
    # implementation
  end
end

class Artist
  def mount_exhibition
    create_artwork(exhibit.art)
  end

  def create_artwork(art)
    # implementation
  end
end

class Installer
  def mount_exhibition
    install_artwork(exhibit.hang)
  end

  def install_artwork(hang)
    # implementation
  end
end

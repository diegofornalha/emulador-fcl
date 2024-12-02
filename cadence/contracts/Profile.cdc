access(all) contract Profile {
  access(all) let publicPath: PublicPath
  access(all) let privatePath: StoragePath

  access(all) resource interface Public {
    access(all) fun getName(): String
    access(all) fun getAvatar(): String
    access(all) fun getColor(): String
    access(all) fun getInfo(): String
    access(all) fun asReadOnly(): Profile.ReadOnly
  }

  access(all) resource interface Owner {
    access(all) fun getName(): String
    access(all) fun getAvatar(): String
    access(all) fun getColor(): String
    access(all) fun getInfo(): String

    access(all) fun setName(_ name: String) {
      pre {
        name.length <= 15: "Names must be under 15 characters long."
      }
    }
    access(all) fun setAvatar(_ src: String)
    access(all) fun setColor(_ color: String)
    access(all) fun setInfo(_ info: String) {
      pre {
        info.length <= 280: "Profile Info can at max be 280 characters long."
      }
    }
  }

  access(all) resource Base: Owner, Public {
    access(self) var name: String
    access(self) var avatar: String
    access(self) var color: String
    access(self) var info: String

    init() {
      self.name = "Anon"
      self.avatar = ""
      self.color = "#232323"
      self.info = ""
    }

    access(all) fun getName(): String { return self.name }
    access(all) fun getAvatar(): String { return self.avatar }
    access(all) fun getColor(): String {return self.color }
    access(all) fun getInfo(): String { return self.info }

    access(all) fun setName(_ name: String) { self.name = name }
    access(all) fun setAvatar(_ src: String) { self.avatar = src }
    access(all) fun setColor(_ color: String) { self.color = color }
    access(all) fun setInfo(_ info: String) { self.info = info }

    access(all) fun asReadOnly(): Profile.ReadOnly {
      return Profile.ReadOnly(
        address: self.owner?.address,
        name: self.getName(),
        avatar: self.getAvatar(),
        color: self.getColor(),
        info: self.getInfo()
      )
    }
  }

  access(all) struct ReadOnly {
    access(all) let address: Address?
    access(all) let name: String
    access(all) let avatar: String
    access(all) let color: String
    access(all) let info: String

    init(address: Address?, name: String, avatar: String, color: String, info: String) {
      self.address = address
      self.name = name
      self.avatar = avatar
      self.color = color
      self.info = info
    }
  }

  access(all) fun new(): @Profile.Base {
    return <- create Base()
  }

  access(all) fun check(_ address: Address): Bool {
    return getAccount(address)
      .capabilities
      .get<&{Profile.Public}>(Profile.publicPath)
      .check()
  }

  access(all) fun fetch(_ address: Address): &{Profile.Public} {
    return getAccount(address)
      .capabilities
      .get<&{Profile.Public}>(Profile.publicPath)
      .borrow()!
  }

  access(all) fun read(_ address: Address): Profile.ReadOnly? {
    if let profile = getAccount(address).capabilities.get<&{Profile.Public}>(Profile.publicPath).borrow() {
      return profile.asReadOnly()
    } else {
      return nil
    }
  }

  access(all) fun readMultiple(_ addresses: [Address]): {Address: Profile.ReadOnly} {
    let profiles: {Address: Profile.ReadOnly} = {}
    for address in addresses {
      let profile = Profile.read(address)
      if profile != nil {
        profiles[address] = profile!
      }
    }
    return profiles
  }


  init() {
    self.publicPath = /public/profile
    self.privatePath = /storage/profile

    self.account.storage.save(<- self.new(), to: self.privatePath)
    let profileCapability = self.account.capabilities.storage.issue<&{Public}>(self.privatePath)
    self.account.capabilities.publish(profileCapability, at: self.publicPath)

    self.account
      .storage
      .borrow<&{Owner}>(from: self.privatePath)!
      .setName("qvvg")
  }
}

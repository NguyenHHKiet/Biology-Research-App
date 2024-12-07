const { sequelize, models } = require("../models"); // Import sequelize instance và models từ index.js

const seedDatabase = async () => {
  try {
    // Đồng bộ cơ sở dữ liệu (force: true để xóa và tạo lại bảng)
    await sequelize.sync({ force: true });

    console.log("Database synchronized!");

    // --- Seed dữ liệu phân cấp sinh học ---
    const kingdom = await models.Kingdom.create({ name: "Animalia" });
    const phylum = await models.Phylum.create({ name: "Chordata", kingdom_id: kingdom.id });
    const classMammalia = await models.Class.create({ name: "Mammalia", phylum_id: phylum.id });
    const orderCarnivora = await models.Order.create({ name: "Carnivora", class_id: classMammalia.id });
    const familyFelidae = await models.Family.create({ name: "Felidae", order_id: orderCarnivora.id });
    const genusPanthera = await models.Genus.create({ name: "Panthera", family_id: familyFelidae.id });
    const speciesLion = await models.Species.create({
      scientific_name: "Panthera leo",
      common_name: "Lion",
      genus_id: genusPanthera.id,
    });

    console.log("Biological hierarchy seeded!");

    // --- Seed OrganismGroup ---
    const groupMammals = await models.OrganismGroup.create({ name: "Mammals", symbol: "MAM" });
    const groupCarnivores = await models.OrganismGroup.create({ name: "Carnivores", symbol: "CAR" });

    // Gắn Species với OrganismGroup
    await models.OrganismGroupSpecies.create({ organism_group_id: groupMammals.id, species_id: speciesLion.id });
    await models.OrganismGroupSpecies.create({ organism_group_id: groupCarnivores.id, species_id: speciesLion.id });

    console.log("Organism groups seeded!");

    // --- Seed Habitat ---
    const habitatSavanna = await models.Habitat.create({
      name: "Savanna",
      description: "Grassland with scattered trees.",
      climate: "Warm",
      temperature: 25.0,
      humidity: 60,
    });
    const habitatForest = await models.Habitat.create({
      name: "Tropical Forest",
      description: "Dense and humid forest.",
      climate: "Humid",
      temperature: 30.0,
      humidity: 80,
    });

    // Gắn Habitat với Species
    await models.SpeciesHabitat.create({ species_id: speciesLion.id, habitat_id: habitatSavanna.id });
    await models.SpeciesHabitat.create({ species_id: speciesLion.id, habitat_id: habitatForest.id });

    console.log("Habitats seeded!");

    // --- Seed Characteristic ---
    await models.Characteristic.create({
      species_id: speciesLion.id,
      characteristic_type: "Body Length",
      value: "1.8-2.1",
      units: "meters",
    });
    await models.Characteristic.create({
      species_id: speciesLion.id,
      characteristic_type: "Weight",
      value: "150-225",
      units: "kg",
    });

    console.log("Characteristics seeded!");

    // --- Seed GeographicDistribution ---
    await models.GeographicDistribution.create({
      species_id: speciesLion.id,
      region: "Africa",
      country: "Kenya",
      location: "Masai Mara",
      notes: "Found in large prides.",
    });

    console.log("Geographic distributions seeded!");

    // --- Seed Author ---
    const authorJane = await models.Author.create({ name: "Jane Doe", affiliation: "University of Wildlife" });
    const authorJohn = await models.Author.create({ name: "John Smith", affiliation: "African Research Institute" });

    // Gắn Author với Species
    await models.SpeciesAuthor.create({ species_id: speciesLion.id, author_id: authorJane.id });
    await models.SpeciesAuthor.create({ species_id: speciesLion.id, author_id: authorJohn.id });

    console.log("Authors seeded!");

    // --- Seed ConservationStatus ---
    await models.ConservationStatus.create({
      species_id: speciesLion.id,
      name: "Lion Conservation",
      status: "Vulnerable",
      notes: "Population declining due to habitat loss.",
    });

    console.log("Conservation statuses seeded!");

    console.log("All data seeded successfully!");
  } catch (error) {
    console.error("Error seeding the database:", error);
  }
  // finally {
  //   await sequelize.close();
  // }
};

module.exports = seedDatabase;
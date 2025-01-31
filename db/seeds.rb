# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Limpar dados existentes
ContractsCatalog::Tenant.destroy_all
ContractsCatalog::Product.destroy_all
ContractsCatalog::Pricing.destroy_all
ContractsCatalog::Contract.destroy_all
ContractsCatalog::MonthlyResourceConsumption.destroy_all

# Criar registros de Tenant
tenants = ContractsCatalog::Tenant.create!([
  { first_name: 'João', last_name: 'Silva', email: 'joao@example.com' },
  { first_name: 'Maria', last_name: 'Santos', email: 'maria@example.com' }
])

# Criar registros de Product
products = ContractsCatalog::Product.create!([
  { name: 'VM Standard Instance', description: 'Virtual Machine with standard resources', use_unity: 'hours' },
  { name: 'VM Advanced Instance', description: 'Virtual Machine with advanced resources', use_unity: 'hours' }
])

# Criar registros de Pricing
pricings = ContractsCatalog::Pricing.create!([
  { product: products[0], price_per_unit: 0.50, currency: 'BRL' },
  { product: products[1], price_per_unit: 1.00, currency: 'BRL' }
])

# Criar registros de Contract
ContractsCatalog::Contract.create!([
  { tenant: tenants[0], product: products[0], start_date: Date.today, end_date: Date.today + 30, status: 'active' },
  { tenant: tenants[1], product: products[1], start_date: Date.today, end_date: Date.today + 30, status: 'active' }
])

# Criar Monthly Resource Consumptions
ContractsCatalog::MonthlyResourceConsumption.create!([
  {
    tenant: tenants[0],
    product: products[0],
    total_used: 720.0,
    use_unity: 'hours',
    total_cost: 360.0,
    interval: '2024-01'
  },
  {
    tenant: tenants[1],
    product: products[1],
    total_used: 720.0,
    use_unity: 'hours',
    total_cost: 720.0,
    interval: '2024-01'
  }
])

puts "Seed data created successfully!"

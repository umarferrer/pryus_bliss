# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120217135724) do

  create_table "administrateurs", :force => true do |t|
    t.string   "nom_admin"
    t.string   "prenom_admin"
    t.string   "login_mail"
    t.string   "hached_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incidents", :force => true do |t|
    t.integer  "id_machine_incident"
    t.string   "date_incident"
    t.string   "date_resolution_incident"
    t.string   "statut_incident"
    t.string   "niveau_incident"
    t.string   "description_incident"
    t.string   "proprietes_supplementaires"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "machines", :force => true do |t|
    t.string   "nom_machine"
    t.string   "ip_machine"
    t.integer  "salle_id"
    t.string   "description_machine"
    t.date     "date_crea_machine"
    t.string   "etat_machine"
    t.string   "etat_service_machine"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ping", :force => true do |t|
    t.integer "id_machine"
    t.string  "delay"
  end

  create_table "salles", :force => true do |t|
    t.string   "nom_salle"
    t.string   "ip_reseau"
    t.string   "masque_reseau"
    t.integer  "nbre_machine"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

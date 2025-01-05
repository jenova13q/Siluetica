-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_preferences" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "favoriteColors" TEXT[],
    "preferredStyles" TEXT[],
    "dislikedItems" TEXT[],

    CONSTRAINT "user_preferences_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "interaction_history" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "request" TEXT NOT NULL,
    "response" TEXT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "interaction_history_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "trends" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "popularity" INTEGER NOT NULL,
    "source" TEXT NOT NULL,

    CONSTRAINT "trends_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categories" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "parentId" INTEGER,

    CONSTRAINT "categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "wardrobe_items" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "typeId" INTEGER NOT NULL,
    "season" TEXT[],
    "style" TEXT[],
    "warmthLevel" INTEGER NOT NULL,
    "description" TEXT,
    "setId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "wardrobe_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "photos" (
    "id" SERIAL NOT NULL,
    "wardrobeItemId" INTEGER NOT NULL,
    "angle" TEXT NOT NULL,
    "imageUrl" TEXT NOT NULL,

    CONSTRAINT "photos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "materials" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "properties" TEXT[],

    CONSTRAINT "materials_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "textures" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "textures_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "patterns" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "patterns_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "item_materials" (
    "id" SERIAL NOT NULL,
    "wardrobeItemId" INTEGER NOT NULL,
    "materialId" INTEGER NOT NULL,
    "percentage" DOUBLE PRECISION NOT NULL,
    "textureId" INTEGER,
    "patternId" INTEGER,

    CONSTRAINT "item_materials_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "attributes" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "attributes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "item_attributes" (
    "id" SERIAL NOT NULL,
    "wardrobeItemId" INTEGER NOT NULL,
    "attributeId" INTEGER NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "item_attributes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sets" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "addedDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "sets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "outfits" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "eventDesc" TEXT,
    "weather" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "outfits_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "outfit_items" (
    "id" SERIAL NOT NULL,
    "outfitId" INTEGER NOT NULL,
    "wardrobeItemId" INTEGER NOT NULL,
    "layerOrder" INTEGER NOT NULL,

    CONSTRAINT "outfit_items_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "user_preferences_userId_key" ON "user_preferences"("userId");

-- AddForeignKey
ALTER TABLE "user_preferences" ADD CONSTRAINT "user_preferences_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "interaction_history" ADD CONSTRAINT "interaction_history_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "categories" ADD CONSTRAINT "categories_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "categories"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wardrobe_items" ADD CONSTRAINT "wardrobe_items_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wardrobe_items" ADD CONSTRAINT "wardrobe_items_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES "categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wardrobe_items" ADD CONSTRAINT "wardrobe_items_setId_fkey" FOREIGN KEY ("setId") REFERENCES "sets"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "photos" ADD CONSTRAINT "photos_wardrobeItemId_fkey" FOREIGN KEY ("wardrobeItemId") REFERENCES "wardrobe_items"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "item_materials" ADD CONSTRAINT "item_materials_wardrobeItemId_fkey" FOREIGN KEY ("wardrobeItemId") REFERENCES "wardrobe_items"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "item_materials" ADD CONSTRAINT "item_materials_materialId_fkey" FOREIGN KEY ("materialId") REFERENCES "materials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "item_materials" ADD CONSTRAINT "item_materials_textureId_fkey" FOREIGN KEY ("textureId") REFERENCES "textures"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "item_materials" ADD CONSTRAINT "item_materials_patternId_fkey" FOREIGN KEY ("patternId") REFERENCES "patterns"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "item_attributes" ADD CONSTRAINT "item_attributes_wardrobeItemId_fkey" FOREIGN KEY ("wardrobeItemId") REFERENCES "wardrobe_items"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "item_attributes" ADD CONSTRAINT "item_attributes_attributeId_fkey" FOREIGN KEY ("attributeId") REFERENCES "attributes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sets" ADD CONSTRAINT "sets_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "outfits" ADD CONSTRAINT "outfits_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "outfit_items" ADD CONSTRAINT "outfit_items_outfitId_fkey" FOREIGN KEY ("outfitId") REFERENCES "outfits"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "outfit_items" ADD CONSTRAINT "outfit_items_wardrobeItemId_fkey" FOREIGN KEY ("wardrobeItemId") REFERENCES "wardrobe_items"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

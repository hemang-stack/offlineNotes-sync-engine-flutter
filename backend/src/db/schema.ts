import {
    pgTable,
    uuid,
    text,
    timestamp,
    boolean,
} from "drizzle-orm/pg-core";

export const users = pgTable("users", {
    id: uuid("id").primaryKey().defaultRandom(),
    name: text("name").notNull(),
    email: text("email").notNull().unique(),
    password: text("password").notNull(),
    createdAt: timestamp("created_at").defaultNow(),
    updatedAt: timestamp("updated_at").defaultNow(),
});

export type user = typeof users.$inferSelect;
export type NewUser = typeof users.$inferInsert;

export const tasks = pgTable("tasks", {
    id: uuid("id").primaryKey().defaultRandom(),
    title: text("title").notNull(),
    description: text("description"),
    uid: uuid("uid")
        .notNull() 
        .references(() => users.id,
            { onDelete: "cascade" }
        ),
    priority: text("priority").notNull(),
    category: text("category").notNull(),
    dueAt: timestamp("due_at").notNull().$defaultFn(() => new Date(Date.now() + 7 * 24 * 60 * 60 * 1000)),
    isCompleted: boolean("is_completed")
        .notNull()
        .default(false),
    createdAt: timestamp("created_at").defaultNow(),
    updatedAt: timestamp("updated_at").defaultNow(),
});

export type Task = typeof tasks.$inferSelect;
export type NewTask = typeof tasks.$inferInsert;

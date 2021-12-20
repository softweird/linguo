/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Xavier Figueroa <xavierfigueroav@gmail.com>
 */

public class AppsGrid : Gtk.Grid {

    public const string GENERIC_ICON_NAME = "application-x-executable";
    public const int IMAGE_SIZE = 32;
    public unowned List<AppInfo> apps { get; construct; }

    public AppsGrid () {
        Object(apps: AppInfo.get_all ());
    }

    public AppsGrid.from_list (List<AppInfo> apps) {
        Object(apps: apps);
    }

    construct {
        column_spacing = 10;
        row_spacing = 10;
        halign = Gtk.Align.CENTER;
        for (int i = 0; i < apps.length (); i++) {
            AppInfo app = apps.nth_data (i);
            if (app.should_show ()) {
                Gtk.Image app_icon = get_image (app.get_icon ());
                Gtk.Label app_name = new Gtk.Label (app.get_display_name ());
                app_name.halign = Gtk.Align.START;
                Gtk.Button button1 = new Gtk.Button.with_label ("us");
                Gtk.Button button2 = new Gtk.Button.with_label ("la");
                attach (app_icon, 0, i);
                attach (app_name, 1, i);
                attach (button1, 2, i);
                attach (button2, 3, i);
            }
        }
    }

    private Gtk.Image get_image (Icon? icon) {
        string id = icon == null ? GENERIC_ICON_NAME : icon.to_string ();
        File file = File.new_for_path (id);
        Gtk.Image image = null;
        if (file.query_exists ()) {
            try {
                Gdk.Pixbuf pixbuf = new Gdk.Pixbuf.from_file_at_scale (id, IMAGE_SIZE, IMAGE_SIZE, true);
                image = new Gtk.Image.from_pixbuf (pixbuf);
            } catch (Error e) {
                warning ("%s", e.message);
                image = new Gtk.Image () {
                    gicon = new ThemedIcon (GENERIC_ICON_NAME),
                    pixel_size = IMAGE_SIZE
                };
            }
        } else {
            image = new Gtk.Image () {
                gicon = new ThemedIcon (id),
                pixel_size = IMAGE_SIZE
            };
        }

        return image;
    }
}

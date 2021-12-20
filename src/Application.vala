/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Xavier Figueroa <xavierfigueroav@gmail.com>
 */

public class Application : Gtk.Application {
    public Application () {
        Object (
            application_id: "com.github.softweird.linguo",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_hbox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var stack = new Gtk.Stack ();
        stack.set_transition_type (Gtk.StackTransitionType.SLIDE_UP_DOWN);
        stack.set_transition_duration (500);

        var main_window = new Gtk.ApplicationWindow (this) {
            default_height = 450,
            default_width = 900,
            title = "Linguo"
        };

        var apps_hbox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        var layouts_hbox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

        stack.add_titled (apps_hbox, "box1", "Apps");
        stack.add_titled (layouts_hbox, "box2", "Layouts");

        var scrollable1 = new Gtk.ScrolledWindow (null, null);
        scrollable1.set_policy (Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
        scrollable1.add (new AppsGrid ());

        var scrollable2 = new Gtk.ScrolledWindow (null, null);
        scrollable2.set_policy (Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
        scrollable2.add (new AppsGrid ());

        var separator = new Gtk.Separator (Gtk.Orientation.VERTICAL);
        apps_hbox.pack_start (scrollable1, true, true, 0);
        apps_hbox.pack_start (separator, false, false, 0);
        apps_hbox.pack_start (scrollable2, true, true, 0);

        var switcher = new Gtk.StackSidebar ();
        switcher.set_stack (stack);

        main_hbox.pack_start (switcher, false, true, 0);
        main_hbox.pack_start (stack, true, true, 0);
        main_window.add (main_hbox);
        main_window.show_all ();
    }

    public static int main (string[] args) {
        return new Application ().run (args);
    }
}

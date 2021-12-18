/*
 * SPDX-License-Identifier: 
 * SPDX-FileCopyrightText: 2021 Xavier Figueroa <xavierfigueroav@gmail.com>
 */


public class MyApp : Gtk.Application {
    public MyApp () {
        Object (
            application_id: "com.github.softweird.linguo",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var label = new Gtk.Label ("Hello World!");

        var main_window = new Gtk.ApplicationWindow (this) {
            default_height = 300,
            default_width = 300,
            title = "Hello World"
        };

        main_window.add (label);
        main_window.show_all ();
    }

    public static int main (string[] args) {
        return new MyApp ().run (args);
    }
}

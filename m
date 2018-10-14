Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/2] pwm: lpss: Force runtime-resume on suspend on CHT devices
Date: Sun, 14 Oct 2018 17:12:00 +0200
Message-Id: <20181014151202.29955-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

Hi All,

Here are 2 more / new pwm-lpss fixes.

I've received a bug report that the recent ACPI-LPSS code changes which
properly order device resume on Cherry Trail so that the GFX0 _PS0 method
no longer exits with an error causes the backlight to flicker on some
Cherry Trail devices.

This series is the result of investigating this issue. On Cherry Trail
devices under Windows the PWM controller used for the backlight is
considered part of the GPU even though it is part of the LPSS block and
thus is an entirely different independent hardware unit.

Because of this on Cherry Trail the GPU's (GFX0 ACPI node) _PS3 and _PS0
ACPI methods save and restore the PWM controller registers.

After the recent fixes this save + restore of the PWM controller registers
is actually also happening under Linux.

If userspace blanks the screen before suspending, such as e.g. GNOME
does, then the PWM controller will be runtime-suspended when the suspend
starts. This causes the GFX0 _PS3 method to save a value of 0xffffffff
for the PWM control register and to restore this value on resume.
Note that the GPU's _PS0 method also puts the PWM controller in D0, so
this write of 0xffffffff does actually stick.

The first patch in this patch-set fixes this. This fix exposes another
issue, the pwm-lpss driver unconditionally sets the update bit when
pwm_apply gets called, even if nothing has changed. At least on
Cherry Trail this seems to cause the next update (which actually changes
something) to be ignored. The second patch fixes this issue.

Regards,

Hans

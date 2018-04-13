Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/2] pwm/ACPI: Fix LPSS PWM suspend/resume issues
Date: Fri, 13 Apr 2018 14:52:16 +0200
Message-Id: <20180413125218.7131-1-hdegoede@redhat.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

Hi All,

Here are 2 patches which together fix the LCD panel staying black
(backlight brightness 0) after a suspend / resume on some Bay Trail
devices. I guess these devices are unique in that their firmware
disables the LPSS PWM APB clock / reset bits on a suspend / resume.

The first patch is necessary to fix the second patch potentially
causing a regression on some devices. So I suggest that we merge both
patches through the pwm tree, with an ack from Rafael for the ACPI
bits. Rafael, can we have your ack for that please?

Regards,

Hans

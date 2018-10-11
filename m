Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 0/3] pwm: lpss: Check PWM powerstate after resume on Cherry Trail devices
Date: Thu, 11 Oct 2018 18:14:41 +0200
Message-Id: <20181011161444.328-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

Hi All,

As requested here is a new version of this series adding a patch exporting
acpi_device_get_power() and using that.

This means that the PWM changes now rely on an ACPI patch.

I've 3 other LPSS PWM changes in flight which all have already been
acked or reviewed by Andy. One option would be to merge the entire
series + the 3 patches through Rafael's PM tree. If we want to go that
route I can send out a new series with all 6 patches together to Rafael.

Another option would be to merge the single line ACPI change through the
PWM tree.

Rafael, Thierry how do you want to proceed with this? And if you prefer
for the changes to go through the other tree, may we have your Acked-by
for the patch(es) which would normally go in through your own tree ?

Regards,

Hans

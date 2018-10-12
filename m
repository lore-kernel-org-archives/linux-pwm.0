Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/6] pwm: Collected LPSS-pwm patches for 4.20
Date: Fri, 12 Oct 2018 12:12:23 +0200
Message-Id: <20181012101229.27805-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

Hi Thierry,

I've 3 different pwm-lpss patch-sets outstanding, 2 of which have seen
multiple revisions.

For your convenience here is a series which collects the latest version
of them all including all the acks and reviews they have received.

This series superceeds / replaces all my other outstanding pwm patches.

The first patch is an ACPI patch, which is a dependency for the fourth
patch in the series. This has an Acked-by from Rafael, indicating that
he is ok with merging this simple one-line patch through your PWM tree.

Regards,

Hans

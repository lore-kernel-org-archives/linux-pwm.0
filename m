Return-Path: <andriy.shevchenko@linux.intel.com>
Date: Sat, 6 Oct 2018 17:16:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] pwm: lpss: Check PWM powerstate after resume on
 Cherry Trail devices
Message-ID: <20181006141651.GW15943@smile.fi.intel.com>
References: <20180911173050.2374-1-hdegoede@redhat.com>
 <20180924091841.GG15943@smile.fi.intel.com>
 <02750104-3029-13df-7506-95416a89d68b@redhat.com>
 <2073706.oZqG2eVWq3@aspire.rjw.lan>
 <db4f6771-9ce3-9793-a2e4-b317909cd06b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db4f6771-9ce3-9793-a2e4-b317909cd06b@redhat.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

On Sat, Oct 06, 2018 at 10:55:41AM +0200, Hans de Goede wrote:
> On 03-10-18 11:22, Rafael J. Wysocki wrote:
> > On Monday, September 24, 2018 11:40:14 AM CEST Hans de Goede wrote:

> > Also, why don't you use acpi_device_get_power() instead of evaluating
> > _PSC directly?  It should make no difference if there are no power
> > resources, should it?

> 2) acpi_device_get_power() is not exported to modules

Do we have any side effects if we just export it?
I would think exporting is better than open coding.

-- 
With Best Regards,
Andy Shevchenko

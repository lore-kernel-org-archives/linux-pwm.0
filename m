Return-Path: <hdegoede@redhat.com>
Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] pwm: lpss: Check PWM powerstate after resume on
 Cherry Trail devices
References: <20180911173050.2374-1-hdegoede@redhat.com>
 <20180924091841.GG15943@smile.fi.intel.com>
 <02750104-3029-13df-7506-95416a89d68b@redhat.com>
 <2073706.oZqG2eVWq3@aspire.rjw.lan>
 <db4f6771-9ce3-9793-a2e4-b317909cd06b@redhat.com>
 <20181006141651.GW15943@smile.fi.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <bbd2a664-71cf-10aa-253d-944059b58c0f@redhat.com>
Date: Wed, 10 Oct 2018 13:14:36 +0200
MIME-Version: 1.0
In-Reply-To: <20181006141651.GW15943@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

Hi,

On 06-10-18 16:16, Andy Shevchenko wrote:
> On Sat, Oct 06, 2018 at 10:55:41AM +0200, Hans de Goede wrote:
>> On 03-10-18 11:22, Rafael J. Wysocki wrote:
>>> On Monday, September 24, 2018 11:40:14 AM CEST Hans de Goede wrote:
> 
>>> Also, why don't you use acpi_device_get_power() instead of evaluating
>>> _PSC directly?  It should make no difference if there are no power
>>> resources, should it?
> 
>> 2) acpi_device_get_power() is not exported to modules
> 
> Do we have any side effects if we just export it?
> I would think exporting is better than open coding.

acpi_device_get_power() does a lot more then just call the _PSC
method, while as explained we really just want the _PSC method
as that checks the actual D3 bit which we are interested in.

But as Rafael mentioned if the DSDT does not define power-resources
(which in the 3 DSDTs I just checked it doesn't for the PWM node) then
acpi_device_get_power() is equivalent.

So I guess I could change this, but I would prefer to stick with
the direct _PSC call.

Regards,

Hans

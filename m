From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 03/15] pwm: lpss: Add range limit check for the
 base_unit register value
Date: Mon, 8 Jun 2020 13:07:12 +0200
Message-ID: <90769dc0-3174-195b-34e0-ef4bb9d9b982@redhat.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-4-hdegoede@redhat.com>
 <20200608035023.GZ2428291@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200608035023.GZ2428291@smile.fi.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

On 6/8/20 5:50 AM, Andy Shevchenko wrote:
> On Sun, Jun 07, 2020 at 08:18:28PM +0200, Hans de Goede wrote:
>> When the user requests a high enough period ns value, then the
>> calculations in pwm_lpss_prepare() might result in a base_unit value of 0.
>>
>> But according to the data-sheet the way the PWM controller works is that
>> each input clock-cycle the base_unit gets added to a N bit counter and
>> that counter overflowing determines the PWM output frequency. Adding 0
>> to the counter is a no-op. The data-sheet even explicitly states that
>> writing 0 to the base_unit bits will result in the PWM outputting a
>> continuous 0 signal.
> 
> So, and why it's a problem?

Lets sya the user requests a PWM output frequency of 100Hz on Cherry Trail
which has a 19200000 Hz clock this will result in 100 * 65536 / 19200000 =
0.3 -> 0 as base-unit value. So instead of getting 100 Hz the user will
now get a pin which is always outputting low.

OTOH if we clamp to 1 as lowest value, the user will get 192000000 / 65536
= 292 Hz as output frequency which is as close to the requested value as
we can get while actually still working as a PWM controller.

>> base_unit values > (base_unit_range / 256), or iow base_unit values using
>> the 8 most significant bits, cause loss of resolution of the duty-cycle.
>> E.g. assuming a base_unit_range of 65536 steps, then a base_unit value of
>> 768 (256 * 3), limits the duty-cycle resolution to 65536 / 768 = 85 steps.
>> Clamp the max base_unit value to base_unit_range / 32 to ensure a
>> duty-cycle resolution of at least 32 steps. This limits the maximum
>> output frequency to 600 KHz / 780 KHz depending on the base clock.
> 
> This part I don't understand. Why we limiting base unit? I seems like a
> deliberate regression.

The way the PWM controller works is that the base-unit gets added to
say a 16 bit (on CHT) counter each input clock and then the highest 8
bits of that counter get compared to the value programmed into the
ON_TIME_DIV bits.

Lets say we do not clamp and allow any value and lets say the user
selects an output frequency of half the input clock, so base-unit
value is 32768, then the counter will only have 2 values:
0 and 32768 after that it will wrap around again. So any on time-div
value < 128 will result in the output being always high and any
value > 128 will result in the output being high/low 50% of the time
and a value of 255 will make the output always low.

So in essence we now only have 3 duty cycle levels, which seems like
a bad idea to me / not what a pwm controller is supposed to do.

So I decided to put a cut of at having at least 32 steps.

The mean reason I wrote this patch though is to avoid a base-unit
value of 0 which really results in a completely non working PWM
output. I personally believe clamping on the high side is a good
idea too. But if you are against that I can drop that part.

Note that the clamping on the high side will not affect the
primary user of the LPSS-pwm driver which is the i915 backlight
code, that never asks for such high frequencies.  But it could
help to avoid an user shooting themselves in the foot when using
the PWM on a dev board through the sysfs interface.

Regards,

Hans

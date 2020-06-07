From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: pwm/i915: Convert pwm-crc and i915 driver's PWM code to use the
 atomic PWM API
Date: Sun, 7 Jun 2020 20:15:46 +0200
Message-ID: <606dd687-f560-3798-afec-fbab8418d212@redhat.com>
References: <20200606202601.48410-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200606202601.48410-1-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi All,

I forgot the [PATCH 0/16] part of the subject here and I accidentally
left a patch adding some debugging printk-s in the series. I will
send out a v2 addressing this.

Regards,

Hans

On 6/6/20 10:25 PM, Hans de Goede wrote:
> Hi All,
> 
> This patch series converts the i915 driver's cpde for controlling the
> panel's backlight with an external PWM controller to use the atomic PWM API.
> 
> Initially the plan was for this series to consist of 2 parts:
> 1. convert the pwm-crc driver to support the atomic PWM API and
> 2. convert the i915 driver's PWM code to use the atomic PWM API.
> 
> But during testing I've found a number of bugs in the pwm-lpss and I
> found that the acpi_lpss code needs some special handling because of
> some ugliness found in most Cherry Trail DSDTs.
> 
> So now this series has grown somewhat large and consists of 4 parts:
> 
> 1. acpi_lpss fixes workarounds for Cherry Trail DSTD nastiness
> 2. various fixes to the pwm-lpss driver
> 3. convert the pwm-crc driver to support the atomic PWM API and
> 4. convert the i915 driver's PWM code to use the atomic PWM API
> 
> So we need to discuss how to merge this (once it passes review).
> Although the inter-dependencies are only runtime I still think we should
> make sure that 1-3 are in the drm-intel-next-queued (dinq) tree before
> merging the i915 changes. Both to make sure that the intel-gfx CI system
> does not become unhappy and for bisecting reasons.
> 
> The involved acpi_lpss and pwm drivers do not see a whole lot of churn,
> so we could just merge everything through dinq, or we could use immutable
> branch and merge those into dinq.
> 
> So Rafael and Thierry, can I either get your Acked-by for directly merging
> this into dinq, or can you provide an immutable branch with these patches?
> 
> This series has been tested (and re-tested after adding various bug-fixes)
> extensively. It has been tested on the following devices:
> 
> -Asus T100TA		BYT + CRC-PMIC PWM
> -Toshiba WT8-A		BYT + CRC-PMIC PWM
> -Thundersoft TS178	BYT + CRC-PMIC PWM, inverse PWM
> -Asus T100HA		CHT + CRC-PMIC PWM
> -Terra Pad 1061		BYT + LPSS PWM
> -Trekstor Twin 10.1	BYT + LPSS PWM
> -Asus T101HA		CHT + CRC-PMIC PWM
> -GPD Pocket		CHT + CRC-PMIC PWM
> 
> Regards,
> 
> Hans
> 

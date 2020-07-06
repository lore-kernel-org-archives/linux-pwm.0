From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 09/15] pwm: crc: Enable/disable PWM output on
 enable/disable
Date: Mon, 6 Jul 2020 23:03:45 +0200
Message-ID: <f1fb632d-3578-7dee-889f-71ee6787c637@redhat.com>
References: <20200620121758.14836-1-hdegoede@redhat.com>
 <20200620121758.14836-10-hdegoede@redhat.com>
 <20200622075509.v4jlvqeyjip6wr6c@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200622075509.v4jlvqeyjip6wr6c@taurus.defre.kleine-koenig.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, Shobhit Kumar <shobhit.kumar@intel.com>
List-Id: linux-pwm@vger.kernel.org

Hi,

On 6/22/20 9:55 AM, Uwe Kleine-König wrote:
> Hello,
> 
> [adding Shobhit Kumar <shobhit.kumar@intel.com> to Cc who is the author
> of this driver according to the comment on the top of the driver]
> 
> On Sat, Jun 20, 2020 at 02:17:52PM +0200, Hans de Goede wrote:
>> The pwm-crc code is using 2 different enable bits:
>> 1. bit 7 of the PWM0_CLK_DIV (PWM_OUTPUT_ENABLE)
>> 2. bit 0 of the BACKLIGHT_EN register
>>
>> So far we've kept the PWM_OUTPUT_ENABLE bit set when disabling the PWM,
>> this commit makes crc_pwm_disable() clear it on disable and makes
>> crc_pwm_enable() set it again on re-enable.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v3:
>> - Remove paragraph about tri-stating the output from the commit message,
>>    we don't have a datasheet so this was just an unfounded guess
> 
> I have the impression you spend quite some time with this driver trying
> to understand it.

Yes, my initial plan for this patch series was to just convert this driver
to atomic PWM, but it turned out to need a bit of TLC first.

> What I still think is a bit unfortunate is that there
> is quite some guesswork involved.

Actually for 99% of the changes I'm pretty sure they are correct.

This patch is the 1% where I'm not sure, and in this case I'm playing
it safe by keeping the code as is.

As the commit message tries to explain I strongly suspect that
bit 0 of the BACKLIGHT_EN register really drives a separate GPIO
pin on the PMIC which is earmarked as backlight-enable pin (many LCD
panels have both a pwm input for brightness-level and a separate
enable/disable pin).

If we can get information that my hunch here is correct then the
right thing to do would be to change things so that the PWM driver
stops poking bit 0 of the BACKLIGHT_EN register and this gets
done by the CRC GPIO driver instead. But the poking of that bit
is already happening now and since I'm not 100% sure that my hunch
is correct, the safe thing to do is to keep this as is.

Note that for the main consumer of the CRC PWM, the i915 driver
it does not matter. If we change that bit into a GPIO then the
i915 drv will need to be modified to drive the GPIO high / low when
enabling / disabling the panel. Just like it already enables/
disables the PWM when enabling / disabling the panel.

So the end result will still be bit 0 of the BACKLIGHT_EN register
going high/low on LCD panel enable/disable. So even if my hunch is
right functionality wise nothing will change. The code doing the
poking will be technically more correct, but that is all that we
would gain.

> I wonder if it would be possible to
> get the manual of that PWM. Do I understand correctly that this is IP
> from Intel? There are quite some Intel people on Cc; maybe someone can
> help/put in a good word/check and ack the changes?

IIRC last time I asked no one from the Intel folks on the Cc has access
to the Crystal Cove PMIC datasheet.

Regards,

Hans

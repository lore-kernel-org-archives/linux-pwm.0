From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 04/15] pwm: lpss: Fix off by one error in
 base_unit math in pwm_lpss_prepare()
Date: Mon, 8 Jun 2020 13:13:01 +0200
Message-ID: <c8a8d466-9b4a-9021-ca74-01d315e99117@redhat.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-5-hdegoede@redhat.com>
 <20200608035512.GA2428291@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20200608035512.GA2428291@smile.fi.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi,

On 6/8/20 5:55 AM, Andy Shevchenko wrote:
> On Sun, Jun 07, 2020 at 08:18:29PM +0200, Hans de Goede wrote:
>> According to the data-sheet the way the PWM controller works is that
>> each input clock-cycle the base_unit gets added to a N bit counter and
>> that counter overflowing determines the PWM output frequency.
>>
>> So assuming e.g. a 16 bit counter this means that if base_unit is set to 1,
>> after 65535 input clock-cycles the counter has been increased from 0 to
>> 65535 and it will overflow on the next cycle, so it will overflow after
>> every 65536 clock cycles and thus the calculations done in
>> pwm_lpss_prepare() should use 65536 and not 65535.
>>
>> This commit fixes this. Note this also aligns the calculations in
>> pwm_lpss_prepare() with those in pwm_lpss_get_state().
> 
> This one sounds like a bug which I have noticed on Broxton (but thought as a
> hardware issue). In any case it has to be tested on various platforms to see
> how it affects on them.

If you like at the datasheet / read my commit description then it
becomes obvious that because of the way the PWM controller works that
it takes the full 2^(base-unit-bits) for the counter to overflow,
not 2^(base-unit-bits) - 1. This will make a difference of a factor
65535/65536 in the output frequency which will be tricky to measure.

IOW I'm not sure we can really test if this helps, but it is
obviously the right thing to do and it aligns the pwm_apply code
with the pwm_get_state code which already does not have the - 1.

Regards,

Hans

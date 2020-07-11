From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 00/15] acpi/pwm/i915: Convert pwm-crc and i915 driver's
 PWM code to use the atomic PWM API
Date: Sat, 11 Jul 2020 15:46:55 +0200
Message-ID: <d9079987-1c98-7542-8900-b2cc7b17446f@redhat.com>
References: <20200708211432.28612-1-hdegoede@redhat.com>
 <20200709141407.GA226971@ravnborg.org>
 <fb370663-9efe-a820-2e57-d43d3af7828c@redhat.com>
 <20200711061901.njwx3xofo4awcflg@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200711061901.njwx3xofo4awcflg@pengutronix.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pwm@vger.kernel.org

Hi,

On 7/11/20 8:19 AM, Uwe Kleine-König wrote:
> Hi Hans,
> 
> On Thu, Jul 09, 2020 at 04:40:56PM +0200, Hans de Goede wrote:
>> On 7/9/20 4:14 PM, Sam Ravnborg wrote:
>>> On Wed, Jul 08, 2020 at 11:14:16PM +0200, Hans de Goede wrote:
>>>> Here is v4 of my patch series converting the i915 driver's code for
>>>> controlling the panel's backlight with an external PWM controller to
>>>> use the atomic PWM API. See below for the changelog.
>>>
>>> Why is it that i915 cannot use the pwm_bl driver for backlight?
>>> I have not studied the code - just wondering.
>>
>> The intel_panel.c code deals with 7 different types of PWM controllers
>> which are built into the GPU + support for external PWM controllers
>> through the kernel's PWM subsystem.
>>
>> pwm_bl will work for the external PWM controller case, but not for
>> the others. On top of that the intel_panel code integrates which
>> the video BIOS, getting things like frequency, minimum value
>> and if the range is inverted (0% duty == backlight brightness max).
>> I'm not even sure if pwm_bl supports all of this, but even if it
>> does the intel_panel code handles this in a unified manner for
>> all supported PWM controllers, including the ones which are
>> an integral part of the GPU.
> 
> pwm_bl handles inverted PWM just fine. I'm unsure what "integrates which
> the video BIOS" means,

Integrating with the video BIOS means reading the VBT (Video BIOS Tables)
and extracting info about which PWM controller to use, what frequency
to program the output at, minimum allowed duty-cycle and if the scale
is inverted.

> but I don't see how "handling 7 different types
> of PWM controllers explicitly and others using the PWM API" can be seen
> as "unified manner" compared to "provide a pwm driver for whatever might
> be in the GPU and then use generic code (PWM API, pwm_bl) to drive it".

Part of this is historical, the main x86 GPU drivers have always treated
backlight control as integral part of the display pipeline and in some
cases it really is, e.g. for eDP panels in some cases the backlight
is controlled through the DP aux channel, there is no PWM controller
(visible to the kernel involved). So the intel_panel.c code really
is a backlight-control de-multiplexer, picking the right "plugin"
to control the backlight, which may also be the eDP backlight control
code. Using a PWM controller supported by the PWM-core/class is just
one of the many supported "plugins".

Also the GPU currently is treated as a single device, not as a MFD
device, so we cannot have an isolated PWM driver. We could have code
inside the GPU driver which exports a PWM-controller to the PWM-core,
to then get a reference to the exported PWM-controller but that would
be very roundabout.

The devices which are using an external PWM controller are actually
the exception here, 99.9% of all devices use the GPU integrated PWM
controller.

Anyways changing over the other PWM-like controllers support by
the intel-panel code falls way outside of the scope of this
patch-set.

Regards,

Hans

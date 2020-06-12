From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: pwm/i915: Convert pwm-crc and i915 driver's PWM code to use the
 atomic PWM API
Date: Fri, 12 Jun 2020 19:04:51 +0200
Message-ID: <58972efb-003d-ca87-0637-ece4c93aeeb5@redhat.com>
References: <20200606202601.48410-1-hdegoede@redhat.com>
 <20200608143500.GX20149@phenom.ffwll.local>
 <20200611212144.i7ma7kriznidds4r@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39005 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726290AbgFLRFD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2020 13:05:03 -0400
Received: by mail-ed1-f72.google.com with SMTP id 92so3154584edl.8
        for <linux-pwm@vger.kernel.org>; Fri, 12 Jun 2020 10:04:54 -0700 (PDT)
In-Reply-To: <20200611212144.i7ma7kriznidds4r@taurus.defre.kleine-koenig.org>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Daniel Vetter <daniel@ffwll.ch>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi,

On 6/11/20 11:21 PM, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Jun 08, 2020 at 04:35:00PM +0200, Daniel Vetter wrote:
>> On Sat, Jun 06, 2020 at 10:25:45PM +0200, Hans de Goede wrote:
>>> Hi All,
>>>
>>> This patch series converts the i915 driver's cpde for controlling the
>>> panel's backlight with an external PWM controller to use the atomic PWM API.
>>>
>>> Initially the plan was for this series to consist of 2 parts:
>>> 1. convert the pwm-crc driver to support the atomic PWM API and
>>> 2. convert the i915 driver's PWM code to use the atomic PWM API.
>>>
>>> But during testing I've found a number of bugs in the pwm-lpss and I
>>> found that the acpi_lpss code needs some special handling because of
>>> some ugliness found in most Cherry Trail DSDTs.
>>>
>>> So now this series has grown somewhat large and consists of 4 parts:
>>>
>>> 1. acpi_lpss fixes workarounds for Cherry Trail DSTD nastiness
>>> 2. various fixes to the pwm-lpss driver
>>> 3. convert the pwm-crc driver to support the atomic PWM API and
>>> 4. convert the i915 driver's PWM code to use the atomic PWM API
>>>
>>> So we need to discuss how to merge this (once it passes review).
>>> Although the inter-dependencies are only runtime I still think we should
>>> make sure that 1-3 are in the drm-intel-next-queued (dinq) tree before
>>> merging the i915 changes. Both to make sure that the intel-gfx CI system
>>> does not become unhappy and for bisecting reasons.
>>
>> Simplest is if acpi acks the acpi patches for merging through
>> drm-intel.git. Second simplest is topic branch (drm-intel maintainers can
>> do that) with the entire pile, which then acpi and drm-intel can both pull
>> in.
>>
>> Up to the two maintainer teams to figure this one out.
> 
> I'm unclear about the dependencies

There is a runtime dependency of the i915 changes on the PWM changes
and since the intel-gfx folks use a lot of CI, we this need to get the
PWM changes into the drm-intel tree before the i915 changes can land.

> , but the changes to drivers/pwm need
> an ack (or processing) by the PWM team.

Of course, I asked for an Acked-by from the PWM team
(once this passes review) for merging this through
the drm-intel tree, as the i915 driver is the main
(only AFAIK) consumer of the PWMs controlled by these
2 drivers.  Daniel <snip>-ed that bit when he replied.

Regards,

Hans

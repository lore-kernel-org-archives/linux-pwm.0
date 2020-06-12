From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 09/15] pwm: crc: Enable/disable PWM output on
 enable/disable
Date: Fri, 12 Jun 2020 18:59:58 +0200
Message-ID: <1af668ef-7b42-340a-8aa2-f66c266ac6ef@redhat.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-10-hdegoede@redhat.com>
 <20200611222029.csyo2wxof7nuhjws@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33432 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbgFLRAF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2020 13:00:05 -0400
Received: by mail-ed1-f71.google.com with SMTP id f13so3149708edv.11
        for <linux-pwm@vger.kernel.org>; Fri, 12 Jun 2020 10:00:01 -0700 (PDT)
In-Reply-To: <20200611222029.csyo2wxof7nuhjws@taurus.defre.kleine-koenig.org>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

Hi,

On 6/12/20 12:20 AM, Uwe Kleine-König wrote:
> On Sun, Jun 07, 2020 at 08:18:34PM +0200, Hans de Goede wrote:
>> The pwm-crc code is using 2 different enable bits:
>> 1. bit 7 of the PWM0_CLK_DIV (PWM_OUTPUT_ENABLE)
>> 2. bit 0 of the BACKLIGHT_EN register
>>
>> So far we've kept the PWM_OUTPUT_ENABLE bit set when disabling the PWM,
>> this commit makes crc_pwm_disable() clear it on disable and makes
>> crc_pwm_enable() set it again on re-enable.
>>
>> This should disable the internal (divided) PWM clock and tri-state the
>> PWM output pin when disabled, saving some power.
> 
> It would be great if you could also document that disabling the PWM
> makes the output tri-state. There are a few drivers that have a
> "Limitations" section at their top. Describing that there (in the same
> format) would be the right place.
> 
> Also note that according to Thierry's conception getting a (driven)
> inactive output is the right thing for a disabled PWM.

Hmm, the tri-state thing is an assumption from my side and we
don't have any docs for this PWM controller, so I'm not sure at
all if that is true. So I think it will be better to just drop
the tri-state bit from the commit msg for the next version.

Regards,

Hans

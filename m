From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] pwm: bcm2835: Dynamically allocate base
Date: Fri, 13 Mar 2020 10:37:05 -0700
Message-ID: <773a00f4-178d-4d3e-a2d1-f82564457a0f@gmail.com>
References: <20200203213536.32226-1-f.fainelli@gmail.com>
 <08e2b640f0a7713d905295fc4f75df49617be6c1.camel@suse.de>
 <3b22decc-9ebd-3522-4fd7-e5721c8b25b2@gmail.com>
 <20200220210718.4vrn6u2c2remeuhm@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32871 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCMRhM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Mar 2020 13:37:12 -0400
In-Reply-To: <20200220210718.4vrn6u2c2remeuhm@pengutronix.de>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, linux-kernel@vger.kernel.org, "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, Scott Branden <sbranden@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Ray Jui <rjui@broadcom.com>, "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>



On 2/20/2020 1:07 PM, Uwe Kleine-König wrote:
> [Dropping Bart Tanghe from recipents as the address bounces]
> 
> Hello Thierry,
> 
> On Thu, Feb 20, 2020 at 11:14:00AM -0800, Florian Fainelli wrote:
>> On 2/4/20 1:17 AM, Nicolas Saenz Julienne wrote:
>>> On Mon, 2020-02-03 at 13:35 -0800, Florian Fainelli wrote:
>>>> The newer 2711 and 7211 chips have two PWM controllers and failure to
>>>> dynamically allocate the PWM base would prevent the second PWM
>>>> controller instance being probed for succeeding with an -EEXIST error
>>>> from alloc_pwms().
>>>>
>>>> Fixes: e5a06dc5ac1f ("pwm: Add BCM2835 PWM driver")
>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>> ---
>>>
>>> Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>
>> Thierry, is there any chance we can get this applied for an upcoming
>> 5.6-rcX? Thank you!
> 
> to assist you with patch sorting:
> 
> # revisions < v6 of "Convert period and duty cycle to u64"
> pwclient -s Superseded 1237020 1237019 1229049 1229050 1222396
> 
> # most of "Add support for Azoteq IQS620A/621/622/624/625" v5 isn't for pwm
> pwclient -s "Not Applicable" 1238908 1238907 1238906 1238904 1238903 1238901
> 
> # most of "Add support for Azoteq IQS620A/621/622/624/625" v4 isn't for pwm
> pwclient -s "Not Applicable" 1224598 1224597 1224596 1224594 1224593 1224592
> pwclient -s "Superseeded" 1224595
> 
> # "backlight: pwm_bl: Use gpiod_get_value_cansleep() to get initial
> # state" already applied by Lee Jones
> pwclient -s "Not Applicable" 1031586
> 
> # Problem resolved by Michal Vokáč
> pwclient -s "Rejected"  1059267
> 
> (Not sure "Rejected" is the right state.)

Thierry, can we get this patch included in v5.7? I have not seen it show
up in linux-next yet.

Thank you!
-- 
Florian

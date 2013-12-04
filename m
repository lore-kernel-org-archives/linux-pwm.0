From: Mike Dunn <mikedunn@newsguy.com>
Subject: Re: [PATCH RESEND v5 1/2] PWM: PXA: add device tree support to PWM
 driver
Date: Wed, 04 Dec 2013 10:21:55 -0800
Message-ID: <529F72C3.7060503@newsguy.com>
References: <1379791174-2369-1-git-send-email-mikedunn@newsguy.com> <1379791174-2369-2-git-send-email-mikedunn@newsguy.com> <20131203101714.GG21178@ulmo.nvidia.com> <529E26C9.30707@newsguy.com> <20131204092152.GL19943@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp.newsguy.com ([74.209.136.69]:49627 "EHLO smtp.newsguy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753952Ab3LDSWl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 4 Dec 2013 13:22:41 -0500
In-Reply-To: <20131204092152.GL19943@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>

On 12/04/2013 01:21 AM, Thierry Reding wrote:
> On Tue, Dec 03, 2013 at 10:45:29AM -0800, Mike Dunn wrote:
>> On 12/03/2013 02:17 AM, Thierry Reding wrote:
>>> On Sat, Sep 21, 2013 at 12:19:33PM -0700, Mike Dunn wrote:
>>>> This patch adds device tree support to the PXA's PWM driver.  Nothing
>>>> needs to be extracted from the device tree node by the PWM device.
>>>> Client devices need only specify the period; the per-chip index is
>>>> implicitly zero because one device node must be present for each PWM
>>>> output in use.  This approach is more convenient due to the wide
>>>> variability in the number of PWM channels present across the various PXA
>>>> variants, and is made possible by the fact that the register sets for
>>>> each PWM channel are segregated from each other.  An of_xlate() method
>>>> is added to parse this single-cell node.  The existing ID table is
>>>> reused for the match table data.
>>>>
>>>> Tested on a Palm Treo 680 (both platform data and DT cases).
>>>>
>>>> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 30 +++++++++++++
>>>>  drivers/pwm/pwm-pxa.c                             | 52 ++++++++++++++++++++++-
>>>>  2 files changed, 81 insertions(+), 1 deletion(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>>>
>>> Hi Mike,
>>>
>>> It looks like this fell through the cracks. Is this patch still the
>>> latest one you have? Should it still be applied?
>>>
>>> Thierry
>>>
>>
>> Hi Thierry,
>>
>> Funny I should hear from you about this today.... I just turned my attention
>> back to this today and noticed that it never made it into your for-next branch.
>>  Yes, it is the latest.  If the patch still applies cleanly, please feel free.
>> Otherwise, I'd be glad to rework it against something more recent.
> 
> I've applied it to my for-next branch (with some minor whitespace fixups
> and some tuning to how the OF match table is defined). I don't consider
> any of the changes risky, but it'd be great if you could still test the
> version that I pushed.


I just tested it... looks good.  Thanks again Thierry.  Thanks also Haojian.

Mike


From: Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: Re: [PATCH RESEND v5 1/2] PWM: PXA: add device tree support to PWM
 driver
Date: Wed, 04 Dec 2013 17:17:31 +0800
Message-ID: <529EF32B.90805@linaro.org>
References: <1379791174-2369-1-git-send-email-mikedunn@newsguy.com> <1379791174-2369-2-git-send-email-mikedunn@newsguy.com> <20131203101714.GG21178@ulmo.nvidia.com> <529E26C9.30707@newsguy.com> <529E8193.1040606@linaro.org> <20131204090312.GK19943@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38553 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378Ab3LDJRk (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Dec 2013 04:17:40 -0500
Received: by mail-pb0-f46.google.com with SMTP id md12so23057566pbc.19
        for <linux-pwm@vger.kernel.org>; Wed, 04 Dec 2013 01:17:39 -0800 (PST)
In-Reply-To: <20131204090312.GK19943@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mike Dunn <mikedunn@newsguy.com>, linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>


On 12/04/2013 05:03 PM, Thierry Reding wrote:
> On Wed, Dec 04, 2013 at 09:12:51AM +0800, Haojian Zhuang wrote:
>> On 12/04/2013 02:45 AM, Mike Dunn wrote:
>>> On 12/03/2013 02:17 AM, Thierry Reding wrote:
>>>> On Sat, Sep 21, 2013 at 12:19:33PM -0700, Mike Dunn wrote:
>>>>> This patch adds device tree support to the PXA's PWM driver.  Nothing
>>>>> needs to be extracted from the device tree node by the PWM device.
>>>>> Client devices need only specify the period; the per-chip index is
>>>>> implicitly zero because one device node must be present for each PWM
>>>>> output in use.  This approach is more convenient due to the wide
>>>>> variability in the number of PWM channels present across the various PXA
>>>>> variants, and is made possible by the fact that the register sets for
>>>>> each PWM channel are segregated from each other.  An of_xlate() method
>>>>> is added to parse this single-cell node.  The existing ID table is
>>>>> reused for the match table data.
>>>>>
>>>>> Tested on a Palm Treo 680 (both platform data and DT cases).
>>>>>
>>>>> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
>>>>> ---
>>>>>   Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 30 +++++++++++++
>>>>>   drivers/pwm/pwm-pxa.c                             | 52 ++++++++++++++++++++++-
>>>>>   2 files changed, 81 insertions(+), 1 deletion(-)
>>>>>   create mode 100644 Documentation/devicetree/bindings/pwm/pxa-pwm.txt
>>>> Hi Mike,
>>>>
>>>> It looks like this fell through the cracks. Is this patch still the
>>>> latest one you have? Should it still be applied?
>>>>
>>>> Thierry
>>>>
>>> Hi Thierry,
>>>
>>> Funny I should hear from you about this today.... I just turned my attention
>>> back to this today and noticed that it never made it into your for-next branch.
>>>   Yes, it is the latest.  If the patch still applies cleanly, please feel free.
>>> Otherwise, I'd be glad to rework it against something more recent.
>>>
>>> Also, we never got any ACKs for patch 2/2, which just adds the nodes to
>>> arch/arm/boot/dts/pxa27x.dtsi
>>> Any advice on whom to nudge?
>>>
>>> Thanks much!
>>> Mike
>>>
>> It's fine to me.
>>
>> Acked-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> I think it's customary to take DTS file updates through the architecture
> trees, so I think it'd be better if you took patch 2/2. There aren't any
> dependencies between both patches either.
>
> Thierry
OK. Let me handle this.

Regards
Haojian

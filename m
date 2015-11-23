From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH RESEND] pwm: ftm: fix clock enable/disable when using PM
Date: Mon, 23 Nov 2015 13:47:12 -0800
Message-ID: <702a8932e2fdd5c89fba04326cc732e8@agner.ch>
References: <1445142552-3530-1-git-send-email-stefan@agner.ch>
 <290ed017061ef41e1fe5c3fd5a523511@agner.ch>
 <20151123094550.GA28740@ulmo.nvidia.com>
 <ac544aefbcb6e609d4ea01f02441aa3e@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:60370 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbbKWVsk (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Nov 2015 16:48:40 -0500
In-Reply-To: <ac544aefbcb6e609d4ea01f02441aa3e@agner.ch>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 2015-11-23 13:40, Stefan Agner wrote:
> Thanks Thierry for looking into that!
> 
> Added Li as recipient to start discussion.

Yeah, kind of remember now, Li is not with Freescale anymore, at least
his address bounces:

The original message was received at Mon, 23 Nov 2015 14:50:20 -0700
from az84f-il1-il2-vlan904.am.freescale.net [192.88.158.118]

   ----- The following addresses had permanent fatal errors -----
<Li.Xiubo@freescale.com>
    (reason: 550 5.1.1 <Li.Xiubo@freescale.com>... User unknown)


I did not found a newer/updated email address.

I will send a v2 with the helper.

--
Stefan

> 
> Some comments below:
> 
> On 2015-11-23 01:45, Thierry Reding wrote:
>> On Wed, Nov 18, 2015 at 06:04:12PM -0800, Stefan Agner wrote:
>>> Thierry,
>>>
>>> I realized that this patch did not make it into 4.4-rc1, while others,
>>> IMHO less important patches which have been posted later (e.g. sunxi
>>> whitespace fixes) have made it! :-(
>>
>> The reason why I merged them is because they are low-risk, whereas this
>> patch of yours changes existing behaviour, and hasn't received any
>> feedback from anyone. So the choice that I need to make is to either
>> trust the original author to have tested the driver and it was working,
>> or you to have verified that it is still working after the patch on all
>> setups that it used to work on. The first option obviously carries the
>> least risk, and that's the reason why the patch hasn't been merged.
>>
>>> Anything wrong with that? Or am I on your spam list? Note that this is
>>> already a RESEND :-)
>>
>> If you want to get this merged, you should try to get some feedback from
>> at least the original author. Xiubo Li and I extensively discussed this
>> back at the time when he submitted the driver and we came up with the
>> current code as the best approach to making sure that clocks are on and
>> off when they should be. So if it's not working for you, I'm fine taking
>> the patch if Xiubo or somebody else has had the chance to look at it and
>> review or test it. So a Reviewed-by or Tested-by tag will go a long way
>> to convince me that it's safe to apply.
> 
> In mainline, the driver is only used in Freescale Vybrid device trees. I
> think most issues have been introduced with the patches adding suspend
> support:
> http://thread.gmane.org/gmane.linux.kernel/1806940
> 
> Not sure against what suspend/resume implementation Li created the
> patches, so far there is no suspend/resume implementation for Vybrid
> upstream. While working on Vybrid's low power mode LPSTOP3, I noticed
> the issues....
>  
>> Also you enumerate all the various bits that are broken, and it would
>> seem to me that they could each be fixed individually rather than go and
>> implement something completely different which might have undesirable
>> side-effects. Such an approach would also make it more likely for me to
>> merge the patch because it would hopefully be more obvious what is being
>> fixed and that it's a correct fix.
> 
> There are different issues addressed by one solution: Using the clock
> frameworks enable/disable counts... I looked through the code again, it
> is really quite hard to split it up. I could create one patch which only
> switches the PWM enable/disable part to clock framework counts, and
> leave the suspend/resume part broken. Than, in a second patch fix the
> suspend/resume part. But that sounds like the wrong approach to me
> too...
> 
> I took inspiration from other PWM drivers, I think the suspend/resume
> idea was from TI EHRPWM PWM driver. So this shouldn't be far off what
> others are doing.
> 
>>
>> It's not that I mind the rework, but I'd at least like for someone to
>> verify that it's all still working on existing setups. Now, I understand
>> that people can go missing, so if nobody were to give you a Reviewed-by
>> or Tested-by for a couple of weeks I'd even consider applying without,
>> but as it is, you didn't even Cc Xiubo on the patch, so he's likely
>> missed it entirely.
> 
> I have had Li in the initial email, don't know/remember why I removed
> him from the list in RESEND...  Will keep him in the loop.
> 
> Just realized that there is now a helper function for
> test_bit(PWMF_ENABLED,... Will send a v2 anyway then.
> 
> --
> Stefan

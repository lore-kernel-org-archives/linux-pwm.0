From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] pwm: brcmstb: Don't set can_sleep flag
Date: Tue, 03 Nov 2015 16:49:52 -0800
Message-ID: <56395630.1030405@gmail.com>
References: <1446545320.6627.0.camel@ingics.com> <20151104003153.GJ7274@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33027 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445AbbKDAuj (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Nov 2015 19:50:39 -0500
Received: by pabfh17 with SMTP id fh17so34115496pab.0
        for <linux-pwm@vger.kernel.org>; Tue, 03 Nov 2015 16:50:38 -0800 (PST)
In-Reply-To: <20151104003153.GJ7274@google.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Axel Lin <axel.lin@ingics.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, linux-pwm@vger.kernel.org

On 03/11/15 16:31, Brian Norris wrote:
> On Tue, Nov 03, 2015 at 06:08:40PM +0800, Axel Lin wrote:
>> The .can_sleep flag is used for some PWM controllers that can't be used
>> in atomic context. Not such case for this driver, so don't set the
>> can_sleep flag.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> 
> Looks sane to me, though I've never touched this driver.
> 
> Reviewed-by: Brian Norris <computersforpeace@gmail.com>
> 
> BTW just a comment from an outsider here, the "can sleep" terminology
> seems a bit misleading here. Just IMO of course, but saying something
> "can sleep" sounds like a permissive statement, when actually it's a
> restrictive statement being made by the driver (which is in this case
> unnecessarily restrictive). The "might sleep" terminology used in one
> other place would (again IMO) better communicate what I think is
> intended here.
> 
> Though this problem is most likely result of mindless copy-and-paste,
> it's possible that the terminology made it easier to gloss over. Or I
> could just be blowing smoke.

Well, in this particular case, I have to admit this was copy and paste
which resulted in setting can_sleep initially.

Now, I do agree that the terminology is a little confusing here. If you
look at the GPIO API there are gpio_*_cansleep() accessors, which in
their case, convey the correct meaning: the operation can/might sleep.

Should we prepare a coccinelle script which fixes that at least for the
PWM subsystem?
-- 
Florian

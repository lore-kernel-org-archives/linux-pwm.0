From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] pwm: mxs: set pwm_chip can_sleep flag
Date: Fri, 25 Apr 2014 16:11:11 +0200
Message-ID: <535A6CFF.2020800@i2se.com>
References: <1396956597-26159-1-git-send-email-shawn.guo@freescale.com> <5343FDD3.3070308@i2se.com> <20140408175904.GT29751@pengutronix.de> <20140408234243.GB13898@piout.net> <20140409082341.GV29751@pengutronix.de> <20140409100313.GA20704@piout.net> <20140409104652.GC9527@ulmo> <20140409143516.GW29751@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:51856 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbaDYOLo (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Apr 2014 10:11:44 -0400
In-Reply-To: <20140409143516.GW29751@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Shawn Guo <shawn.guo@freescale.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

Am 09.04.2014 16:35, schrieb Uwe Kleine-K=F6nig:
> Hello,
>
> On Wed, Apr 09, 2014 at 12:46:53PM +0200, Thierry Reding wrote:
>>
>> My preference would be simply d). Mostly because I don't like specia=
l
>> cases and especially because I don't see an advantage in special cas=
ing
>> 0 and full period duty cycles. That doesn't mean of course that driv=
ers
>> can't special case if they really want or have to.
> Well d' is just an optimisation, because if you have a duty cycle
> between 0 and full (exclusive) and no other means of syncronisation
> you cannot influence where pwm_disable stops the output, at low or hi=
gh.
>
> Do we have cases where pwm_disable makes the pin high-z? Or something
> else which violates the assumption "pwm_config(pwm, 0, period);
> pwm_disable(pwm); makes the pin 0"?
> =20
>> That said I've also been thinking about adding support for e), which
>> would allow atomically changing the duty cycle, period and polarity =
of a
>> channel. This might become necessary at some point.
> On i.MX28 you cannot change atomically, only program atomically. The
> current period will end regularily anyhow as programmed before. But
> maybe that's what you mean?!
>
> Best regards
> Uwe
>

i want to ask gently, if somebody working on this issue?

Regards,
Stefan Wahren

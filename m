From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6/6] hwmon: pwm-fan: Update the duty cycle inorder to
 control the pwm-fan
Date: Fri, 10 Apr 2015 10:58:01 -0700
Message-ID: <20150410175801.GA31499@roeck-us.net>
References: <CANAwSgSD52sDpP7NH2hhiZX-=LZF6Qo-X3enqsqM+5XAMfyP=Q@mail.gmail.com>
 <20150408165351.GA22846@roeck-us.net>
 <CANAwSgQbNV9QZ2bFGk6g+RyWW6f5iW4e8ii_5rJ4srv02L=L_Q@mail.gmail.com>
 <CANAwSgRSxj9frUHRXh3JwD+bpnFrj8WkpDMKHZn-OPmuCEgP7w@mail.gmail.com>
 <1428667201.22057.20.camel@collabora.co.uk>
 <CANAwSgQHi2-i8xHn+X+KTGg8HFpe6SPgkuSvuApJP3342N8+zQ@mail.gmail.com>
 <5527CB78.4040002@roeck-us.net>
 <1428672601.22057.25.camel@collabora.co.uk>
 <20150410135844.GA20147@ulmo.nvidia.com>
 <87h9snvqsf.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36800 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbbDJR6g (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Apr 2015 13:58:36 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YgdCO-000goL-G5
	for linux-pwm@vger.kernel.org; Fri, 10 Apr 2015 17:58:36 +0000
Content-Disposition: inline
In-Reply-To: <87h9snvqsf.fsf@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Anand Moon <linux.amoon@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Markus Reichl <m.reichl@fivetechno.de>

On Fri, Apr 10, 2015 at 01:25:52PM -0400, Ben Gamari wrote:
> Thierry Reding <thierry.reding@gmail.com> writes:
> 
> > On Fri, Apr 10, 2015 at 03:30:01PM +0200, Sjoerd Simons wrote:
> >> 
> >> Yes/no/maybe :). Imho this is something to clarify in the pwm API
> >> documentation. As currently all it says is: 
> >>   "pwm_disable - stop a PWM output toggling", 
> >> 
> >> Which is what the exynos driver does. 
> >> 
> >> Thierry, could you clearify what the intention is here? I'm happy to
> >> prepare a pwm driver patch if needed to solve this?
> >
> > I think the safest thing to do is for users to do both. You call
> > pwm_config() with a zero duty cycle to make it clear what the status is
> > that you want. Then you call pwm_disable() to state that you don't need
> > the output signal anymore, so that any clocks needed by the PWM can be
> > stopped. Doing so gives the driver the most information and should make
> > the user more resilient against any possible quirks in drivers.
> >
> It would be great if the documentation were more clear on this matter
> regardless. This is something I can imagine having to spend substantial
> amounts of time Googling whereas a simple note in the documentation would
> have removed all ambiguity.
> 
Especially since, in this case, the output signal _is_ still needed.
It appears that pwm_disable() is only expected to stop the clock, not
the signal itself.

Guenter

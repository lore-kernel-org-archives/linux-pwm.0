From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH v3 2/2] pwm-pca9685: Support changing the output frequency
Date: Mon, 20 Jul 2015 14:15:51 +0200
Message-ID: <20150720121550.GA26471@pqgruber.com>
References: <1437381369-8502-1-git-send-email-clemens.gruber@pqgruber.com>
 <1437381369-8502-3-git-send-email-clemens.gruber@pqgruber.com>
 <20150720093011.GQ29614@ulmo>
 <20150720094612.GA20084@pqgruber.com>
 <20150720095054.GB20084@pqgruber.com>
 <20150720095813.GU29614@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:34859 "EHLO
	mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbbGTMPy (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 08:15:54 -0400
Content-Disposition: inline
In-Reply-To: <20150720095813.GU29614@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

On Mon, Jul 20, 2015 at 11:58:14AM +0200, Thierry Reding wrote:
> On Mon, Jul 20, 2015 at 11:50:55AM +0200, Clemens Gruber wrote:
> > Do you think it would be a good idea to print something to the kernel log when
> > changing the prescaler frequency? At the moment I only print an error when it is
> > out of bounds.
> > To notify the users that the frequency of all channels changed and the duty
> > cycle values have been adjusted?
> 
> None of the users would actually notice the kernel log entry, so I don't
> think it makes much sense. One problem I see with this is that we might
> start to see some sort of ping-pong happening between various users of
> the PWMs of the same chip.
> 
> I guess it depends a bit on what the typical use-cases are for this
> chip. Is it usually used only for LEDs (the register names suggest it)?
> If so, how likely is it that people will want to drive them at different
> periods? If it's reasonable to require the same period for all of them,
> maybe it would be worth adding some sort of WARN_ON() or dev_warn() or
> something to notify integrators of this fact.

The typical use-cases are LEDs but my specific use case is controlling fluid
valves. I need one frequency per chip and only the duty cycle is changed
regularly (to open or close the valves).
The current version not only forces the user to 200 Hz and of course also to
having the same frequency for all channels as this is a hardware feature.

What's interesting is that the ON and OFF registers are just values from 0 to
4095 and only specify the on and off time ratio, independent of the prescaler.
So I think I do not even have to change the duty cycles, if the user changes the
prescaler, the ratio remains.
I'll just have to set the RESTART bit after changing the prescaler, then it will
come back up with the ON and OFF time ratios from before.

Or did you mean, the driver should update the duty cycle values, which could be
read from the duty_cycle file in the pwm sysfs interface?

Clemens

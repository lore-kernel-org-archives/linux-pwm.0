From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH v3 2/2] pwm-pca9685: Support changing the output frequency
Date: Mon, 20 Jul 2015 11:46:12 +0200
Message-ID: <20150720094612.GA20084@pqgruber.com>
References: <1437381369-8502-1-git-send-email-clemens.gruber@pqgruber.com>
 <1437381369-8502-3-git-send-email-clemens.gruber@pqgruber.com>
 <20150720093011.GQ29614@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:56141 "EHLO
	mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbGTJqP (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 05:46:15 -0400
Content-Disposition: inline
In-Reply-To: <20150720093011.GQ29614@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

On Mon, Jul 20, 2015 at 11:30:22AM +0200, Thierry Reding wrote:
> On Mon, Jul 20, 2015 at 10:36:09AM +0200, Clemens Gruber wrote:
> > Previously, period_ns and duty_ns were only used to determine the
> > ratio of ON and OFF time, the default frequency of 200 Hz was never
> > changed.
> > The PCA9685 however is capable of changing the PWM output frequency,
> > which is expected when changing the period.
> > 
> > This patch configures the prescaler accordingly, using the formula
> > and notes provided in the PCA9685 datasheet.
> > Bounds checking for the minimum and maximum frequencies, last updated
> > in revision v.4 of said datasheet, is also added.
> > 
> > The prescaler is only touched if the period changed, because we have to
> > put the chip into sleep mode to unlock the prescale register.
> > If it is changed, the PWM output frequency changes for all outputs,
> > because there is one prescaler per chip. This is documented in the
> > PCA9685 datasheet and in the comments.
> 
> I think the reason why the driver doesn't support changing the frequency
> is precisely because it has a per-chip prescaler. So you'd be changing
> the frequency from other all other users if one of the channels requests
> to do so. If I remember correctly there had been some discussion back at
> the time that this wasn't safe to do.
> 
> If you have to do this, I'd think you'd need to at least update the duty
> cycle of all other users according to the new period.

Hi, thanks for your feedback.

Yes, that's true. You'd have to set the prescaler first and then manually set
all duty cycle values. Although this is a hardware feature, I can understand
that this might be confusing.

I will send a v4 to update the duty cycle of all other users after the chip
woke up again!
(Using the ratio from duty cycle to old period to set the new duty cycle)

Clemens

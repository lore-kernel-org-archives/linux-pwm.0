From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH v4 0/2] pwm-pca9685: Bugfixes and prescaler support
Date: Fri, 14 Aug 2015 22:09:50 +0200
Message-ID: <20150814200949.GA1440@pqgruber.com>
References: <1437664742-23121-1-git-send-email-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:59082 "EHLO
	mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbbHNWJy (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Aug 2015 18:09:54 -0400
Content-Disposition: inline
In-Reply-To: <1437664742-23121-1-git-send-email-clemens.gruber@pqgruber.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 23, 2015 at 05:19:00PM +0200, Clemens Gruber wrote:
> Hi,
> 
> the first patch from this series contains bugfixes and the second patch
> adds support for changing the PWM output frequency of the PCA9685.
> 
> Regards,
> Clemens
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> Changes in v2:
> - Only put chip into sleep mode if the bounds checking succeeds
> 
> Changes in v3:
> - Fix checkpatch style warnings introduced in v2
> 
> Changes in v4:
> - Set RESTART bit. Now the duty cycle to period ratio stays the same
>   after only changing the period.
> - Added a comment at the start of the file pointing out that the chip
>   has only one prescaler and changing the period affects all outputs.
> 
> Clemens Gruber (2):
>   pwm-pca9685: Fix several driver bugs
>   pwm-pca9685: Support changing the output frequency
> 
>  drivers/pwm/pwm-pca9685.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 88 insertions(+), 1 deletion(-)
> 
> -- 
> 2.4.6
> 

Hi Thierry,

I addressed the issue you raised about keeping the duty cycle to period ratio
when changing the period. This is achieved in v4 by setting the RESTART bit,
which resumes the PWM output with the same duty_cycle to period ratio as before
but with the new period / prescaler value. I also added a comment at the
beginning of the file to remind implementers, that this driver has a chip-wide
prescaler.

Without those two patches, the driver is really broken. See my description in
patch 1/2 for a list of its bugs.

Could we please get those two patches into 4.3?

Thanks,
Clemens

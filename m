From: "Yang, Robert" <RYang@hach.com>
Subject: RE: [PATCH 1/1] PWM-atmel: Fixed a bug which set the pwm clock
 prescaler incorrectly. In the defect code the prescaler was always one more
 than expected value, which resulted in the pwm output with wrong frequency
 and duty cycle.
Date: Thu, 25 Sep 2014 14:44:48 +0000
Message-ID: <D68D4F79CA301E4CB7967E4AF0038407253158D1@DHRNASVXM01.danaher.org>
References: <1410384919-41303-1-git-send-email-ryang@hach.com>
 <20140925075508.GB11843@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bn1bon0085.outbound.protection.outlook.com ([157.56.111.85]:10193
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753011AbaIYPA6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 25 Sep 2014 11:00:58 -0400
In-Reply-To: <20140925075508.GB11843@ulmo>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, "hachyang@gmail.com" <hachyang@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nikolaus Voss <n.voss@weinmann-emt.de>

Hi Thierry,

I agree Nikolaus's fix is more efficient and works too.

Robert

-----Original Message-----
From: Thierry Reding [mailto:thierry.reding@gmail.com]
Sent: Thursday, September 25, 2014 1:55 AM
To: hachyang@gmail.com
Cc: linux-pwm@vger.kernel.org; linux-kernel@vger.kernel.org; Yang, Robert; Nikolaus Voss
Subject: Re: [PATCH 1/1] PWM-atmel: Fixed a bug which set the pwm clock prescaler incorrectly. In the defect code the prescaler was always one more than expected value, which resulted in the pwm output with wrong frequency and duty cycle.

On Wed, Sep 10, 2014 at 03:35:19PM -0600, hachyang@gmail.com wrote:
> From: ryang <ryang@hach.com>
>
> Signed-off-by: ryang <ryang@hach.com>
> ---
>  drivers/pwm/pwm-atmel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c index
> 6e700a5..2dca0bf 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -128,7 +128,8 @@ static int atmel_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>                       return -EINVAL;
>               }
>       }
> -
> +     /* Need to reduce the prescaler by 1 */
> +     pres--;
>       /* Calculate the duty cycles */
>       prd = div;
>       div *= duty_ns;
> --
> 1.9.1

I think this was fixed by a different patch by Nikolaus in a more direct way, see: https://lkml.org/lkml/2014/9/24/28

I've pushed that patch to the for-next branch of the PWM tree. Can you verify that the issue you were seeing is gone?

Thierry
Please be advised that this email may contain confidential information. If you are not the intended recipient, please notify us by email by replying to the sender and delete this message. The sender disclaims that the content of this email constitutes an offer to enter into, or the acceptance of, any agreement; provided that the foregoing does not invalidate the binding effect of any digital or other electronic reproduction of a manual signature that is included in any attachment.

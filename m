From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] backlight: pwm: don't call legacy pwm request for
 device defined in dt
Date: Sat, 11 Oct 2014 07:21:46 -0700
Message-ID: <20141011142146.GB11456@kroah.com>
References: <1413035186-11771-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1413035186-11771-2-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:56324 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbaJKOWt (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 11 Oct 2014 10:22:49 -0400
Content-Disposition: inline
In-Reply-To: <1413035186-11771-2-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, stable@vger.kernel.org

On Sat, Oct 11, 2014 at 04:46:25PM +0300, Vladimir Zapolskiy wrote:
> Platform PWM backlight data provided by board's device tree should be
> complete enough to successfully request a pwm device using pwm_get() API.
> 
> Based on initial implementation done by Dmitry Eremin-Solenikov.
> 
> Reported-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Bryan Wu <cooloney@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/video/backlight/pwm_bl.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>

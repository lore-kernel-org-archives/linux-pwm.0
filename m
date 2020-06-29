From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 1/4] pwm: bcm-iproc: Remove impossible comparison when
 validating duty cycle
Date: Mon, 29 Jun 2020 09:45:17 -0700
Message-ID: <3470e941-aa86-11a8-674b-5258a08fedb1@gmail.com>
References: <20200629124752.1018358-1-lee.jones@linaro.org>
 <20200629124752.1018358-2-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731250AbgF2TNC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 15:13:02 -0400
In-Reply-To: <20200629124752.1018358-2-lee.jones@linaro.org>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, bcm-kernel-feedback-list@broadcom.com



On 6/29/2020 5:47 AM, Lee Jones wrote:
> 'duty' here is an unsigned int, thus checking for <0 will always
> evaluate to false.
> 
> Fixes the following W=1 warning:
> 
>  drivers/pwm/pwm-bcm-iproc.c:147:12: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> 
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-pwm@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

And IPROC_PWM_DUTY_CYCLE_MIN is unused after remove this single use of
the define, if you also remove it you can add:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

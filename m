From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 2/4] pwm: bcm-kona: Remove impossible comparison when
 validating duty cycle
Date: Mon, 29 Jun 2020 09:45:31 -0700
Message-ID: <0db8ebc7-b75b-a74c-8852-b235daedaf82@gmail.com>
References: <20200629124752.1018358-1-lee.jones@linaro.org>
 <20200629124752.1018358-3-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731278AbgF2TNJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 15:13:09 -0400
In-Reply-To: <20200629124752.1018358-3-lee.jones@linaro.org>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com



On 6/29/2020 5:47 AM, Lee Jones wrote:
> 'dc' here is an unsigned long, thus checking for <0 will always
> evaluate to false.
> 
> Fixes the following W=1 warning:
> 
>  drivers/pwm/pwm-bcm-kona.c:141:35: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-pwm@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

And similar to patch #1, DUTY_CYCLE_HIGH_MIN now gets unused, so if you
remove it as well, you can add:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

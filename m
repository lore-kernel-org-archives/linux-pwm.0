Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730D8C7EE23
	for <linux-pwm@archiver.kernel.org>; Thu, 11 May 2023 14:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbjEKOft (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Thu, 11 May 2023 10:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238238AbjEKOfe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 11 May 2023 10:35:34 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BB02D59
        for <linux-pwm@vger.kernel.org>; Thu, 11 May 2023 07:34:54 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id A21F95FD0C;
        Thu, 11 May 2023 17:34:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1683815690;
        bh=4aqcbnYtmMYM6DF+qqc6A/zLY11dMjaBVIb3KYwKcAs=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=kQh7e2fjBiFc9d5WuMGnXSn3GxKHauY7o11uTXLbxpXcs6JCJrA3XFTlVbb2hRDtp
         5xLos42S2iUllEFKQmalIcwktDVcHrC8k/qZsBsAYY6pxGiaKQe0ZsQOBvt6qnprKL
         waZDbujSSA1iAVDhslFCk8fphcFr/2u/FBB+NSTzbcAqKPdCcXqeUTC2LD30mdDyJ7
         7Duc72ptdHtTCEkhRZNUvad2f0Iz/b0IhOT+RV9aLZ7yjpxi7UjtuHb45ELw0RAfun
         9pys3TXsGupyv4dx/4GzGcfgZqQtBhWlxX531jZlffVO9QPhOCsQFXcEtsPDwKltWa
         zIgYt/W3GP1YA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 11 May 2023 17:34:50 +0300 (MSK)
Date:   Thu, 11 May 2023 17:34:49 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Heiner Kallweit <hkallweit1@gmail.com>
CC:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v3] pwm: meson: modify and simplify calculation in
 meson_pwm_get_state
Message-ID: <20230511143449.lcreswddwqe4c5zb@CAB-WSD-L081021>
References: <23fe625e-dc23-4db8-3dce-83167cd3b206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23fe625e-dc23-4db8-3dce-83167cd3b206@gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/11 10:21:00 #21259776
X-KSMG-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, May 02, 2023 at 10:33:42PM +0200, Heiner Kallweit wrote:
> I don't see a reason why we should treat the case lo < hi differently
> and return 0 as period and duty_cycle. The current logic was added with
> c375bcbaabdb ("pwm: meson: Read the full hardware state in
> meson_pwm_get_state()"), Martin as original author doesn't remember why
> it was implemented this way back then.
> So let's handle it as normal use case and also remove the optimization
> for lo == 0. I think the improved readability is worth it.
> 
> Fixes: c375bcbaabdb ("pwm: meson: Read the full hardware state in meson_pwm_get_state()")
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - improve commit description
> v3:
> - make patch a fix
> ---
>  drivers/pwm/pwm-meson.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 5732300eb..3865538dd 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -351,18 +351,8 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	channel->lo = FIELD_GET(PWM_LOW_MASK, value);
>  	channel->hi = FIELD_GET(PWM_HIGH_MASK, value);
>  
> -	if (channel->lo == 0) {
> -		state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
> -		state->duty_cycle = state->period;
> -	} else if (channel->lo >= channel->hi) {
> -		state->period = meson_pwm_cnt_to_ns(chip, pwm,
> -						    channel->lo + channel->hi);
> -		state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm,
> -							channel->hi);
> -	} else {
> -		state->period = 0;
> -		state->duty_cycle = 0;
> -	}
> +	state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->lo + channel->hi);
> +	state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
>  
>  	state->polarity = PWM_POLARITY_NORMAL;
>  
> -- 
> 2.40.0

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

-- 
Thank you,
Dmitry

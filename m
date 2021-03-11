Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0A8C433E6
	for <linux-pwm@archiver.kernel.org>; Thu, 11 Mar 2021 21:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C97264E44
	for <linux-pwm@archiver.kernel.org>; Thu, 11 Mar 2021 21:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhCKVGt (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Thu, 11 Mar 2021 16:06:49 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:35359 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230286AbhCKVGj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 11 Mar 2021 16:06:39 -0500
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Mar 2021 13:06:39 -0800
X-QCInternal: smtphost
Received: from gurus-linux.qualcomm.com (HELO gurus-linux.localdomain) ([10.46.162.81])
  by ironmsg04-sd.qualcomm.com with ESMTP; 11 Mar 2021 13:06:39 -0800
Received: by gurus-linux.localdomain (Postfix, from userid 383780)
        id 58A6F19F4; Thu, 11 Mar 2021 13:06:39 -0800 (PST)
Date:   Thu, 11 Mar 2021 13:06:39 -0800
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: soften potential loss of precision in compat code
Message-ID: <20210311210639.GA29363@codeaurora.org>
References: <20210308092322.24502-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308092322.24502-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 08, 2021 at 10:23:22AM +0100, Uwe Kleine-König wrote:
>  		if (state->period != pwm->state.period ||
>  		    state->duty_cycle != pwm->state.duty_cycle) {
> +			int duty_cycle, period;
> +
> +			if (state->period < INT_MAX)
> +				period = state->period;
> +			else
> +				period = INT_MAX;

Using a MIN() macro here might improve readability:
	period = MIN(state->period, INT_MAX);
> +
> +			if (state->duty_cycle < INT_MAX)
> +				duty_cycle = state->duty_cycle;
> +			else
> +				duty_cycle = INT_MAX;

Same here.

> +
>  			err = chip->ops->config(pwm->chip, pwm,
> -						state->duty_cycle,
> -						state->period);
> +						duty_cycle, period);
>  			if (err)
>  				return err;
>  
> -- 
> 2.30.1
> 

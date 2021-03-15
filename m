Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A689C433E0
	for <linux-pwm@archiver.kernel.org>; Mon, 15 Mar 2021 02:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D5964E46
	for <linux-pwm@archiver.kernel.org>; Mon, 15 Mar 2021 02:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhCOCCa (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Sun, 14 Mar 2021 22:02:30 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:59895 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229866AbhCOCCM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Mar 2021 22:02:12 -0400
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Mar 2021 19:02:12 -0700
X-QCInternal: smtphost
Received: from gurus-linux.qualcomm.com (HELO gurus-linux.localdomain) ([10.46.162.81])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 14 Mar 2021 19:02:12 -0700
Received: by gurus-linux.localdomain (Postfix, from userid 383780)
        id 1786719B3; Sun, 14 Mar 2021 19:02:12 -0700 (PDT)
Date:   Sun, 14 Mar 2021 19:02:11 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: Soften potential loss of precision in compat code
Message-ID: <20210315020211.GB6138@codeaurora.org>
References: <20210312212119.1342666-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210312212119.1342666-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Just a minor comment:

On Fri, Mar 12, 2021 at 10:21:19PM +0100, Uwe Kleine-König wrote:
> The legacy callback .config() only uses int for period and duty_cycle
> while the corresponding values in struct pwm_state are u64. To prevent
> that a value bigger than INT_MAX is discarded to a very small value,
> explicitly check for big values and pass INT_MAX instead of discarding.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> compared to (implicit) v1 I added a comment and used min instead of open
> coding the calculation.
> 
> Best regards
> Uwe
> 
>  drivers/pwm/core.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 4b3779d58c5a..7d0266bc5fcb 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -605,9 +605,18 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
>  
>  		if (state->period != pwm->state.period ||
>  		    state->duty_cycle != pwm->state.duty_cycle) {
> +			int duty_cycle, period;
> +
> +			/*
> +			 * The legacy callbacks use only (signed!) int for
> +			 * period and duty_cycle compared to u64 in struct
> +			 * pwm_state. So clamp the values to INT_MAX.
> +                         */

Minor: misaligned end of comment block. Other than that, looks good to
me. You may add my Acked-by to your v3 once this is fixed.

Acked-by: Guru Das Srinagesh <gurus@codeaurora.org>

Guru Das.
